#!/bin/bash

# Steps
# run npm install in current directory i.e. OpenWrap repo
# run npm install in Prebid.js repo ( accept path for the same ? )
# run sym links for node_modules folder
# run build.sh with arguments accepted while executing this script

if [ $# -eq 0 ]
  then
    echo " No arguments supplied"
    echo " Provide prebid repo path using -p flag"
    echo " Provide build mode using -m flag"
    echo " Example: ./init-build.sh -p \"../Prebid.js\" -m \"build\" "
    exit 1
fi

while getopts ":p:m:" opt; do
  case $opt in
    p) prebid_path="$OPTARG"
    ;;
    m) mode="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ -z $prebid_path ]
  then
        echo "Please provide appropriate Prebid.js repo path "
fi

if [ -z $mode ]
  then
        echo "Please provide appropriate mode argument "
fi

#echo "%s %s " "$prebid_path" "$mode"
OpenWrapNodeModules="${GLOBAL_OPENWRAP_PKG_JSON_DIR}/node_modules/"

# echo "$OpenWrapNodeModules"

function prebidNpmInstall() {
  # echo "$1"
  cd $1
  PrebidJSNodeModules="${GLOBAL_PREBID_PKG_JSON_DIR}/node_modules/"
  # echo $PrebidJSNodeModules
  ln -s "$PrebidJSNodeModules" "./node_modules"
  npm install
  cd ../OpenWrap/
}

#cat file.txt

#echo $LOGNAME

ln -s "$OpenWrapNodeModules" "./node_modules"

npm install

prebidNpmInstall $prebid_path

#cat file.txt


./build.sh --prebidpath=$prebid_path --mode=$mode

