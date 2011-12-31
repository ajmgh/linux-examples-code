#! /bin/sh


#####################
## Clear variables ##
#####################

 echo  Clear variables ... 

 unset PATH
 unset LINUX
 unset PLATFORM
 unset BCHP_VER
 unset SMP
 unset DEBUG

 unset BCHP_CHIP
 unset SC_PLATFORM
 unset SC_BUILD_MODE
 unset TOOLCHAIN
 unset NEXUSMGR_LIBDIR
 unset NEXUSMGR_OBJDIR

 unset ASF_SUPPORT
 unset AVI_SUPPORT
 unset MEDIA_AVI_SUPPORT
 unset MEDIA_ASF_SUPPORT
 unset RAP_WMA_SUPPORT
 unset RAP_WMAPRO_SUPPORT
 unset RAP_AC3_SUPPORT
 unset RAP_DDP_SUPPORT
 unset RAP_DTSBROADCAST_SUPPORT
 unset PLAYBACK_IP_SUPPORT
 unset B_HAS_PLAYPUMP_IP
 unset NETACCEL_SUPPORT
 unset LIVEMEDIA_SUPPORT
 unset KERNELMODE

 PATH=/usr/lib/qt-3.3/bin:/usr/kerberos/sbin:/usr/kerberos/bin:/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
 echo Done.

 export SVN_EDITOR=vim

##############################
# BCM97403 ENV Configuration #
##############################
if [ "$1" = "7403-5.1" ] ; then
 echo BCM97403 REFSW-5.1 Configuration selected !
 export PATH=$PATH:/opt/toolchains/crosstools_sf-linux-2.6.12.0_gcc-3.4.6-20_uclibc-0.9.28-20050817-20070131/bin
 export LINUX=/opt/stblinux-2.6.12_5.0
 export PLATFORM=97403
 export BCHP_VER=A1
 export ASF_SUPPORT=y
 export RAP_WMA_SUPPORT=y
 export PLAYBACK_IP_SUPPORT=y
 export B_HAS_PLAYPUMP_IP=n
 export AVI_SUPPORT=y
 export RAP_AC3_SUPPORT=y
 #export DEBUG=n
fi




#######################################
# BCM97405/BCM97466 ENV Configuration #
#######################################

if [ "$1" = "7405" ] || [ "$1" = "7466" ] ; then

########## Cross-compilation tool chain ##########
 #export PATH=$PATH:/opt/toolchains/crosstools_hf-linux-2.6.18.0_gcc-4.2-11ts_uclibc-nptl-0.9.29-20070423_20090508/bin
 export PATH=$PATH:/opt/toolchains/bin

########## Common Nexus Options ##########

 if [ "$1" = "7405-6.5" ] ; then
  echo BCM97405 REFSW-6.5 Configuration selected !
  export PLATFORM=97405
 fi
 if [ "$1" = "7466-6.5" ] ; then
  echo BCM97466 REFSW-6.5 Configuration selected !
  export PLATFORM=97466
 fi 

 export LINUX=/opt/stblinux-2.6.18
 export BCHP_VER=B0
 #export DEBUG=n 
 export SMP=y 

 if [ "$2" = "flash" ] ; then
  echo make flashlite ENV Configuration
  export NEXUS=/broadcom/refsw/refsw-20090807.97405/nexus
  #export PLATFORM=bcm97405
  export BCHP_CHIP=97405
  #export BCHP_VER=B0
  export SC_PLATFORM=bcm97405nexus
  export SC_BUILD_MODE=debug
  export TOOLCHAIN=/opt/toolchains/crosstools_hf-linux-2.6.18.0_gcc-4.2-11ts_uclibc-nptl-0.9.29-20070423_20090508/bin
  export NEXUSMGR_LIBDIR=/broadcom/refsw/refsw-20090807.97405/BSEAV/lib/flashlite/bin/97405/le/nexus/lib
  export NEXUSMGR_OBJDIR=/broadcom/refsw/refsw-20090807.97405/BSEAV/lib/flashlite/bin/97405/le/nexus/lib
 fi

########### Various Nexus Settings ###########
 export MEDIA_AVI_SUPPORT=y
 export MEDIA_ASF_SUPPORT=y
 export RAP_WMA_SUPPORT=y 
 export RAP_AC3_SUPPORT=y
 #export RAP_DDP_SUPPORT=y 
 #export RAP_DTSBROADCAST_SUPPORT=y 
 export NETACCEL_SUPPORT=n
 export B_HAS_PLAYPUMP_IP=n 
 export PLAYBACK_IP_SUPPORT=y

########## Various Brutus Settings ########## 
 #export KERNELMODE=y
 export LIVEMEDIA_SUPPORT=y


 echo ENV Configuration Done.
fi


##############################
# C21200 ENV Configuration #
##############################
if [ "$1" = "c2" ] ; then
 echo C21200 ENV Configuration selected !
 export SW_MEDIA_PATH=/c2/sdk/C2-JAZZ2-SDK-0.9-1/TARGET_LINUX_C2_TANGO_RELEASE
 export PATH=$PATH:/opt/c2/daily/bin
 export CVSROOT=:ext:shougang.lin@202.149.225.199:/local/cvs
 export CVS_RSH=ssh
fi


##############################
# MTK ENV Configuration #
##############################
if [ "$1" = "mtk" ] ; then
 echo MTK ENV Configuration selected !
 export PATH=$PATH:/usr/local/mtk-toolchain/gnuarm-4.4.2/cross-tools/arm11/bin
 export PATH=$PATH:/usr/local/mtk-toolchain/gnuarm-4.4.2/image-tools/
fi
##############################
# MSTAR ENV Configuration #
##############################
if [ "$1" = "mstar" ] ; then
 echo MTK MSTAR Configuration selected !
 export PATH=$PATH:/opt/mips-4.3/bin
fi


