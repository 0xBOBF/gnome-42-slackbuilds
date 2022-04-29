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
```

## Core Package Upgrades:
Several of the core packages of Slackware need to be upgraded for this build to work. The appropriate build scripts are provided in the gnome repo so
start with copying the repo and upgrading/installing these packages. Note that mozjs91 is included in this list because it needs to come before gjs.
- gtk4
- libnma
- mozjs91
- gjs

Navigate to roots home directory and get a copy of the repo:
```bash
cd ~
git clone https://github.com/0xBOBF/gnome-42-slackbuilds.git
```
Then nagivate to the appropriate sub-directories for the listed packages and run the respective builds. The following example shows how to do that for gtk4:
```bash
cd ./gnome-42-slackbuilds/slackbuilds/gtk4
source gtk4.info
wget $DOWNLOAD
sh gtk4.SlackBuild
```
Then when it is done building, upgrade/install the package before moving on to the next one. E.g.
```bash
upgradepkg --reinstall --install-new /tmp/gtk4-4.6.2-x86_64-1.tgz
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
Setting up a local repo for 'sbopkg' requires three steps:

 1. Set up a repo in the proper format for sbopkg.
 1. Define the repo in `/etc/sbopkg/repos.d/`
 2. Point 'sbopkg' to the repo in `sbopkg.conf`

For the first step we will make our repo in sbopkg's default root directory and
set that up with the latest SBo-master, plus our additional gnome packages.

The default location for sbopkg repos is `/var/lib/sbopkg/`. Navigate to this directory, creating it if needed.
``` bash
cd /var/lib/sbopkg
```
Then clone SBo's master branch:
``` bash
git clone https://gitlab.com/SlackBuilds.org/slackbuilds.git -b master ./testing
```
Now we want to add our slackbuilds to the repo so we can use both SBo and GNOME
builds. If you followed the first steps then you will have a copy of the GNOME repo in root's home directoy. We will copy this into the SBo repo with the following:

``` bash
 cp -r ~/gnome-42-slackbuilds/slackbuilds ./testing/10-gnome
```
Note: Putting '10' infront of the name will ensure that versions of builds in the gnome repo are prioritized over builds that in the SBo repo in the situation where we use a newer version for gnome.

Now enter the repo and add the new gnome directory to git so sbopkg will find it.
``` bash
 cd testing
 git add .
 git commit -m "Add GNOME Builds"
```
Now set up the queue file for sbopkg copying the queue file from the gnome repo to `/var/lib/sbopkg/queues` (Create this directory if it doesn't exist yet).
```bash
cp ~/gnome-42-slackbuilds/gnome-42-full.sqf /var/lib/sbopkg/queues/
```

The next step is to define the new repo for sbopkg. To do this we make a copy of the
example local repo definition and set it up for ourselves:
``` bash
 cp /etc/sbopkg/repos.d/50-local.repo /etc/sbopkg/repos.d/51-local.repo
```

Then use a text editor to edit `/etc/sbopkg/repos.d/51-local.repo` and point it to the repo. This config works with the steps above:
``` bash
# Repo Branch Description Tag Tool Link CheckGPG
testing master "SBo with GNOME Repo" _SBo git "" ""
```

Finally, edit the `/etc/sbopkg/sbopkg.conf` file to use this new repo so the REPO_BRANCH and REPO_NAME lines match:
``` bash
REPO_BRANCH=${REPO_BRANCH:-master}
REPO_NAME=${REPO_NAME:-testing}
```

At this point sbopkg is ready to be used for installing gnome-packages. For example,
you could issue:
``` bash
sbopkg -i gnome-shell
```
And the gnome-shell package should be found and queued for building.

## Run sbopkg Using the Queue-file
Once sbopkg is configured, you can install the full set using the queue files
provided in this repo.

For example:
```bash
sbopkg -i gnome-42-full.sqf
```

