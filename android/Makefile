# Makefile to build ANE4MobageSDK.jar

include ../common.mk

# debug or release
DEBUG?=0

# REGION
# jp or kr
# jp : Build for JP
# kr : Build for KR
REGION?=jp

ifeq ($(DEBUG), 1)
BUILD_TARGET=debug
else
BUILD_TARGET=release
endif


# output jar file
OUTPUT_JAR=$(REGION)/ANE4MobageSDK.jar

# path to Mobage Native SDK
MOBAGE_SDK_JAR_PATH=$(MOBAGE_SDK_PATH)/android/MobageNativeAndroid/libs
MOBAGE_SDK_JAR_FILE=$(MOBAGE_SDK_JAR_PATH)/MobageNativeSdk.jar
MOBAGE_SDK_JAR_FILE2=$(MOBAGE_SDK_JAR_PATH)/android-support-v4.jar
MOBAGE_SDK_JAR_FILE3=$(MOBAGE_SDK_JAR_PATH)/AppAdForce.jar
MOBAGE_SDK_CLASS_FILE=$(REGION)/bin/classes/com/mobage/android/Mobage.class

ifeq ($(REGION), jp)

DEPENDENCIES=$(REGION)/libs/MobageNativeSdk.jar $(REGION)/libs/AppAdForce.jar $(REGION)/libs/FlashRuntimeExtensions.jar $(REGION)/libs/android-support-v4.jar $(MOBAGE_SDK_CLASS_FILE) \
	$(REGION)/build.xml $(REGION)/local.properties $(REGION)/proguard-project.txt

$(OUTPUT_JAR): $(DEPENDENCIES)
	# http://developer.android.com/tools/building/building-cmdline.html
	cd ./$(REGION); ant $(BUILD_TARGET)
	cp $(REGION)/bin/classes.jar $@

$(MOBAGE_SDK_CLASS_FILE):
	mkdir -p $(REGION)/bin/classes
	unzip -o $(MOBAGE_SDK_JAR_FILE) -d $(REGION)/bin/classes -x META-INF/*
	unzip -o $(MOBAGE_SDK_JAR_FILE2) -d $(REGION)/bin/classes -x META-INF/*
	unzip -o $(MOBAGE_SDK_JAR_FILE3) -d $(REGION)/bin/classes -x META-INF/*
	touch $(MOBAGE_SDK_CLASS_FILE)

$(REGION)/libs/MobageNativeSdk.jar $(REGION)/libs/AppAdForce.jar $(REGION)/libs/android-support-v4.jar :
	cp -pR $(MOBAGE_SDK_JAR_PATH)/ $(REGION)/libs/

$(REGION)/libs/FlashRuntimeExtensions.jar:
	cp -p $(FLASH_RUNTIME_EXT_JAR_PATH) $(REGION)/libs/

# for KR
else

DEPENDENCIES=$(REGION)/libs/MobageNativeSdk.jar $(REGION)/libs/armeabi/libmobage.so $(REGION)/libs/FlashRuntimeExtensions.jar $(REGION)/libs/android-support-v4.jar $(REGION)/libs/armeabi-v7a/libmobage.so $(MOBAGE_SDK_CLASS_FILE) \
	$(REGION)/build.xml $(REGION)/local.properties $(REGION)/proguard-project.txt

$(OUTPUT_JAR): $(DEPENDENCIES)
	# http://developer.android.com/tools/building/building-cmdline.html
	cd ./$(REGION); ant $(BUILD_TARGET)
	cp $(REGION)/bin/classes.jar $@

$(MOBAGE_SDK_CLASS_FILE):
	mkdir -p $(REGION)/bin/classes
	unzip -o $(MOBAGE_SDK_JAR_FILE) -d $(REGION)/bin/classes -x META-INF/*
	unzip -o $(MOBAGE_SDK_JAR_FILE2) -d $(REGION)/bin/classes -x META-INF/*
	touch $(MOBAGE_SDK_CLASS_FILE)

$(REGION)/libs/MobageNativeSdk.jar $(REGION)/libs/armeabi/libmobage.so $(REGION)/libs/android-support-v4.jar $(REGION)/libs/armeabi-v7a/libmobage.so:
	cp -pR $(MOBAGE_SDK_JAR_PATH)/ $(REGION)/libs/
	mkdir -p $(REGION)/libs/armeabi-v7a
	cp -p $(REGION)/libs/armeabi/libmobage.so $(REGION)/libs/armeabi-v7a


$(REGION)/libs/FlashRuntimeExtensions.jar:
	cp -p $(FLASH_RUNTIME_EXT_JAR_PATH) $(REGION)/libs/

endif




$(REGION)/build.xml $(REGION)/local.properties proguard-project.txt:
	# http://developer.android.com/tools/projects/projects-cmdline.html
	android update lib-project --target android-8 --path ./$(REGION)

clean:
	rm -rf $(DEPENDENCIES) $(REGION)/gen/ $(REGION)/bin/ $(REGION)/libs/ $(OUTPUT_JAR)
    
