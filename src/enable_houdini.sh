#!/system/bin/sh

PATH=/system/bin:/system/xbin

houdini_bin=0
dest_dir=/system/lib$1/arm$1
binfmt_misc_dir=/proc/sys/fs/binfmt_misc

cd $dest_dir

if [ ! -s libhoudini.so ]; then
    if touch .dl_houdini; then
        rm -f .dl_houdini
    else
        cd .. && cp -a arm$1 /data/local/tmp
        mount -t tmpfs tmpfs arm$1 && cd arm$1 &&
                cp -a /data/local/tmp/arm$1/* . && rm -rf /data/local/tmp/arm$1
    fi
fi

cd /data/local/tmp
while [ ! -s $dest_dir/libhoudini.so ]; do
    while [ "$(getprop net.dns1)" = "" ]; do
        sleep 10
    done
    if [ -z "$1" ]; then
        url=http://goo.gl/PA2qZ7
    else
        url=http://goo.gl/L00S7l
    fi
    wget $url -cO /data/local/tmp/houdini.tgz
    tar xvf /data/local/tmp/houdini.tgz -C $dest_dir && rm -f /data/local/tmp/houdini.tgz && break
    rm -f /data/local/tmp/houdini.tgz
    sleep 30
done


if [ ! -e $binfmt_misc_dir/register ]; then
    mount -t binfmt_misc none $binfmt_misc_dir
fi

cd $binfmt_misc_dir
if [ -e register ]; then
    echo "registering..."
    # register Houdini for arm binaries
    if [ -z "$1" ]; then
        echo ':arm_exe:M::\\x7f\\x45\\x4c\\x46\\x01\\x01\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x28::'"$dest_dir/houdini:P" > register
        echo ':arm_dyn:M::\\x7f\\x45\\x4c\\x46\\x01\\x01\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x03\\x00\\x28::'"$dest_dir/houdini:P" > register
    else
        echo "registering 64"
        echo ':arm64_exe:M::\\x7f\\x45\\x4c\\x46\\x02\\x01\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\xb7::'"$dest_dir/houdini:P" > register
        echo ':arm64_dyn:M::\\x7f\\x45\\x4c\\x46\\x02\\x01\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x03\\x00\\xb7::'"$dest_dir/houdini:P" > register
    fi
    if [ -e arm${1}_exe ]; then
        houdini_bin=1
    fi
else
    log -pe -thoudini "No binfmt_misc support"
fi

if [ $houdini_bin -eq 0 ]; then
    log -pe -thoudini "houdini$1 enabling failed!"
else
    log -pi -thoudini "houdini$1 enabled"
fi

[ "$(getprop ro.zygote)" = "zygote64_32" -a -z "$1" ] && exec $0 64

exit 0