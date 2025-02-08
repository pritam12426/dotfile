SCRCPY     = ${HOME}/.local/share/scrcpy-macos-x86_64-v3.1/scrcpy --max-fps=30 --print-fps
ADB        = ${HOME}/.local/share/scrcpy-macos-x86_64-v3.1/adb
OPT        = --no-audio --no-control
MODEL     := $(shell ${ADB} shell getprop ro.product.model | tr ' ' '_')
SIZE       = $(shell adb shell dumpsys battery | grep 'level' | awk '{print $$2}')
BATTERY    = $(shell adb shell wm size | awk '{print $$3}')
DIR        = ${HOME}/Movies/phone_screen/${MODEL}
IPV4      := $(shell ${ADB} shell ip route | awk ' NF >= 9 { print $$9 } ' | grep -Eo '\b[0-9]{1,3}\.[0-9]{2}\.[0-9]{1,3}\.[0-9]{1,3}\b')
ANDROID_V := $(shell ${ADB} shell getprop ro.build.version.release)
FILE      := $(shell date +"%Y-%b-%d_at_%H.%M.%S")
FILE_PATH  = ${DIR}/${MODEL}_android-${ANDROID_V}_${FILE}
PORT       = 5555

DELETE = find ${DIR}/* -type f -size -2M -name "*.mp4" -delete
LINE   = @printf '%*s\n' $(shell tput cols) ' ' | tr ' ' '─' >&2

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
	@printf '%*s\n' $(shell tput cols) ' ' | tr ' ' '─' >&2
	${SCRCPY}

ss:
	@printf "Battery Level    %s\n" "${BATTERY}"
	@printf "Screen Size      %s\n" "${SIZE}"
	${LINE}
	${ADB} exec-out screencap -p > "${FILE_PATH}.png"

config:
	@echo "Phone's IPV4 ${IPV4}"
	${ADB} tcpip ${PORT}
	${ADB} connect ${IPV4}:${PORT}

clean:
	${DELETE}
o:
	open ${DIR}

ii:
	@printf "Phone's IPV4     %s\n"     "${IPV4}"
	@printf "Android Version  %d\n"     "${ANDROID_V}"
	@printf "Phone's Model    %s\n"     "${MODEL}"
	@printf "Manufacturer     %s\n"     "$$(${ADB} shell getprop ro.product.manufacturer | tr -d '\r')"
	@printf "Hardware         %s\n"     "$$(${ADB} shell getprop ro.hardware | tr -d '\r')"
	@printf "Serial Number    %s\n"     "$$(${ADB} shell getprop ro.serialno | tr -d '\r')"
	@printf "Battery Level    %s%%\n"   "$$(${ADB} shell dumpsys battery | grep 'level' | awk '{print $$2}')"
	@printf "Screen Size      %s\n"     "$$(${ADB} shell wm size | awk '{print $$3}')"
	@printf "Pixel Density    %s dpi\n" "$$(${ADB} shell wm density | awk '{print $$3}')"
	@printf "Uptime           %s\n"     "$$(${ADB} shell uptime | awk '{print $$1}')"
	@printf "Connected Wi-Fi  %s\n"     "$$(${ADB} shell dumpsys wifi | grep 'SSID' | awk -F': ' 'NR==1{print $$2}' | tr -d '\r')"
	@printf "Installed Apps:  %d\n"     "$$(${ADB} shell pm list packages | awk -F':' '{print $$2}' | wc -l)"
	@printf "Storage Total    %s\n"     "$$(${ADB} shell df /data | grep '/data' | awk '{print $$2}')"
	@printf "Storage Free     %s\n"     "$$(${ADB} shell df /data | grep '/data' | awk '{print $$4}')"
	@printf "Total RAM        %s\n"     "$$(${ADB} shell cat /proc/meminfo | grep MemTotal | awk '{print $$2}') kB"

kill:
	${ADB} kill-server
