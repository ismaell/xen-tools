#!/bin/sh
#
#  Customise the distribution pre-install.
#

prefix=$1

if [ ! -d "${prefix}" ]; then
  echo "Serious error - the named directory doesn't exist."
  exit
fi


#
#  3.  Ensure that zypper has a working configuration file.
#
arch=i386
if [ $ARCH = "amd64" ] ; then
    arch=x86_64
fi

echo "  Creating zypper repo entry"
[ -d "${prefix}/etc/zypp/repos.d" ] || mkdir -p ${prefix}/etc/zypp/repos.d
cat > ${prefix}/etc/zypp/repos.d/${dist}.repo <<EOF
[opensuse]
name=${dist}
baseurl=$(dirname $(dirname ${mirror}))
enabled=1
gpgcheck=1

EOF


#
#  4.  Run pre install  aaa_base - we require the base bevor we run post
#  ->moved to prestage/opensuse-13.1.sh


#
#  5.  Clean up
#
echo "  Cleaning up"
chroot ${prefix} /usr/bin/zypper clean
chroot ${prefix} /usr/bin/zypper ref
umount ${prefix}/proc
umount ${prefix}/sys
