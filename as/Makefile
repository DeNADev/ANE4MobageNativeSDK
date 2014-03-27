# Makefile to build ANE4MobageSDK.ane

include ../common.mk

# debug or release
DEBUG?=0

# REGION
# jp or kr
# jp : Build for JP
# kr : Build for KR
REGION?=jp

# AS output files
OUTPUT_DIR=bin
OUTPUT_SWC=$(OUTPUT_DIR)/ANE4MobageSDK.swc
OUTPUT_ANE=ANE4MobageSDK.ane

# Necessary input files for ios and android
PLATFORM_DIR=platform

# for iOS device
IOS_SWC_DEPENDENCIES=swc-config-ios.xml
OUTPUT_IOS_DIR=bin_ios
OUTPUT_IOS_SWC=$(OUTPUT_IOS_DIR)/ANE4MobageSDK.swc
OUTPUT_IOS_SWF=$(OUTPUT_IOS_DIR)/library.swf
IOS_DIR=$(PLATFORM_DIR)/ios
INPUT_IOS_SWF=$(IOS_DIR)/library.swf
INPUT_IOS_LIB=$(IOS_DIR)/ANE4MobageSDK.a

# for iOS Simulator
IOS_SIMULATOR_DIR=$(PLATFORM_DIR)/iosSimulator
INPUT_IOS_SIMULATOR_SWF=$(IOS_SIMULATOR_DIR)/library.swf
INPUT_IOS_SIMULATOR_LIB=$(IOS_SIMULATOR_DIR)/ANE4MobageSDK.a

# for Android
ANDROID_SWC_DEPENDENCIES=swc-config-android.xml
OUTPUT_ANDROID_DIR=bin_android
OUTPUT_ANDROID_SWC=$(OUTPUT_ANDROID_DIR)/ANE4MobageSDK.swc
OUTPUT_ANDROID_SWF=$(OUTPUT_ANDROID_DIR)/library.swf
ANDROID_DIR=$(PLATFORM_DIR)/android
INPUT_ANDROID_SWF=$(ANDROID_DIR)/library.swf
INPUT_NATIVE_JAR=$(ANDROID_DIR)/ANE4MobageSDK.jar

# for adl
ADL_SWC_DEPENDENCIES=swc-config-default.xml
OUTPUT_ADL_DIR=bin_default
OUTPUT_ADL_SWC=$(OUTPUT_ADL_DIR)/ANE4MobageSDK.swc
OUTPUT_ADL_SWF=$(OUTPUT_ADL_DIR)/library.swf
ADL_DIR=$(PLATFORM_DIR)/default
INPUT_ADL_SWF=$(ADL_DIR)/library.swf

# 
INPUT_MOBAGE_SDK=$(ANDROID_DIR)/libs $(ANDROID_DIR)/res $(ANDROID_DIR)/res_rn_v9 $(IOS_DIR)/MobageSDK $(IOS_SIMULATOR_DIR)/MobageSDK

