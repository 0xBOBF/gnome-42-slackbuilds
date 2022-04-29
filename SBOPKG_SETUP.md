# Setting up 'sbopkg' to Build and Install GNOME 42

## Introduction:

The 'sbopkg' tool provides a convenient way to process SlackBuild scripts and more
importantly, process queues of slackbuilds, handling package install steps.

We can take advantage of this to install GNOME 42 in the correct build order. This 
is possible with setting up a local repository for 'sbopkg' to use instead of the
official branch. 

## Setting up a Local Repo:
Setting up a local repo for 'sbopkg' requires three steps:

 1. Set up a repo in the proper format for sbopkg.
 1. Define the repo in `/etc/sbopkg/repos.d/`
 2. Point 'sbopkg' to the repo in `sbopkg.conf`

For the first step we will make our repo in sbopkg's default root directory and
set that up with the latest SBo-master, plus our additional gnome packages.

The default location is:
``` bash
cd /var/lib/sbopkg
```
First lets clone SBo's master branch:
``` bash
git clone https://gitlab.com/SlackBuilds.org/slackbuilds.git -b master ./testing
```
Now we want to add our slackbuilds to the repo so we can use both SBo and GNOME
builds. The following commands clone the repo, then copy the slackbuilds to the 
proper hierarchy, using a 'gnome' sub-directory:
``` bash
 git clone https://github.com/0xBOBF/gnome-42-slackbuilds.git
 cp -r ./gnome-42-slackbuilds/slackbuilds ./testing/gnome
```
Now enter the repo and add the new gnome directory to git so sbopkg will find it.
``` bash
 cd testing
 git add .
 git commit -m "Add GNOME Builds"
```
The next step is to define the new repo for sbopkg. To do this we make a copy of the
example local repo definition and set it up for ourselves:
``` bash
 cd /etc/sbopkg/repos.d
 cp 50-local.repo 51-local.repo
```
Then use a text editor to edit `51-local.repo` and point it to the repo. This config works with the steps above:
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

## Building GNOME

Sbopkg can use a "queue file" to install a set list of packages, in top to bottom order.
A queue file is supplied with the gnome-42-slackbuilds repo and can be used for building
and installing GNOME 42 in the correct order.

Good Luck!
