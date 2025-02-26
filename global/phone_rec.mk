SCRCPY     = ${HOME}/.local/share/scrcpy-macos-x86_64-v3.1/scrcpy --print-fps
ADB        = ${HOME}/.local/share/scrcpy-macos-x86_64-v3.1/adb
OPT        = --no-audio --no-control --max-fps=60
CAM_OPT    = --video-source=camera --no-audio-playback --capture-orientation 270

MODEL     := $(shell ${ADB} shell getprop ro.product.model | tr ' ' '_')
SIZE       = $(shell ${ADB} shell dumpsys battery | grep 'level' | awk '{print $$2}')
BATTERY    = $(shell ${ADB} shell wm size | awk '{print $$3}')
ANDROID_V := $(shell ${ADB} shell getprop ro.build.version.release)
IPV4      := $(shell ${ADB} shell ip route | awk ' NF >= 9 { print $$9 } ' | grep -Eo '\b[0-9]{1,3}\.[0-9]{2}\.[0-9]{1,3}\.[0-9]{1,3}\b')

DIR        = ${HOME}/Movies/phone_screen/${MODEL}
FILE      := $(shell date +"%Y-%b-%d_at_%H.%M.%S")
FILE_PATH  = ${DIR}/${MODEL}_android-${ANDROID_V}_${FILE}
PORT       = 5555

# List files less than 1MB
DELETE_FILES = find ${DIR}/* -type f -size -1M -name "*.mp4"
DELETE       = $(DELETE_FILES); $(DELETE_FILES) -delete
LINE         = @printf '%*s\n' $(shell tput cols) ' ' | tr ' ' '-' >&2

all: t

# adb shell ip route | awk '{print $9}'

# Case And Record
cr:
	mkdir -p ${DIR}
	@printf "Battery Level    %s\n" "${BATTERY}"
	@printf "Screen Size      %s\n" "${SIZE}"
	${LINE}
	${SCRCPY} ${OPT} -r "${FILE_PATH}.mp4"


# Record
r:
	mkdir -p ${DIR}
	@printf "Battery Level    %s\n" "${BATTERY}"
	@printf "Screen Size      %s\n" "${SIZE}"
	${LINE}
	${SCRCPY} ${OPT} --no-window -r "${FILE_PATH}.mp4"

# Test
t:
	@printf "Battery Level    %s\n" "${BATTERY}"
	@printf "Screen Size      %s\n" "${SIZE}"
	${LINE}
	${SCRCPY}

# Take screenshot
ss:
	@printf "Battery Level    %s\n" "${BATTERY}"
	@printf "Screen Size      %s\n" "${SIZE}"
	${LINE}
	${ADB} exec-out screencap -p > "${FILE_PATH}_scr_short.png"

# connect to phone with wifi
config:
	@echo "Phone's IPV4 ${IPV4}"
	${ADB} tcpip ${PORT}
	${ADB} connect ${IPV4}:${PORT}


clean:
	${DELETE}

fcam:
	${SCRCPY} $(CAM_OPT) --camera-facing=front -r "${FILE_PATH}_front-cam.mp4"


bcam:
	${SCRCPY} $(CAM_OPT) --camera-facing=back -r "${FILE_PATH}_back-cam.mp4"

# Kill adb server
kill:
	${ADB} kill-server

# https://help.famoco.com/developers/dev-env/adb-commands/
# Get phone info
ii:
	@printf "{\n";
	@printf "\"%s\": \"%s\",\n"        "Phone_IPV4"       "${IPV4}"
	@printf "\"%s\": \"%s\",\n"        "Android_Version"  "${ANDROID_V}"
	@printf "\"%s\": \"%s\",\n"        "Phone_Model"      "${MODEL}"
	@printf "\"%s\": \"%s\",\n"        "Manufacturer"     "$$(${ADB} shell getprop ro.product.manufacturer | tr -d '\r')"
	@printf "\"%s\": \"%s\",\n"        "IMEI_1"           "$$(${ADB} shell dumpsys iphonesubinfo)"
	@printf "\"%s\": \"%s\",\n"        "IMEI_2"           "$$(${ADB} shell dumpsys iphonesubinfo2)"
	@printf "\"%s\": \"%s\",\n"        "Hardware"         "$$(${ADB} shell getprop ro.hardware | tr -d '\r')"
	@printf "\"%s\": \"%s\",\n"        "Serial_Number"    "$$(${ADB} shell getprop ro.serialno | tr -d '\r')"
	@printf "\"%s\": \"%s%%\",\n"      "Battery_Level"    "$$(${ADB} shell dumpsys battery | grep 'level' | awk '{print $$2}')"
	@printf "\"%s\": \"%s\",\n"        "Screen_Size"      "$$(${ADB} shell wm size | awk '{print $$3}')"
	@printf "\"%s\": \"%s dpi\",\n"    "Pixel_Density"    "$$(${ADB} shell wm density | awk '{print $$3}')"
	@printf "\"%s\": \"%s\",\n"        "Uptime"           "$$(${ADB} shell uptime | awk '{print $$1}')"
	@printf "\"%s\": \"%s\",\n"        "Connected_WiFi"   "$$(${ADB} shell dumpsys wifi | grep 'SSID' | awk -F': ' 'NR==1{print $$2}' | tr -d '\r')"
	@printf "\"%s\": %d,\n"            "Installed_Apps"   "$$(${ADB} shell pm list packages | awk -F':' '{print $$2}' | wc -l)"
	@printf "\"%s\": \"%s\",\n"        "Storage_Total"    "$$(${ADB} shell df /data | grep '/data' | awk '{print $$2}')"
	@printf "\"%s\": \"%s\",\n"        "Storage_Free"     "$$(${ADB} shell df /data | grep '/data' | awk '{print $$4}')"
	@printf "\"%s\": \"%s kB\"\n"      "Total_RAM"        "$$(${ADB} shell cat /proc/meminfo | grep MemTotal | awk '{print $$2}')"
	@printf "}\n";
