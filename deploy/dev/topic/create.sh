#!/bin/sh

#####################################################################
############################### topic ###############################

# authentication service: user login
gcloud beta pubsub topics create reactivesw-dev-customer-login
# category service: delete category
gcloud beta pubsub topics create reactivesw-dev-category-deleted
# order service: create order
gcloud beta pubsub topics create reactivesw-dev-order-created
# inventory service: reserve inventory
gcloud beta pubsub topics create reactivesw-dev-inventory-reserved
# payment service: pay
gcloud beta pubsub topics create reactivesw-dev-payment-payed


#####################################################################
########################### subscription ############################

# cart service: subscribe user login event for merge cart
gcloud beta pubsub subscriptions create --topic reactivesw-dev-customer-login dev-customer-cart-merge
# product service: subscribe delete category event for delete relationship between product and category
gcloud beta pubsub subscriptions create --topic reactivesw-dev-category-deleted dev-product-category-deleted
# inventory service: subscribe create order event for reserve inventory
gcloud beta pubsub subscriptions create --topic reactivesw-dev-order-created dev-inventory-order-reserve
# payment service: subscribe create order event for pay
gcloud beta pubsub subscriptions create --topic reactivesw-dev-order-created dev-payment-order-pay
# order service: subscribe reserve inventory event for change order status
gcloud beta pubsub subscriptions create --topic reactivesw-dev-inventory-reserved dev-inventory-order-reserved
# order service: subscribe pay event for change order status
gcloud beta pubsub subscriptions create --topic reactivesw-dev-payment-payed dev-payment-order-payed