# path to Mobage Native SDK
MOBAGE_ANDROID_SDK_FILES=$(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/libs/android-support-v4.jar $(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/libs/MobageNativeSdk.jar $(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/libs/AppAdForce.jar $(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/res $(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/res_rn_v9
MOBAGE_IOS_SDK_PATH=$(MOBAGE_SDK_PATH)/ios/MobageSDK

$(OUTPUT_ANE): $(OUTPUT_SWC) $(INPUT_ANDROID_SWF) $(INPUT_IOS_SWF) $(INPUT_IOS_SIMULATOR_SWF) $(INPUT_ADL_SWF) $(INPUT_MOBAGE_SDK)
	$(FLASH_SDK_PATH)/bin/adt -package -target ane $@ extension.xml -swc bin/ANE4MobageSDK.swc \
		-platform Android-ARM -C $(ANDROID_DIR) -platformoptions Android-options.xml . \
		-platform iPhone-ARM -C $(IOS_DIR) -platformoptions iOS-options.xml . \
		-platform iPhone-x86 -C $(IOS_SIMULATOR_DIR) -platformoptions iOS-options.xml . \
		-platform default -C $(ADL_DIR) .

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

$(INPUT_ANDROID_SWF): $(INPUT_NATIVE_JAR) $(OUTPUT_ANDROID_SWF)
	cp $(OUTPUT_ANDROID_SWF) $@

$(INPUT_NATIVE_JAR):
	mkdir -p $(ANDROID_DIR)
	cd ../android/; make DEBUG=$(DEBUG) REGION=$(REGION) 
	cp ../android/$(REGION)/ANE4MobageSDK.jar $@

$(INPUT_IOS_LIB):
	mkdir -p $(IOS_DIR)
	cd ../ios; make DEBUG=$(DEBUG) REGION=$(REGION) SIMULATOR=0
	cp ../ios/ANE4MobageSDK_device.a $@

$(INPUT_IOS_SWF): $(INPUT_IOS_LIB) $(OUTPUT_IOS_SWF)
	cp $(OUTPUT_IOS_SWF) $@

$(INPUT_IOS_SIMULATOR_LIB):
	mkdir -p $(IOS_SIMULATOR_DIR)
	cd ../ios; make DEBUG=$(DEBUG) REGION=$(REGION) SIMULATOR=1
	cp ../ios/ANE4MobageSDK_simulator.a $@

$(INPUT_IOS_SIMULATOR_SWF): $(INPUT_IOS_SIMULATOR_LIB) $(OUTPUT_IOS_SWF)
	cp $(OUTPUT_IOS_SWF) $@

$(INPUT_ADL_SWF): $(OUTPUT_ADL_SWF)
	mkdir -p $(ADL_DIR)
	cp $(OUTPUT_ADL_SWF) $@


$(OUTPUT_ANDROID_SWF): $(OUTPUT_ANDROID_SWC)
	unzip -d $(OUTPUT_ANDROID_DIR) -o $(OUTPUT_ANDROID_SWC)

$(OUTPUT_IOS_SWF): $(OUTPUT_IOS_SWC)
	unzip -d $(OUTPUT_IOS_DIR) -o $(OUTPUT_IOS_SWC)

$(OUTPUT_ADL_SWF): $(OUTPUT_ADL_SWC)
	unzip -d $(OUTPUT_ADL_DIR) -o $(OUTPUT_ADL_SWC)

$(OUTPUT_ANDROID_SWC): $(ANDROID_SWC_DEPENDENCIES)
	$(FLASH_SDK_PATH)/bin/acompc -load-config+=$(ANDROID_SWC_DEPENDENCIES) +configname=airmobile -output $@

$(OUTPUT_IOS_SWC): $(IOS_SWC_DEPENDENCIES)
	$(FLASH_SDK_PATH)/bin/acompc -load-config+=$(IOS_SWC_DEPENDENCIES) +configname=airmobile -output $@

$(OUTPUT_ADL_SWC): $(ADL_SWC_DEPENDENCIES)
	$(FLASH_SDK_PATH)/bin/acompc -load-config+=$(ADL_SWC_DEPENDENCIES) +configname=airmobile -output $@

$(OUTPUT_SWC): $(ADL_SWC_DEPENDENCIES)
	$(FLASH_SDK_PATH)/bin/acompc -load-config+=$(ADL_SWC_DEPENDENCIES) +configname=airmobile -output $@

$(ANDROID_SWC_DEPENDENCIES):
	ruby create-swc-config.rb android

$(IOS_SWC_DEPENDENCIES):
	ruby create-swc-config.rb ios

$(ADL_SWC_DEPENDENCIES):
	ruby create-swc-config.rb default

clean:
	cd ../android/; make clean REGION=jp
	cd ../android/; make clean REGION=kr
	cd ../ios; make clean
	rm -rf $(IOS_SWC_DEPENDENCIES) $(ANDROID_SWC_DEPENDENCIES) $(ADL_SWC_DEPENDENCIES) \
		$(OUTPUT_IOS_DIR) $(OUTPUT_ANDROID_DIR) $(OUTPUT_ADL_DIR) $(OUTPUT_DIR) \
		$(INPUT_NATIVE_JAR) $(OUTPUT_ANE) $(PLATFORM_DIR)
