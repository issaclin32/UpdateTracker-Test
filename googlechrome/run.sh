mkdir ./googlechrome/public -p
mkdir ./googlechrome/tmp/checker -p
mkdir ./googlechrome/tmp/parse -p

chmod +x ./googlechrome/util/checker.sh
chmod +x ./googlechrome/util/parse.sh
chmod +x ./googlechrome/util/generator.sh

./googlechrome/util/checker.sh "./googlechrome/tmp"

./googlechrome/util/parse.sh "./googlechrome/tmp" stable-x86 stable-x64 beta-x86 beta-x64 dev-x86 dev-x64 canary-x86 canary-x64

cp -rf ./googlechrome/src/chrome.xml ./googlechrome/tmp/chrome.xml

DATE="$(echo $(TZ=UTC-8 date '+%Y-%m-%d %H:%M:%S'))"
sed -i "s|{{CheckTime}}|$DATE|g" googlechrome/tmp/chrome.xml

./googlechrome/util/generator.sh stable-x86 stable-x64 beta-x86 beta-x64 dev-x86 dev-x64 canary-x86 canary-x64

xmllint --format googlechrome/tmp/chrome.xml > googlechrome/tmp/chrome_linted.xml
cp -rf googlechrome/tmp/chrome_linted.xml ./googlechrome/public/chrome.xml

#xmllint --noblanks googlechrome/tmp/chrome.xml > googlechrome/tmp/chrome.min.xml
#cp -rf googlechrome/tmp/chrome.min.xml ./googlechrome/public/chrome.min.xml