#!/bin/bash

######################################################
#                                                    #
# This script should be installed as a crontab task  #
# in order to create and keep updated a complete     #
# local debian mirror needed for the Freepto         #
# building process                                   #
#                                                    #
######################################################

# set -x

usage() {
cat <<EOF

$0 [ -r repository ] [ -d distro ] [-a arch ] [-s] [-m] -p /full/local/path

Options:
    -r repository set remote host to use as repository (default: http.debian.net)
    -d release    set distro release (default: wheezy,wheezy-update,jessie)
    -a arch       set architecture (default: i386,amd64)
    -p path       set the local patch
    -s            skip security mirror
    -m            skip multimedia mirror

Example:

    ./debmirror.sh -r http.debian.net -d wheezy,wheezy-udpate,jessie -a i386,amd64 -p /var/www/mirror

EOF
}

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    usage
    exit 1
else
    # Default value
    host=http.debian.net;
    dist=wheezy,wheezy-updates,jessie;
    arch=i386,amd64;
    multimedia=y;
    security=y;

    while getopts 'r:d:a:p:ms' opt; do
        case $opt in
            r)
                host=$OPTARG
                ;;
            d)
                dist=$OPTARG
                ;;
            a)
                arch=$OPTARG
                ;;
            p)
                dest=$OPTARG
                ;;
            m)
                multimedia="n"
                ;;
            s)
                security="n"
                ;;
            \?)
                echo "Invalid option: -$OPTARG"
                usage
                exit 1
                ;;
        esac
    done
fi

dpkg -l debmirror > /dev/null 2>&1
isinstalled=$?

if [ $isinstalled == '0' ]; then
    echo "[+] debmirror installed"
else
    echo "[-] Debmirror not installed"
    sudo apt-get install -y debmirror
fi


logger -t debmirror[$$] updating Debian mirror

debmirror \
--i18n \
--method=http \
--progress \
--host=$host \
$dest/debian \
--arch=$arch \
--section=main,contrib,non-free \
--postcleanup \
--exclude="games" \
--exclude='/Translation-.*\.bz2$' \
--include='/Translation-it.*\.bz2$' \
--include='/Translation-es.*\.bz2$' \
--include='/Translation-en.GB\.bz2$' \
--dist=$dist \
--nosource \
--ignore-small-errors \
--root=/debian \

# Debian Security

if [ "$security" == "y" ]; then
    logger -t debmirror[$$] updating Debian Security mirror

    debmirror \
       --i18n \
       --method=http \
       --progress \
       --host=$host \
       $dest/debian-security/ \
       --arch=$arch \
       --section=main,contrib,non-free \
       --postcleanup \
       --checksums \
       --exclude='/Translation-.*\.bz2$' \
       --include='/Translation-it.*\.bz2$' \
       --include='/Translation-es.*\.bz2$' \
       --include='/Translation-en.GB\.bz2$' \
       --dist="wheezy/updates" \
       --root=debian-security \
       --ignore-small-errors \
       --nosource \

fi

if [ "$multimedia" == "y" ]; then

    logger -t debmirror[$$] updating Debian Multimedia mirror

    debmirror \
        $dest/deb-multimedia.org/ \
        --host=www.deb-multimedia.org \
        --progress \
        --ignore-small-errors \
        --ignore-release-gpg \
        --diff=none \
        --dist=stable \
        --arch=$arch \
        --root=/ \
        --method=http \
        --section=main,non-free \
        --nosource \
        --postcleanup \
        --i18n \
        --exclude='/Translation-.*\.bz2$' \
        --include='/Translation-it.*\.bz2$' \
        --include='/Translation-es.*\.bz2$' \
        --include='/Translation-en.GB\.bz2$' \

fi

size=`du -hs $dest | awk '{print $1}'`

logger -t debmirror[$$] update finished: ${size}
