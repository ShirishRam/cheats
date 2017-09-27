#!/bin/bash
#title           :create_basic_module.sh
#description     :This script will create a basic Magento 2 module
#author		 :ShirishRam
#date            :2017-09-22
#version         :0.1
#usage		 :./create_basic_module.sh -v <Vendor_Name> -m <Module_Name> [-s <Module_Version>] [-d <Module_Description>]
#notes           :Install Vim and Emacs to use this script.
#bash_version    :4.3.11(1)-release
#==============================================================================

usage() { echo "Usage: $0 -v <Vendor_Name> -m <Module_Name> [-s <Module_Version>] [-d <Module_Description>]" 1>&2; exit 1; }

while getopts ":v:m:s:d" o; do
	case "${o}" in
		v) VENDOR_NAME=${OPTARG} ;;
		m) MODULE_NAME=${OPTARG} ;;
		s) MODULE_VERSION=${OPTARG} ;;
		d) MODULE_DESCRIPTION=${OPTARG} ;;
		*) usage ;;
	esac
done

if [ -z "${VENDOR_NAME}" ] || [ -z "${MODULE_NAME}"  ]; then
	usage
fi

if [ -z "${MODULE_VERSION}" ]; then
	MODULE_VERSION="1.0.0"
fi
if [ -z "${MODULE_DESCRIPTION}" ]; then
	MODULE_DESCRIPTION="Magento 2 module"
fi

COMPOSER_VENDOR_NAME=$(echo "$VENDOR_NAME" | tr '[:upper:]' '[:lower:]')
COMPOSER_MODULE_NAME=$(echo "$MODULE_NAME" | tr '[:upper:]' '[:lower:]')

DIRECTORY="app/code/${VENDOR_NAME}/${MODULE_NAME}"

MODULE_FULL_NAME="${VENDOR_NAME}_${MODULE_NAME}"

if [ -d "$DIRECTORY" ]; then
	echo "ERROR: Directory '$DIRECTORY' already exists"
	exit
fi

mkdir -p $DIRECTORY
touch $DIRECTORY/registration.php
touch $DIRECTORY/composer.json
mkdir -p $DIRECTORY/etc
touch $DIRECTORY/etc/module.xml

echo "<?php
\Magento\Framework\Component\ComponentRegistrar::register(
    \Magento\Framework\Component\ComponentRegistrar::MODULE,
    '$MODULE_FULL_NAME',
    __DIR__
);" >> $DIRECTORY/registration.php

echo "{
  \"name\": \"$COMPOSER_VENDOR_NAME/module-$COMPOSER_MODULE_NAME\",
  \"description\": \"$MODULE_DESCRIPTION\",
  \"type\": \"magento2-module\",
  \"version\": \"$MODULE_VERSION\",
  \"autoload\": {
    \"files\": [
      \"registration.php\"
    ],
    \"psr-4\": {
      \"$(printf '%q' "$VENDOR_NAME\\$MODULE_NAME")\": \"\"
    }
  }
}" >> $DIRECTORY/composer.json

echo "<?xml version=\"1.0\"?>
<config xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"urn:magento:framework:Module/etc/module.xsd\">
    <module name=\"$MODULE_FULL_NAME\" setup_version=\"$MODULE_VERSION\"/>
</config>" >> $DIRECTORY/etc/module.xml
