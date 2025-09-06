#!/bin/bash

set -x


FORGE_VERSION=1.20.1-47.4.6
cd /data

if ! [[ "$EULA" = "false" ]] || grep -i true eula.txt; then
	echo "eula=true" > eula.txt
else
	echo "You must accept the EULA by in the container settings."
	exit 9
fi

if ! [[ -f Ozone-Skyblock-Reborn_Server_1.19.zip ]]; then
	rm -fr config defaultconfigs global_data_packs global_resource_packs mods packmenu Ozone-Skyblock-Reborn_Server_*.zip
	curl -Lo Ozone-Skyblock-Reborn_Server_1.19.zip 'https://edge.forgecdn.net/files/6917/148/Ozone%20Skyblock%20Reborn-1.19.zip' 
	unzip -u -o Ozone-Skyblock-Reborn_Server_1.19.zip -d /data
	curl -Lo forge-${FORGE_VERSION}-installer.jar http://files.minecraftforge.net/maven/net/minecraftforge/forge/$FORGE_VERSION/forge-$FORGE_VERSION-installer.jar
	java -jar forge-${FORGE_VERSION}-installer.jar --installServer
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' > ops.txt
fi
if [[ -n "$ALLOWLIST" ]]; then
    echo $ALLOWLIST | awk -v RS=, '{print}' > white-list.txt
fi


./run.sh
