xen-tools
=========

* [Homepage](http://www.xen-tools.org/software/xen-tools)
* Git Repository:
  * [at Gitorious](http://gitorious.org/xen-tools)
  * [at GitHub](http://github.com/xtaran/xen-tools)
* [Mailing Lists](http://www.xen-tools.org/software/xen-tools/lists.html)

About
-----

xen-tools is a collection of simple shell , perl, python scripts which allow you to easily 
create new Xen guest domains upon your NATIVE Xen host server.

xen-tools gives you the abillty fully control what and how "Items" get auto-deployed with the supported install methodes  
while  working with Xen  guest images under Linux .

xen-tools  Support as well FAI , pupped , sudo and  some more .

xen-tools are higly configurable and simply to addapt to your own needs .


Using this software, you can easily create new
[Xen](http://www.xen.org) guests configured to be accessible over the
network via [OpenSSH](http://www.openssh.org/).

xen-tools currently has scripts to install most releases of
[Debian](http://www.debian.org/) (starting with 3.1 "Sarge") and
[Ubuntu](http://www.ubuntu.com/) (starting with 6.06 LTS "Dapper") and
some RPM-based distributions. On the Dom0 side all current Xen
supporting distributions should work.


Supported Distrubutions 
-----

The Folloing  releases are tested and known to work reliably  aka "Supported" :


### Debian

* Sarge 3.1 (i386 and DomU only)
* Etch 4.0 (Dom0 no more tested)
* Lenny 5.0
* Squeeze 6.0
* Wheezy 7
* Jessie 8 (under development)
* Sid (always under development; works at least at the moment of writing :-)

### Ubuntu

(only DomUs tested)

* Dapper Drake 6.06 (needs editing of `/usr/share/debootstrap/scripts/dapper` since at least debootstrap version 1.0.37, see [#659360][1])
* Edgy Eft 6.10 (needs editing of `/usr/share/debootstrap/scripts/edgy` since at least debootstrap version 1.0.37, see [#659360][1])
* Feisty Fawn 7.04
* Gutsy Gibbon 7.10
* Hardy Heron 8.04 (see [Installing Ubuntu 8.04 as DomU][2])
* Interpid Ibex 8.10
* Jaunty Jackaplope 9.04
* Karmic Koala 9.10
* Lucid Lynx 10.04
* Maverick Meerkat 10.10
* Natty Narwhal 11.04
* Oneiric Ocelot 11.10
* Precise Pangolin 12.04
* Quantal Quetzal 12.10
* Raring Ringtail 13.04
* Saucy Salamander 13.10
* Trusty Tahr 14.04 (LTS, under development)

[1]: http://bugs.debian.org/659360
    "debootstrap in Wheezy can no more build Ubuntu Edgy or earlier"

[2]: http://www.linux-vserver.org/Installing_Ubuntu_8.04_Hardy_as_guest
    "There is an issue with debootstrap on hardy not installing ksyslogd."

### CentOS

only DomUs tested, pygrub support incomplete on older then 6.0 .

* CentOS 5
* CentOS 6

However, currently only centos 6.5 and up releases are fully tested and known to work reliably with pygrub
due now kernel 3.x used with dracut.

* CentOS 6.5
* CentOS 7.0 - work in progress target -> q3 or q4 2014 

### OpenSuSE / SuSE / SLES

* OSS 13.1


Packages
--------

xen-tools are available prepackaged in Debian (and derivates) and as
source tar-ball for local installation. Installing from source should
work flawlessly on most Linux systems that meet the installation
requirements.

Requirements
------------

To use these tools you'll need the following software on Dom0: <br>

   Tool                 Source URL                        - what      + distro  <br>
    
* [debootstrap](http://packages.debian.org/debootstrap)   - bootstrap +  debian/ubuntu  <br>
* [fakeroot](http://packages.debian.org/fakeroot)         - chroot helper <br>
* [rpmstrap](https://github.com/blipvert/rpmstrap)        - rpmstrap   +  rpmbased install helper <br>
* [rinse] (http://collab-maint.alioth.debian.org/rinse)    - bootstrap  +   RHEL / FC / SuSE / SLES  <br>

* Perl and the following Perl modules
  Requires: perl(Text::Template) <br>
  Requires: perl(Config::IniFiles) <br>
  Requires: perl(Expect::Simple) perl(Expect) <br>
  Requires: perl(Getopt::Long) <br>
  Requires: perl(LWP::UserAgent) <br>
  Requires: perl(Pod::Usage) <br>
  Requires: perl(File::Basename) <br>
  Requires: perl(File::Find) <br>
  Requires: perl(File::Path) <br>
  Requires: perl(File::Temp) <br>
  Requires: perl(File::Which) <br>
  Requires: perl(File::Copy) <br>
  Requires: perl(Term::UI) <br>
  Requires: perl(Term::ReadLine) <br>
  Requires: perl(IPC::Cmd) <br>
  Requires: perl(Digest::MD5) <br>
  Requires: perl(Data::Validate::URI) <br>
  Requires: perl(Data::Validate::IP) <br>
  Requires: perl(Data::Validate::Domain) <br>

Most of them are delivered by distributions , thus this are only an question of allmost  <br>
to use the native distro package tools (apt-get / yum / zypper / yast / rpm / ... )  <br>
If not found in distribution - use i.e http://www.rpmfind.net, http://www.debfind.de <br>
Or install them via  perl CPAN . <br>
 
* To use the --hash_method=expect you need expect installed on domU: <br>
  [expect] (http://expect.sourceforge.net/) <br>
  expect  require tcl to be installed. <br>
  
This been currently in use at ( oss13.1 : 29-setup-expect ) for autpdeploy inital random root pwd at opensuse 13.x  xen guest. <br>
expect can be autoremoved as well after with --finalrole=remove_rpm_expect for those that have an security concern about it . <br>

* gnu make,and compiler ,  rpmbuild tools  if you are not installing through a package manager.

* [rinse] (http://collab-maint.alioth.debian.org/rinse)  
Sample configs for centos6.5 , opensuse 13.1 added under examples - they are fully tested .<br>
Rinse require fakeroot and rpmstrap to work cleanly. <br>

If you wish to create new Xen instances which may be controlled by <br>
users via a login shell you can have a look at the (currently <br>
unmaintained) [xen-shell](http://xen-tools.org/software/xen-shell/)
project.


Installation from Source
------------

As root or with sudo, execute `make instal`.

For Debian/Ubuntu  see `debian/README.source` how to build the Debian package from a<br>
checked out copy of the git repository (i.e. without a source tarball).<br>


Installation from RPMbuild
------------

 - picup specfile & build  patches  from  https://github.com/remsnet/xen-tools-rpmbuild
   add them to rpmbuild´s SPECS dir  i.e /usr/src/packages/SPECS

 - picup xen-tools sources from this repro, use "master"  ,     rpmbuild -ba <spec> ,     rpm -i <rpm>

 
The Scripts
-----------

Here is a brief description of each included script, for more thorough
documentation please consult the appropriate man page.


### xen-create-image

This script is designed to create new images which may be used
with the Xen hypervisor.

This script performs the initial setup, then delegates the real
work to a collection of helper scripts:

* `xt-install-image`: Installs a distribution into a directory.

* `xt-customize-image`: Run a collection of hook scripts to configure
  the freshly installed system.

* `xt-create-xen-config`: Create a configuration file in `/etc/xen`
  such that Xen can boot the newly created machine.

* `xt-guess-suite-and-mirror`: In case of a Debian or Ubuntu Dom0,
  this script tries to guess the most suitable suite and mirror for
  DomUs based on the Dom0's `/etc/apt/sources.list`.


### xen-create-nfs

This script is similar in spirit to `xen-create-image`, but much less
complex.  It allows the creation of Xen guests which are diskless,
mounting their root filesystem over a remote NFS-share.

There are not many options to tweak, but still a useful addition 
to the suite.


### xen-delete-image

This script will allow you to completely remove Xen instances which
have previously been created by `xen-create-image`, this includes
removing the storage block devices from the system, and deleting the
Xen configuration file.


### xen-list-images

List all the created images beneath a given root directory along with
a brief overview of their setup details.


### xen-update-image

This script runs "apt-get update; apt-get upgrade" for a given Xen
image.

#### NOTES

* The image should not be running or corruption will occur!
* The script should only be used for Xen instances of Debian or a
  Debian-derived distribution.


-- 
The Xen-Tools Developer Team
