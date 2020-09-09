# Docker image which makes SuperTuxKart available via HTML5 using Xpra

This docker image provides remote access to [SuperTuxKart](https://supertuxkart.net/) using [Xpra](https://xpra.org/) with HTML5 based web client listening on port 14500 for websocket connections.

By default, the container uses the default self-signed certificate to offer SSL. If you want to specify your own certificate, you can overwrite the default SSL certificate with the docker parameter similar to --mount type=bind,source="$(pwd)"/ssl-cert.pem,target=/etc/xpra/ssl-cert.pem,readonly (make sure to put the ssl-cert.pem file in the current folder or modify the source path).

By default, Xpra can only be accessed using a password. The default password is xpra, but can be changed by setting the environment variable XPRA_PW (e.g. using the `docker run` parameter `-e XPRA_PW=mypassword`).

It is useful to automatically restart the container on failures using the `--restart unless-stopped` parameter.

A container using the image can be started with:

```sh
docker run ffeldhaus/docker-supertuxkart
```

Running the image will results in multiple warnings and error messages to be shown from xpra as xpra is trying to use a lot of recommended dependencies which are not included in this image.
