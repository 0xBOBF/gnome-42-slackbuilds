# Installing GNOME 42 on Slackware-current
Note: These instructions assume that you are using a clean and up-to-date slackware-current installation. You will also need to be root for these steps.

# Pre-Build Steps

## Users and Groups
There are a couple of users and groups that need to be created before starting
the build, else the relevant builds will fail. This is the avahi and colord 
users and groups:
```bash
 groupadd -g 214 avahi
 useradd -u 214 -g 214 -c "Avahi User" -d /dev/null -s /bin/false avahi

 groupadd -g 303 colord
 useradd -d /var/lib/colord -u 303 -g colord -s /bin/false colord
```
Note that the 'gdm' user and group is already present on stock slackware.

Unfortunately, slackware comes with gdm misconfigured in its init scripts. If you want to boot into runlevel 4 and launch gdm then you will have to edit `/etc/rc.d/rc.4`, removing the `-nodaemon` option passed to gdm. This is an invalid option and will cause gdm to exit instead of start. Specifically this part, since gdm is installed here:
```bash
if [ -x /usr/sbin/gdm ]; then
  exec /usr/sbin/gdm -nodaemon
fi
```
Needs to be changed to:
```bash
if [ -x /usr/sbin/gdm ]; then
  exec /usr/sbin/gdm
fi
```

You will also need to start/stop avahi on your system by adding the following to `/etc/rc.d/rc.local`:
```bash
# Start avahidaemon
if [ -x /etc/rc.d/rc.avahidaemon ]; then
 /etc/rc.d/rc.avahidaemon start
fi
# Start avahidnsconfd
if [ -x /etc/rc.d/rc.avahidnsconfd ]; then
  /etc/rc.d/rc.avahidnsconfd start
fi
```
For shutdown, edit/create `/etc/rc.d/rc.local_shutdown` and include the following lines:

```bash
# Stop avahidnsconfd
if [ -x /etc/rc.d/rc.avahidnsconfd ]; then
  /etc/rc.d/rc.avahidnsconfd stop
fi
# Stop avahidaemon
if [ -x /etc/rc.d/rc.avahidaemon ]; then
  /etc/rc.d/rc.avahidaemon stop
fi
```

## Core Package Upgrades:
Several of the core packages of Slackware need to be upgraded for this build to work. The appropriate build scripts are provided in the gnome repo so
start with copying the repo and upgrading/installing these packages. Note that mozjs91 is included in this list because it needs to come before gjs.
- pango
- gtk4
- libnma
- mozjs91
- gjs
- upower

Navigate to roots home directory and get a copy of the repo:
```bash
cd ~
git clone https://github.com/0xBOBF/gnome-42-slackbuilds.git
```
Then nagivate to the appropriate sub-directories for the listed packages and run the respective builds. The following example shows how to do that for pango:
```bash
cd ./gnome-42-slackbuilds/slackbuilds/pango
source pango.info
wget $DOWNLOAD
sh pango.SlackBuild
```
Then when it is done building, upgrade/install the package before moving on to the next one. E.g.
```bash
upgradepkg --reinstall --install-new /tmp/pango-1.50.7-x86_64-1.txz
```
Repeat these steps with the remaining packages in the list.

## Install sbopkg
We are going to use 'sbokpkg' to install GNOME 42 in the proper order so first we must install sbopkg. We can use the pre-built package for that:
```bash
wget https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz
installpkg sbopkg-0.38.2-noarch-1_wsr.tgz
```
## Prepare sbopkg

### Setting up a Local Repo:
A number of builds in this repo are not in SBo, so we are going to merge the two repos, giving gnome-42-slackbuilds priority over SBo versions.

First, sync SBo's repo to the latest version of the SBo master using:
``` bash
sbopkg -V SBo/master -r
```
The SBo repo will be downloaded to `/var/lib/sbopkg/SBo`. After the SBo repo is synced, navigate to the repo and add a copy the gnome-42 slackbuilds directory. Use a numbered name so that sbopkg will find the gnome-42 versions of slackbuilds first. In this example I use `10-gnome` as the directory name.
``` bash
cd /var/lib/sbopkg/SBo
cp -r ~/gnome-42-slackbuilds/slackbuilds ./10-gnome
```
Note: At this point, avoid running `sbopkg -r` again, because that will overwrite our merged repo. If you do run `sbopkg -r` (or `sbopkg -V SBo/master -r`), you will need to re-copy the gnome builds into the repo.

The final step before using the repo is to point sbopkg to it. Navigate to sbopkg's repo config directory and create a custom repo using a name starting with a number lower than the existing repos. In this example I use the name `10-local-gnome.repo`.
``` bash
cd /etc/sbopkg/repos.d/
vim ./10-local-gnome.repo
```
Then in the 10-local-gnome.repo file, enter the following:
``` bash
SBo "" "SBo master with GNOME" _SBo "" "" ""
```
Save the file and you are ready to start building with sbopkg. You can build packages individually, or, there is a full queue file available with the gnome-42 repo. To use this queue file, copy it to `/var/lib/sbopkg/queues/`, and specifiy it for sbopkg:
```bash
cp ~/gnome-42-slackbuilds/gnome-42-full.sqf /var/lib/sbopkg/queues/
export INTROSPECTION=yes
export VALA=yes
export VAPI=yes
export AVAHI=yes
export WEBKITGTK=true
sbopkg -V SBo/master -i gnome-42-full
```

#### Environment Variables
Some of the builds in the queue require passing variables to set build options like introspection. These were shown in the previous example. An explanation of these are as follows:
``` bash
export INTROSPECTION=yes
export VALA=yes
export VAPI=yes
```
These are used by the clutter packages, and other packages from SBo like geocode-glib, gweather, libchamplain, gnome-online-accounts to enable building gobject introspection and vala bindings. This is needed by 'gnome-maps' and its dependency 'folks' to properly build and run. The cheese package and its dep clutter-gst also need introspection on the other clutter packages to build.

``` bash
export AVAHI=yes
```
This is used to build avahi support into geoclue2.

``` bash
export WEBKITGTK=true
```
This is used by zenity to add webkit2gtk support.
