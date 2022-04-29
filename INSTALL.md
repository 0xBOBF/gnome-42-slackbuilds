THIS IS A WORK IN PROGRESS AND HASNT BEEN TESTED YET. USE AT YOUR OWN RISK 

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

