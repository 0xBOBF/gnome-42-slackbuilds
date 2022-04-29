# Installing GNOME 42 on Slackware-current
Note: These instructions assume that you are using a clean and up-to-date slackware-current installation. You will also need to be root for these steps.

# Pre-Build Steps

## Install sbopkg
We are going to use 'sbokpkg' to install GNOME 42 in the proper order so first we must install sbopkg. We can use the pre-built package for that:
```bash
wget https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz
installpkg sbopkg-0.38.2-noarch-1_wsr.tgz
```

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

Having the above users and groups is enough to build GNOME 42. You will also need to start/stop avahi on your system by adding the following to `/etc/rc.d/rc.local`:
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

## Prepare sbopkg
Building GNOME 42 requires following a prescribed order of building and installing
so that required dependencies can be met. We can use sbopkg to automate all of 
this if we set up a custom repo. The file SBOPKG_SETUP.md describes how to do this.

## Run sbopkg Using the Queue-file
Once sbopkg is configured, you can install the full set using the queue files
provided in this repo.

For example:
```bash
sbopkg -i gnome-42-full.sqf
```

