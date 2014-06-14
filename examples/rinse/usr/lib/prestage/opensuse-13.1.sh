#!/bin/bash
#

# author : Horst.venzke@remsnet.de
# (c) remsnet LTD
# https://github.com/remsnet/rinse

set -x

# there are better ways to to this  with groupadd / useradd

# rise require  valid user base for the rpm installs
# without you get many errors with i.e " unknown user root"

# some uid / gids change with near all opensuse release
# any Hints are welcome.


prefix=$1


#
#  Source our common functions
#
if [ -e /usr/share/xen-tools/common.sh ]; then
    . /usr/share/xen-tools/common.sh
else
    . ./hooks/common.sh
fi


#
# Log our start
#
logMessage Script $0 starting


echo --------------------------------------
#
env
#
echo --------------------------------------
#
pwd
#
echo --------------------------------------
echo ${prefix}
echo --------------------------------------

#--------------opensuse aaa_base chroot hack--------------------------
#
# chroot basedirs
cd ${prefix}
mkdir -p -m 0755 etc
mkdir -p -m 0755 root
mkdir -p -m 1755 tmp
mkdir -p -m 0755 usr
mkdir -p -m 0755 home
mkdir -p -m 0755 bin
mkdir -p -m 0755 sbin
mkdir -p -m 0755 proc
mkdir -p -m 0755 media
mkdir -p -m 0755 lib
mkdir -p -m 0755 var/run
mkdir -p -m 0755 var/log
mkdir -p -m 0755 var/lock
mkdir -p -m 0755 var/tmp
mkdir -p -m 0755 var/adm
mkdir -p -m 0755 var/opt
mkdir -p -m 0755 var/spool
mkdir -p -m 0755 var/crash
mkdir -p -m 0755 var/tmp
mkdir -p -m 0755 usr/lib
mkdir -p -m 0755 usr/bin
mkdir -p -m 0755 usr/sbin
mkdir -p -m 0755 usr/share
mkdir -p -m 0755 usr/local
mkdir -p -m 0755 usr/include
mkdir -p -m 0755 usr/src
mkdir -p -m 0755 lib/udev/rules.d/


##We realy need  the base sample users - as YAST or autobase not used this way are _required_
# this partly emulate what yast installer do..

cd ${prefix}
# from opensuse 13.1 desktop
cat >>etc/passwd << EOF
root:x:0:0:root:/root:/bin/bash
lp:x:4:7:Printing daemon:/var/spool/lpd:/bin/bash
mail:x:8:12:Mailer daemon:/var/spool/clientmqueue:/bin/false
news:x:9:13:News system:/etc/news:/bin/bash
uucp:x:10:14:Unix-to-Unix CoPy system:/etc/uucp:/bin/bash
man:x:13:62:Manual pages viewer:/var/cache/man:/bin/bash
wwwrun:x:30:8:WWW daemon apache:/var/lib/wwwrun:/bin/bash
nobody:x:65534:65533:nobody:/var/lib/nobody:/bin/bash
EOF


cd ${prefix}
cat >>etc/group << EOF
root:x:0:
tty:x:5:
lp:x:7:
www:x:8:
mail:x:12:
news:x:13:
uucp:x:14:
shadow:x:15:
dialout:x:16:
audio:x:17:
utmp:x:22:
man:x:62:
nobody:x:65533:
EOF

cd ${prefix}
cat >>etc/shadow << EOF
root:!::::::
lp:*:16045::::::
mail:*:16045::::::
news:*:16045::::::
uucp:*:16045::::::
man:*:16045::::::
wwwrun:*:16045::::::
nobody:*:16045::::::
EOF

cd ${prefix}
cat >>etc/gshadow << EOF
abuild:*::
EOF

cd ${prefix}
cat >>etc/hosts << EOF
#               On small systems, this file can be used instead of a
#               "named" name server.
# Syntax:
#
# IP-Address  Full-Qualified-Hostname  Short-Hostname
#

127.0.0.1       localhost black.zq1.de

# special IPv6 addresses
::1             localhost ipv6-localhost ipv6-loopback

fe00::0         ipv6-localnet

ff00::0         ipv6-mcastprefix
ff02::1         ipv6-allnodes
ff02::2         ipv6-allrouters
ff02::3         ipv6-allhosts

EOF


### now install the chroot oss core with preveious created

# centos/fc/redhat rpm binary == /bin/rpm
cd ${prefix}


pwd
# cleanup rpm core  if exist
#
#---------------------------------------------------------
cd ${prefix}
test -d core || rm -rf ./core ; mkdir core
test -d core || rm -rf ./zypperrpm ; mkdir zypperrpm

# OpenSuSE 13.1 core - minimatistic chroot
# see https://github.com/remsnet/OpenSUSE-Bootstrap/blob/master/mk-mini-root.sh
#
echo "prepareing OSS 13.1 RPM rpm core"
cd ${prefix}
for i in aaa_base bash coreutils cpio cracklib cracklib diffutils filesystem fillup findutils glibc grep info insserv libacl1 libattr1 libaudit1 libblkid1 libbz2 libcap2 libcrack2 libdb libgcc_s1 libgdbm4 libgmp10 libgssglue1 liblzma5 libmount1 libncurses5 libpcre1 libreadline5 libreadline6 libselinux1 libstdc++6 libtirpc1 libutempter0 libuuid1 libz1 libzio1 ncurses openSUSE openSUSE pam pam perl perl permissions sed terminfo util insserv-compat
do
cd ${prefix}
/bin/cp --force $i-*.rpm core/
done

#
# zypper requirements
for y in libssh2
do
cd ${prefix}
/bin/cp --force $y-*.rpm zypperrpm/
done

/bin/rpm -i --root  ${prefix}/   ${prefix}/core/*.rpm
/bin/rpm -i --root  ${prefix}/   ${prefix}/zypperrpm/*.rpm
test -d core && rm -rf ./core
test -d zypperrpm && rm -rf ./zypperrpm

#--------------opensuse aaa_base  chroot prestage hack--end -----------------------


#
#  Log our finish
#
logMessage Script $0 finished
#
