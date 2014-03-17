#!/bin/sh

version="2.0-alpha5"
arch="amd64"


package_dir=$(cd `dirname $0` && pwd)

source_dir=".."


####################################################
# Make sure we are running as root
####################################################
#if [ "$(id -u)" != "0" ]; then
#   echo "This script must be run as root" 1>&2
#   exit 1
#fi

#Do any parameter overrides
while [ -n "$*" ]
do
   eval $1
   shift
done

# Determine which lib directory to use
case "$arch" in
   "amd64" ) lib="lib64";;
   "i386" ) lib="lib32";;
esac

##################################################
# Banner page              
##################################################
echo "****************************************************"
echo "Copying files for NixNote $version for $arch"
echo "****************************************************"

############################
# Copy the things we need  #
############################

# Create directories
echo "Building directories"
mkdir $package_dir/nixnote2
mkdir $package_dir/nixnote2/usr
mkdir $package_dir/nixnote2/usr/share
mkdir $package_dir/nixnote2/usr/share/applications
mkdir $package_dir/nixnote2/usr/share/nixnote2
mkdir $package_dir/nixnote2/usr/share/man
mkdir $package_dir/nixnote2/usr/bin


# Copy binary, configs, & man pages
echo "Copying files"
cp $source_dir/install.sh $package_dir/nixnote2/
cp $source_dir/*.txt $package_dir/nixnote2/usr/share/nixnote2/
cp $source_dir/*.html $package_dir/nixnote2/usr/share/nixnote2/
cp $source_dir/nixnote2.desktop $package_dir/nixnote2/usr/share/applications/
cp $source_dir/nixnote $package_dir/nixnote2/usr/bin/nixnote2
cp $source_dir/man/*.* $package_dir/nixnote2/usr/share/man/

# Copy subdirectories
echo "Copying subdirectories"
echo "Copying images"
cp -r $source_dir/images $package_dir/nixnote2/usr/share/nixnote2/
echo "Copying lib"
cp -r $source_dir/$lib $package_dir/nixnote2/usr/share/nixnote2/lib
echo "Copying spell"
cp -r $source_dir/spell $package_dir/nixnote2/usr/share/nixnote2/
echo "Copying translations"
cp -r $source_dir/translations $package_dir/nixnote2/usr/share/nixnote2/
echo "Copying qss"
cp -r $source_dir/qss $package_dir/nixnote2/usr/share/nixnote2/


# Reset user permissions
echo "Resetting permissions"
#chown -R root:root $package_dir/nixnote2/

# Cleanup
#echo "Cleaning up"
#rm -rf $package_dir/nixnote2
