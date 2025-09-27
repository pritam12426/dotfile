#!/usr/bin/env -S bash -x
sizes=(
	"16:icon_16x16.png"
	"32:icon_16x16@2x.png"
	"32:icon_32x32.png"
	"64:icon_32x32@2x.png"
	"128:icon_128x128.png"
	"256:icon_128x128@2x.png"
	"256:icon_256x256.png"
	"512:icon_256x256@2x.png"
	"512:icon_512x512.png"
	"1024:icon_512x512@2x.png"
)

input_svg="icon.svg"
mkdir -p "iconfile.iconset"
mkdir -p "icon"

# file=$(md5sum $1 | awk '{print $1}')
# file=$(md5sum $input_svg | awk '{print $1}')

for size_info in "${sizes[@]}"; do
	size=${size_info%%:*}
	filename=${size_info##*:}
	inkscape "$input_svg" --export-filename="./iconfile.iconset/$filename" --export-width="$size" --export-height="$size"
done

iconutil -c icns "iconfile.iconset" -o "$1.icns"
mv -f *.icns icon
