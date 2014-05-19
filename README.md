# NGINX config boilerplate

## SSL setup

### Generate dhparam.pem file

`openssl dhparam -out ssl/dhparam.pem 2048`

### Generate private key and csr

**Generate private key:**

`openssl genrsa -out ssl/example.com.key 2048`

**Verify created certificate content**

`openssl rsa -text -in ssl/example.com.key`

**Generate certificate signing request**

`openssl req -new -key ssl/example.com.key -out example.com.csr`

**Verify created csr content**

`openssl req -in example.com.csr -noout -text`

Then send created `.csr` file (only) to your certificate authority.

**Create certificate chain**

After this, your CA should send you signed `.crt` file and intermediate certificate.
In some cases you should find this certificate on the CA website byself.
Then you will need to chain this certificates:

`cat tmp/example.com.crt tmp/intermediate.crt > example.com.crt`

**Verify installed certificate**

If nginx don't throw any error run:

`openssl s_client -connect example.com:443`

If you see your certificate chain: you are ready to go!

## Additional tools

https://github.com/lebinh/ngxtop

## Required modules

* ngx_http_gzip_static_module
* ngx_http_spdy_module
