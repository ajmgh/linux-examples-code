#!/bin/sh

# Software version
BUILDTIME=`date +%Y%m%d`
TARGET_TAR_NAME=store_resource_$BUILDTIME.tar.gz
if [ "$1" = "1024" ] ; then
    TARGET_TAR_NAME=store_resource_1024_$BUILDTIME.tar.gz
fi
echo $TARGET_TAR_NAME

TOP=`pwd`
PACKAGE_PATH=$TOP/store_resource

rm -rf $PACKAGE_PATH/widgetlist_bak.xml
cp -rf $PACKAGE_PATH/widgetlist.xml $PACKAGE_PATH/widgetlist_bak.xml

SDK_EXCLUDE="--exclude=.svn     \
        --exclude=*.bak  \
        --exclude=Thumbs.db"

tar zcvf $TARGET_TAR_NAME $SDK_EXCLUDE store_resource

MD5TMP1=`md5sum $TARGET_TAR_NAME`
echo -ne "$MD5TMP1\n" > md5info


