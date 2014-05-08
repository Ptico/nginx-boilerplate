# NGINX config boilerplate

## SSL setup

### Generate dhparam.pem file

`openssl dhparam -out ssl/dhparam.pem 2048`

### Generate private key and csr

`openssl genrsa -out ssl/example.com.key 2048`

`openssl req -new -key ssl/example.com.key -out example.com.csr`

## Required modules

* ngx_http_gzip_static_module
* ngx_http_spdy_module
