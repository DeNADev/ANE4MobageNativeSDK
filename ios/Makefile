# Makefile to build ANE4MobageSDK.a

include ../common.mk

# DEBUG
# debug or release
# 0 : Debug build
# 1 : Release build
DEBUG?=0

# REGION
# jp or kr
# jp : Build for JP
# kr : Build for KR
REGION?=jp

# SIMULATOR
SIMULATOR?=0

ifeq ($(DEBUG), 1)
BUILD_CONFIG=Debug
OUTPUT_PATH="build/Debug-iphoneos"
SIMULATOR_OUTPUT_PATH="build/Debug-iphonesimulator"
else
BUILD_CONFIG=Release
OUTPUT_PATH="build/Release-iphoneos"
SIMULATOR_OUTPUT_PATH="build/Release-iphonesimulator"
endif

ifeq ($(REGION), kr)
BUILD_TARGET=ANE4MobageSDK_KR
else
BUILD_TARGET=ANE4MobageSDK_JP
endif

# xcode output library name
OUTPUT_LIB=ANE4MobageSDK.a

# output name
OUTPUT_NAME_DEVICE=ANE4MobageSDK_device.a
OUTPUT_NAME_SIMULATOR=ANE4MobageSDK_simulator.a

# path to Mobage Native SDK
MOBAGE_IOS_SDK_PATH=$(MOBAGE_SDK_PATH)/ios/MobageSDK

DEPENDENCIES=MobageSDK

$(OUTPUT_LIB): $(DEPENDENCIES)
	mkdir -p libs
	cp -pf $(FLASH_SDK_PATH)/include/FlashRuntimeExtensions.h libs/
ifeq ($(SIMULATOR), 1)
	xcodebuild -target $(BUILD_TARGET) -configuration $(BUILD_CONFIG) -sdk $(IOS_SIMULATOR_SDK_VERSION) -arch i386
	cp $(SIMULATOR_OUTPUT_PATH)/$(OUTPUT_LIB) $(OUTPUT_NAME_SIMULATOR)
else
	xcodebuild -target $(BUILD_TARGET) -configuration $(BUILD_CONFIG)
	cp $(OUTPUT_PATH)/$(OUTPUT_LIB) $(OUTPUT_NAME_DEVICE)
endif

MobageSDK:
	cp -pR $(MOBAGE_IOS_SDK_PATH) .

clean:
	rm -rf $(DEPENDENCIES) $(OUTPUT_LIB) build libs $(OUTPUT_NAME_DEVICE) $(OUTPUT_NAME_SIMULATOR)
