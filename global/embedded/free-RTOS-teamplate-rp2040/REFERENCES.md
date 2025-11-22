- For setup:
	- You have to install the picotool package of the same version of as same pico sdk
	- I as is importent to use make build system other than make bill system, nothing will work
	- A good Channel for understanding about pico
		- https://www.youtube.com/@DrJonEA
		- https://drjonea.co.uk/iot-blog/
	- YouTube Tutorial: https://www.youtube.com/watch?v=2cDpGoCyrHQ
	- Project Template: https://github.com/LearnEmbeddedSystems/rp2040-freertos-template
	- [FreeRTOSConfig.h source](https://github.com/LearnEmbeddedSystems/rp2040-freertos-template/blob/main/src/FreeRTOSConfig.h)
		- As per the video, to install the FreeRTOS Kernel for RP2040, use the following command to clone the template repository, including its submodules:

		``` sh
		git clone --recurse-submodules "git@github.com:LearnEmbeddedSystems/rp2040-freertos-template.git"
		```

		Then, move the `lib/FreeRTOS-Kernel` folder into `gdir; pico/FreeRTOS-Kernel-rp2040`.
		Note that the `FreeRTOSConfig.h` file defines how the FreeRTOS kernel customizes itself for the RP2040, regardless of the FreeRTOS version.

- FreeRTOS Kernel for RP2040:
	- This project template includes the FreeRTOS Kernel for RP2040.

- ARM GNU Toolchain:
	- [ARM GNU Toolchain Downloads](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
		- Download and install the portable version of the ARM GNU Toolchain.

- FreeRTOS Kernel doc
	- https://www.freertos.org/Documentation/02-Kernel/03-Supported-devices/02-Customization#include_parameters
	- https://docs.aws.amazon.com/freertos/latest/userguide/freertos-config.html

-
