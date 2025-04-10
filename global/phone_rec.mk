# --turn-screen-off --lock-video-orientation
#
# To turn the device screen off when closing
# --power-off-on-close
# By default, on start, the device is powered on.
# --no-power-on              scrcpy --show-touches

SCRCPY     = scrcpy --print-fps --stay-awake
ADB        = adb
OPT        = --no-audio --no-control --max-fps=60
CAM_OPT    = --video-source=camera --no-audio-playback --capture-orientation 270

MODEL     := $(shell ${ADB} shell getprop ro.product.model | tr ' ' '_')
SIZE       = $(shell ${ADB} shell dumpsys battery | grep 'level' | awk '{print $$2}')
BATTERY    = $(shell ${ADB} shell wm size | awk '{print $$3}')
ANDROID_V := $(shell ${ADB} shell getprop ro.build.version.release)
IPV4      := $(shell ${ADB} shell ip route | awk ' NF >= 9 { print $$9 } ' | tail -n 1)

DIR        = ${HOME}/Movies/phone_screen/${MODEL}
FILE      := $(shell date +"%Y-%b-%d_at_%I.%M.%S-%p")
FILE_PATH  = ${DIR}/${MODEL}_android-${ANDROID_V}_${FILE}
PORT       = 5555

# List files less than 1MB
DELETE_FILES = find ${DIR}/* -type f -size -1M -name "*.mp4"
DELETE       = $(DELETE_FILES); $(DELETE_FILES) -delete
LINE         = @printf '%*s\n' $(shell tput cols) ' ' | tr ' ' '-' >&2


# 1 audio with screen
# 2 only audio
# 3 back cam
# 4 frount cam

# point to be noted that: there is high changes that the duration of the video
# and audios of four of them are not relevant to each other for the size.
# You can make it, but for the video duration it is not possible.
# You have to consider this point also.

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

# open fount cam
fcam:
	${SCRCPY} $(CAM_OPT) --camera-facing=front -r "${FILE_PATH}_front-cam.mp4"

# open back cam
bcam:
	${SCRCPY} $(CAM_OPT) --camera-facing=back -r "${FILE_PATH}_back-cam.mp4"

# Kill adb server
kill:
	${ADB} kill-server

# Record Screen with mic
cc:
	${SCRCPY} --audio-source=mic -r "${FILE_PATH}.mp4" --no-audio-playback

# Record only audio
ci:
	${SCRCPY} --audio-source=mic --no-video --no-playback --no-window --no-control --record="${FILE_PATH}_audio.opus"



# Fetch phone info: https://help.famoco.com/developers/dev-env/adb-commands/
ii:
	@printf "{\n";
	@printf "\"%s\": \"%s\",\n"        "Phone_IPV4"       "${IPV4}"
	@printf "\"%s\": \"%s\",\n"        "Android_Version"  "${ANDROID_V}"
	@printf "\"%s\": \"%s\",\n"        "Phone_Model"      "${MODEL}"
	@printf "\"%s\": \"%s\",\n"        "Manufacturer"     "$$(${ADB} shell getprop ro.product.manufacturer | tr -d '\r')"
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

# compile:
# 	ffmpeg -i /Users/pritam/temp/vdo1.mp4 -i /Users/pritam/temp/vdo1.mp4 -filter_complex "[0:v][1:v]hstack=inputs=2[v]" -map "[v]" -an -f matroska new.mp4
