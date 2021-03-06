#!/bin/bash
if [ ! -d "/dev/dri" ];then
    echo "ERROR: Directory /dev/dri does not exists, likely the GPU is not available to container."
    exit 1
fi
# ensure that xpra user is part of vglusers group which must have been set for /dev/dri/card0
DRI_CARD_GROUP_NAME=$(ls -l /dev/dri/card* | head -1 | awk '{print $4}')
DRI_CARD_GID=$(ls -ln /dev/dri/card* | head -1 | awk '{print $4}')
groupadd -f -g $DRI_CARD_GID $DRI_CARD_GROUP_NAME
DRI_RENDER_GROUP_NAME=$(ls -l /dev/dri/render* | head -1 | awk '{print $4}')
DRI_RENDER_GID=$(ls -ln /dev/dri/render* | head -1 | awk '{print $4}')
groupadd -f -g $DRI_RENDER_GID $DRI_RENDER_GROUP_NAME
usermod --groups $DRI_CARD_GID,$DRI_RENDER_GID --append xpra
# start xpra as xpra user with command specified in dockerfile as CMD or passed as parameter to docker run
CMD="XPRA_PASSWORD=$XPRA_PASSWORD /usr/bin/xpra start --daemon=no --start-child-on-connect='$@'"
runuser -l xpra -c "$CMD"