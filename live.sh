#!/bin/sh
# Configure the following variables according to your requirements

version="24.0" # chose from http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/
language="en-US" # e.g. "de" or "en-US"

########################################################

application="firefox" # "thunderbird" or "firefox" but file extension, archive extraction, and binary execution needs to be adapted as well see filenames at http://download.cdn.mozilla.net/pub/mozilla.org/

echo This script downloads "${application} Version ${version} If you want to install another version press Ctrl C and edit and configure this file"
read -n1 -r -p "Press space to continue..." key

file="${application}-${version}.tar.bz2"
url="http://download.cdn.mozilla.net/pub/mozilla.org/${application}/releases/${version}/linux-i686/${language}/${file}"
#e.g.

mkdir "${application}-portable"
cd "${application}-portable"
wget $url
echo "Extracting archive, please wait..."
tar xfj $file
rm $file
mv $application app
mkdir data

echo '#!/bin/sh' > "${application}-portable"
echo 'dir=${0%/*}' >> "${application}-portable"
echo 'if [ "$dir" = "$0" ]; then' >> "${application}-portable"
echo '  dir="."' >> "${application}-portable"
echo 'fi' >> "${application}-portable"
echo 'cd "$dir/app"' >> "${application}-portable"
echo './firefox -profile ../data $1' >> "${application}-portable"

chmod +x "${application}-portable"
echo ... finished
echo "#close all running instances of another ${application} version:"
echo killall ${application}
echo "#change into the directory"
echo "# and start the application there"
echo cd "${application}-portable"
echo ./"${application}-portable"
