FROM ffeldhaus/docker-xpra-html5-opengl-minimal

LABEL version="0.2"
LABEL maintainer="florian.feldhaus@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

# install SuperTuxKart
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg && \
    UBUNTU_VERSION=$(cat /etc/os-release | grep UBUNTU_CODENAME | sed 's/UBUNTU_CODENAME=//') && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AEC3B92F669B86354C7D5E676D3B959722E58263 && \
    echo "deb http://ppa.launchpad.net/stk/dev/ubuntu $UBUNTU_VERSION main" >> /etc/apt/sources.list.d/supertuxkart.list && \
    apt-get install -y supertuxkart && \
    apt-get remove -y --purge gnupg && \
    apt-get autoremove -y --purge && \
    rm -rf /var/lib/apt/lists/*

CMD ["vglrun","-d","/dev/dri/card0","/usr/games/supertuxkart"]