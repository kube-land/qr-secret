#! /bin/bash

mkdir -p build/QRSecret/QRSecret.app/Contents/{MacOS,Resources}

cat <<EOF >> build/QRSecret/QRSecret.app/Contents/Info.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleExecutable</key>
	<string>qr-secret</string>
	<key>CFBundleIconFile</key>
	<string>icon.icns</string>
	<key>CFBundleIdentifier</key>
	<string>pharmatics.io</string>
	<key>NSHighResolutionCapable</key>
	<true/>
	<key>LSUIElement</key>
	<true/>
</dict>
</plist>
EOF

cp -rf build/qr-secret-darwin-amd64 build/QRSecret/QRSecret.app/Contents/MacOS/qr-secret
cp -rf logo/icon.icns build/QRSecret/QRSecret.app/Contents/Resources

hdiutil create build/QRSecret.dmg -srcfolder build/QRSecret -ov

#export CERTIFICATE_P12=Certificate.p12;
#echo $CERTIFICATE_OSX_P12 | base64 — decode > $CERTIFICATE_P12;
#export KEYCHAIN=build.keychain;
#security create-keychain -p mysecretpassword $KEYCHAIN;
#security default-keychain -s $KEYCHAIN;
#security unlock-keychain -p mysecretpassword $KEYCHAIN;
#security import $CERTIFICATE_P12 -k $KEYCHAIN -P $CERTIFICATE_PASSWORD -T /usr/bin/codesign;

######
#security create-keychain -p mysecretpassword build.keychain
#security default-keychain -s build.keychain
#security unlock-keychain -p mysecretpassword build.keychain
#security import certificate.p12 -k build.keychain -P <certificate password, if any> -T /usr/bin/codesign
#security find-identity -v
####

#codesign --deep --force --verbose --sign "<identity>" Application.app