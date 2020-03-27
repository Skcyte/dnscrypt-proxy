CONFIG_PATH=$MODPATH/configs
DCP_PATH=$MODPATH/binaries/dcp
DCP_TARGET_PATH=/data/media/0/dnscrypt-proxy/
CONFIG_FILE=/data/media/0/dnscrypt-proxy/dnscrypt-proxy.toml

# architecture check
if [ "$ARCH" == "arm" ];then
    BINARY_PATH=$MODPATH/binaries/dnscrypt-proxy-arm
  elif [ "$ARCH" == "arm64" ];then
    BINARY_PATH=$MODPATH/binaries/dnscrypt-proxy-arm64
  elif [ "$ARCH" == "x86" ];then
    BINARY_PATH=$MODPATH/binaries/dnscrypt-proxy-i386
  elif [ "$ARCH" == "x64" ];then
    BINARY_PATH=$MODPATH/binaries/dnscrypt-proxy-x86_64
fi

ui_print "- Creating binaries path"
mkdir -p $MODPATH/system/bin

ui_print "- Creating configurations path"
mkdir -p $DCP_TARGET_PATH

if [ -f "$BINARY_PATH" ]; then
    ui_print "- Copying binaries"
    mv -f $BINARY_PATH $MODPATH/system/bin/dnscrypt-proxy
    mv -f $DCP_PATH $MODPATH/system/bin/dcp
else
    abort "Binary file for $ARCH is missing!"
fi

if [ -d "$CONFIG_PATH" ]; then
    ui_print "- Copying example and license files"
    mv -f $CONFIG_PATH/* $DCP_TARGET_PATH
else
    abort "Config file is missing!"
fi

if ! [ -f "$CONFIG_FILE" ]; then
    cp -af /data/media/0/dnscrypt-proxy/example-dnscrypt-proxy.toml $CONFIG_FILE
fi

rm -rf $MODPATH/binaries
rm -rf $MODPATH/configs
  
# set permission magisk module
set_perm $MODPATH/system/bin/dnscrypt-proxy 0 0 0755
set_perm $MODPATH/system/bin/dcp 0 0 0755