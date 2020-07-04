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