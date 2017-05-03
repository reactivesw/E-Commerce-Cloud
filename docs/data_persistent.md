# Kubernetes Persistent Volume for Postgres

## 1. Disk

Use gcloud command to create a data disk:

```shell
gcloud compute disks create pg-data-disk --size 50GB
```

## 2. Persistent Volume

Create persistent volume by following file:
data_pv.yaml

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pg-data-volume
  namespace: dev
  labels:
    name: pg-data-volume
spec:
  capacity:
    storage: 50Gi
  accessModes:
    - ReadWriteOnce
  gcePersistentDisk:
    fsType: ext4
    pdName: pg-data-disk
```

Use kubectl command to create persistent volume:

```shell
kubectl create -f data_pv.yaml
```

## 3. Persistent Volume Claim

Create persistent volume claim by following file:
data_pvc.yaml

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: pg-data-claim
  namespace: dev
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
```

Use kubectl command to create persistent volume claim:

```shell
kubectl create -f data_pvc.yaml
```

### 4. Use Persistent Volume Claim in Postgres Deployment

In postgres deployment yaml file, add `volumeMounts` and `volumes`:

```yaml
kind: Deployment
  apiVersion: extensions/v1beta1
  metadata:
    name: postgres-data
    namespace: dev
  spec:
    replicas: 1
    template:
      metadata:
        labels:
          name: postgres-data
      spec:
        containers:
        - name: postgres-data
          image: reactivesw/postgres:0.0.1
          imagePullPolicy: Always
          ports:
          - containerPort: 5432
          volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgres-data
          env:
          - name: POSTGRES_USER
            value: postgres
          - name: POSTGRES_PASSWORD
            value: root
          - name: PGDATA
            value: /var/lib/postgresql/data/pgdata
        volumes:
          - name: postgres-data
            persistentVolumeClaim:
              claimName: pg-data-claim
```