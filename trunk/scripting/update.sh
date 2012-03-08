#! /bin/sh

##########################
### Variables defined ####
##########################
if [ "$2" = "6i78" ] ; then
    URL_DEMO_BOARD=http://10.3.40.12/test/LS30i_image/update_850/Demo_board
fi

if [ "$2" = "" ] ; then
    URL_DEMO_BOARD=http://10.3.40.12/test/LS30i_image/update_lcd6i48/Demo_board
fi	

URL_RESOURCE=http://10.3.40.12/test/LS30i_image/store_resource_all_lcd850_6i78/latest
URL_RESOURCE_RELEASE=http://10.3.40.12/test/LS30i_image/store_resource_all_lcd850_6i78/release/RC_V1

WEBKIT=webkit-resource.tar.gz
WIDGET=widget-resource.tar.gz
STORE=store_resource.tar.gz

RELEASE_WEBKIT=webkit-resource-release2dmt-0412.tgz
RELEASE_WIDGET=widget-resource_20110328.tar.gz
RELEASE_STORE=store_resource_20110421.tar.gz

##############################
# MSTAR UPDATE               #
##############################
if [ "$1" = "1" ] ; then
		echo UPDATE Demo_board ... !
		killall -9 autorun
		rm -rf /applications/bin/Demo_board
		wget $URL_DEMO_BOARD -P /applications/bin/			
		chmod 755 /applications/bin/Demo_board
		sync
		echo UPDATE Demo_board success ! Reboot ...
		sleep 2
		reboot
fi

