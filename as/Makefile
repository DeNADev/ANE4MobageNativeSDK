# Makefile to build ANE4MobageSDK.ane

include ../common.mk

# debug or release
DEBUG?=0

ifeq ($(DEBUG), 1)
ANDROID_BUILD_TARGET?=debug
else
ANDROID_BUILD_TARGET?=release
endif

# REGION
# jp or kr
# jp : Build for JP
# kr : Build for KR
REGION?=jp

# AS output files
OUTPUT_DIR=bin
OUTPUT_SWC=$(OUTPUT_DIR)/ANE4MobageSDK.swc
OUTPUT_SWF=$(OUTPUT_DIR)/library.swf
OUTPUT_ANE= ANE4MobageSDK.ane

# Necessary input files for ios and android
PLATFORM_DIR=platform

# for iOS device
IOS_DIR=$(PLATFORM_DIR)/ios
INPUT_IOS_SWF=$(IOS_DIR)/library.swf
INPUT_IOS_LIB=$(IOS_DIR)/ANE4MobageSDK.a

# for iOS Simulator
IOS_SIMULATOR_DIR=$(PLATFORM_DIR)/iosSimulator
INPUT_IOS_SIMULATOR_SWF=$(IOS_SIMULATOR_DIR)/library.swf
INPUT_IOS_SIMULATOR_LIB=$(IOS_SIMULATOR_DIR)/ANE4MobageSDK.a

# for Android
ANDROID_DIR=$(PLATFORM_DIR)/android
INPUT_ANDROID_SWF=$(ANDROID_DIR)/library.swf
INPUT_NATIVE_JAR=$(ANDROID_DIR)/ANE4MobageSDK.jar

# 
INPUT_MOBAGE_SDK=$(ANDROID_DIR)/libs $(ANDROID_DIR)/res $(ANDROID_DIR)/res_rn_v9 $(IOS_DIR)/MobageSDK $(IOS_SIMULATOR_DIR)/MobageSDK

# path to Mobage Native SDK
MOBAGE_ANDROID_SDK_FILES=$(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/libs $(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/res $(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/res_rn_v9
MOBAGE_IOS_SDK_PATH=$(MOBAGE_SDK_PATH)/ios/MobageSDK

$(OUTPUT_ANE): $(INPUT_ANDROID_SWF) $(INPUT_IOS_SWF) $(INPUT_IOS_SIMULATOR_SWF) $(INPUT_MOBAGE_SDK)
	$(FLASH_SDK_PATH)/bin/adt -package -target ane $@ extension.xml -swc bin/ANE4MobageSDK.swc -platform Android-ARM -C platform/android/ . -platform iPhone-ARM -C $(IOS_DIR) -platformoptions iOS-options.xml . -platform iPhone-x86 -C $(IOS_SIMULATOR_DIR) -platformoptions iOS-options.xml .

$(INPUT_MOBAGE_SDK): $(INPUT_NATIVE_JAR) $(INPUT_IOS_LIB) $(INPUT_IOS_SIMULATOR_LIB)
	cp -pRv $(MOBAGE_ANDROID_SDK_FILES) $(ANDROID_DIR)
# for KR
ifeq ($(REGION), kr)
	mkdir -p $(ANDROID_DIR)/libs/armeabi-v7a
	cp -p $(ANDROID_DIR)/libs/armeabi/libmobage.so $(ANDROID_DIR)/libs/armeabi-v7a
endif
# for iOS device
	cp -pRf $(MOBAGE_IOS_SDK_PATH)/images/* $(IOS_DIR)
# for iOS simulator
	cp -pRf $(MOBAGE_IOS_SDK_PATH)/images/* $(IOS_SIMULATOR_DIR)

$(INPUT_ANDROID_SWF): $(INPUT_NATIVE_JAR) $(OUTPUT_SWF)
	cp $(OUTPUT_SWF) $@

$(INPUT_NATIVE_JAR):
	mkdir -p platform/android
	cd ../android/; BUILD_TARGET=$(ANDROID_BUILD_TARGET) REGION=$(REGION) make
	cp ../android/$(REGION)/ANE4MobageSDK.jar $@

$(INPUT_IOS_LIB):
	mkdir -p $(IOS_DIR)
	cd ../ios; make DEBUG=$(DEBUG) REGION=$(REGION) SIMULATOR=0
	cp ../ios/ANE4MobageSDK_device.a $@

$(INPUT_IOS_SWF): $(INPUT_IOS_LIB) $(OUTPUT_SWF)
	cp $(OUTPUT_SWF) $@

$(INPUT_IOS_SIMULATOR_LIB):
	mkdir -p $(IOS_SIMULATOR_DIR)
	cd ../ios; make DEBUG=$(DEBUG) REGION=$(REGION) SIMULATOR=1
	cp ../ios/ANE4MobageSDK_simulator.a $@

$(INPUT_IOS_SIMULATOR_SWF): $(INPUT_IOS_SIMULATOR_LIB) $(OUTPUT_SWF)
	cp $(OUTPUT_SWF) $@

$(INPUT_ANDROID_SWF): $(INPUT_NATIVE_JAR) $(OUTPUT_SWF)
	cp $(OUTPUT_SWF) $@

$(OUTPUT_SWF): $(OUTPUT_SWC)
	unzip -d $(OUTPUT_DIR) -o $(OUTPUT_SWC)

SWC_DEPENDENCIES=swc-config.xml

$(OUTPUT_SWC): $(SWC_DEPENDENCIES)
	$(FLASH_SDK_PATH)/bin/acompc -load-config+=swc-config.xml +configname=airmobile -output $@

swc-config.xml:
	ruby create-swc-config.rb

clean:
	cd ../android/; make clean REGION=jp
	cd ../android/; make clean REGION=kr
	cd ../ios; make clean
	rm -rf $(SWC_DEPENDENCIES) $(OUTPUT_DIR) $(INPUT_NATIVE_JAR) $(OUTPUT_ANE) $(PLATFORM_DIR)