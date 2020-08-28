FROM ffeldhaus/docker-xpra-html5-opengl

LABEL version="0.1"
LABEL maintainer="florian.feldhaus@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

# install SuperTuxKart
RUN apt-get update && apt-get install -y supertuxkart

# copy xpra config file
COPY ./xpra.conf /etc/xpra/xpra.conf

# add tux user
RUN useradd --create-home --shell /bin/bash tux --groups xpra
USER tux
WORKDIR /home/tux

CMD ["vglrun","-d","/dev/dri/card0","/usr/games/supertuxkart"]