if [ "$1" = "browser" ] ; then
    echo UPDATE browser ... !
    rm -rf /tmp/$WEBKIT
    wget $URL_RESOURCE/$WEBKIT -P /tmp/
    rm -rf /opt/webkit-resource/*
    tar zxvf /tmp/$WEBKIT -C /opt/webkit-resource/
    mv /opt/webkit-resource/webkit-resource-release/* /opt/webkit-resource/
    rm -rf /opt/webkit-resource/webkit-resource-release
    sync    
    rm -rf /tmp/$WEBKIT
fi

if [ "$1" = "browser_RC_V1" ] ; then
    echo UPDATE browser ... !
    rm -rf /tmp/$RELEASE_WEBKIT
    wget $URL_RESOURCE_RELEASE/$RELEASE_WEBKIT -P /tmp/
    rm -rf /opt/webkit-resource/*
    sync
    tar zxvf /tmp/$RELEASE_WEBKIT -C /opt/webkit-resource/
    sync
    mv /opt/webkit-resource/webkit-resource2dmt/* /opt/webkit-resource/
    rm -rf /opt/webkit-resource/webkit-resource2dmt
    sync    
    rm -rf /tmp/$RELEASE_WEBKIT
fi

if [ "$1" = "widget" ] ; then
    echo UPDATE widget ... !
    rm -rf /tmp/$WIDGET
    wget $URL_RESOURCE/$WIDGET -P /tmp/
    rm -rf /addfun/widget-resource
    sync
    tar zxvf /tmp/$WIDGET -C /addfun/
    sync    
    rm -rf /tmp/$WIDGET
fi

if [ "$1" = "widget_RC_V1" ] ; then
    echo UPDATE widget ... !
    rm -rf /tmp/$RELEASE_WIDGET
    wget $URL_RESOURCE_RELEASE/$RELEASE_WIDGET -P /tmp/
    rm -rf /addfun/widget-resource
    sync
    tar zxvf /tmp/$RELEASE_WIDGET -C /addfun/
    sync    
    rm -rf /tmp/$RELEASE_WIDGET
fi

if [ "$1" = "pic" ] ; then
    echo UPDATE pic ... !
    rm -rf /factory/widgetlist_factory.xml
    rm -rf /tmp/$STORE
    wget $URL_RESOURCE/$STORE -P /tmp/
    rm -rf /addfun/store_resource
    sync
    tar zxvf /tmp/$STORE -C /addfun/
    sync    
    rm -rf /tmp/$STORE
fi

if [ "$1" = "pic_RC_V1" ] ; then
    echo UPDATE pic ... !
    rm -rf /factory/widgetlist_factory.xml
    rm -rf /tmp/$RELEASE_STORE
    wget $URL_RESOURCE_RELEASE/$RELEASE_STORE -P /tmp/
    rm -rf /addfun/store_resource
    sync
    tar zxvf /tmp/$RELEASE_STORE -C /addfun/
    sync    
    rm -rf /tmp/$RELEASE_STORE
fi

if [ "$1" = "pic_tmp" ] ; then
    echo UPDATE pic ... !
    rm -rf /factory/widgetlist_factory.xml
    rm -rf /addfun/store_resource/widgetlist.xml
    sync
    wget $URL_RESOURCE/widgetlist.xml -P /addfun/store_resource/
    sync   
fi

if [ "$1" = "pic1024" ] ; then
    echo UPDATE pic ... !
    rm -rf /factory/widgetlist_factory.xml
    rm -rf /tmp/store_resource_1024.tar.gz
    wget $URL_RESOURCE/store_resource_1024.tar.gz -P /tmp/
    rm -rf /addfun/store_resource
    sync
    tar zxvf /tmp/store_resource_1024.tar.gz -C /addfun/
    sync    
    rm -rf /tmp/store_resource_1024.tar.gz
fi

if [ "$1" = "mouse" ] ; then
    echo UPDATE mouse ... !
    rm -rf /vendor/lib/directfb-1.4-0/inputdrivers/libdirectfb_mstar_linux_input.so
    wget http://10.3.40.12/test/LS30i_image/update_lcd6i48/libdirectfb_mstar_linux_input.so -P /vendor/lib/directfb-1.4-0/inputdrivers/
    sync    
fi

if [ "$1" = "browser_lib" ] ; then
    echo UPDATE LCD browser lib patch ... !
    rm -rf /tmp/webkit-resource_lcd_patch_lib.tar.gz
    wget $URL_RESOURCE/webkit-resource_lcd_patch_lib.tar.gz -P /tmp
    tar zxvf /tmp/webkit-resource_lcd_patch_lib.tar.gz -C /opt/webkit-resource/lib/
    rm -rf /tmp/webkit-resource_lcd_patch_lib.tar.gz
    sync    
fi

if [ "$1" = "" ] ; then
		echo UPDATE Demo_board ... !
		killall -9 autorun
		rm -rf /applications/bin/Demo_board
		wget $URL_DEMO_BOARD -P /applications/bin/			
		chmod 755 /applications/bin/Demo_board
		sync

    echo UPDATE browser ... !
    rm -rf /tmp/$WEBKIT
    wget $URL_RESOURCE/$WEBKIT -P /tmp/
    rm -rf /opt/webkit-resource/*
    tar zxvf /tmp/$WEBKIT -C /opt/webkit-resource/
    mv /opt/webkit-resource/webkit-resource-release/* /opt/webkit-resource/
    rm -rf /opt/webkit-resource/webkit-resource-release
    sync    
    rm -rf /tmp/$WEBKIT	
    
    echo UPDATE widget ... !
    rm -rf /tmp/$WIDGET
    wget $URL_RESOURCE/$WIDGET -P /tmp/
    rm -rf /addfun/widget-resource
    sync
    tar zxvf /tmp/$WIDGET -C /addfun/
    sync    
    rm -rf /tmp/$WIDGET

    echo UPDATE pic ... !
    rm -rf /factory/widgetlist_factory.xml
    rm -rf /tmp/$RELEASE_STORE
    wget $URL_RESOURCE_RELEASE/$RELEASE_STORE -P /tmp/
    rm -rf /addfun/store_resource
    sync
    tar zxvf /tmp/$RELEASE_STORE -C /addfun/
    sync    
    rm -rf /tmp/$RELEASE_STORE      

		echo UPDATE success ! Reboot ...
		sleep 2    
    reboot  
fi

