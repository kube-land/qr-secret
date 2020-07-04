#! /bin/bash

mkdir -p build/linux/usr/local/share/applications/
mkdir -p build/linux/usr/local/bin
mkdir -p build/linux/usr/share/icons/hicolor/{32x32,64x64,128x128,256x256,512x512}/apps/

cp -rf build/qr-secret-linux-amd64 build/linux/usr/local/bin/qr-secret

cp logo/qr-secret.iconset/icon_32x32.png build/linux/usr/share/icons/hicolor/32x32/apps/qr-secret.png
cp logo/qr-secret.iconset/icon_64x64.png build/linux/usr/share/icons/hicolor/64x64/apps/qr-secret.png
cp logo/qr-secret.iconset/icon_128x128.png build/linux/usr/share/icons/hicolor/128x128/apps/qr-secret.png
cp logo/qr-secret.iconset/icon_256x256.png build/linux/usr/share/icons/hicolor/256x256/apps/qr-secret.png
cp logo/qr-secret.iconset/icon_512x512.png build/linux/usr/share/icons/hicolor/512x512/apps/qr-secret.png

cat <<EOF >> build/linux/usr/local/share/applications/QRSecret.desktop
#!/usr/bin/env xdg-open  
[Desktop Entry]
Encoding=UTF-8
Terminal=0
Exec=/usr/local/bin/qr-secret
Icon=qr-secret
Type=Application
Categories=Graphics;
StartupNotify=true
Name=QRSecret
GenericName=QRSecret
Name[en_US]=QRSecret
EOF

tar -C build/linux/ -zcvf build/qr-secret-linux-amd64.tar.gz .
