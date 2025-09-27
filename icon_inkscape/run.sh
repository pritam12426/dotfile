#!/usr/bin/env -S bash
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

FILE="/Users/pritam/Documents/icon_inkscape/icon.svg"

OUTPUT_DIR="$TMPDIR"
OUTPUT_DIR+="iconfile.iconset"
mkdir -p "$OUTPUT_DIR"
echo $OUTPUT_DIR
# mkdir -p "$TMPDIR/iconfile.iconset"

printf "Enter the name of the icon: "
read icon_name

for size_info in "${sizes[@]}"; do
	size=${size_info%%:*}
	filename=${size_info##*:}
	echo "Exporting png \"$OUTPUT_DIR/$filename\""
	inkscape "$FILE" --export-filename="$OUTPUT_DIR/$filename" --export-width="$size" --export-height="$size"
done

dir=$(dirname $FILE)

iconutil -c icns "$OUTPUT_DIR" -o "$dir/$icon_name.icns"
