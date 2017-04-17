FROM postgres:9.6
COPY ./create_db.sh     /docker-entrypoint-initdb.d/20-create_db.sh
COPY *.sql /docker-entrypoint-initdb.d/
RUN chmod a+r /docker-entrypoint-initdb.d/*