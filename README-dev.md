Mobage AIR SDK developers
======================================================================
This is an Adobe AIR binding to Mobage Native SDK.

as/      ActionScript interface to android/ and ios/
android/ Eclipse project for Android (you will find project for jp and kr)
ios/     Xcode project for iOS
samples/ Example projecs
 
This SDK works on Android 2.2 or later, and iOS 5.0 or later.
 
DEVELOPMENT
======================================================================
The build processes are controlled by make.
 
./common.mk for configuration path of Mobage Native SDK and Air SDK

as/Makefile for MobageSDK4AIR.ane, the library for ActionScript 3.0

ios/Makefile for libMobageSDK4AIR.a, which will be included in ANE

android/Makefile for MobageSDK4AIR.jar, which will be included in ANE

to build the ANE file you will need to reconfigure the path on ./common.mk.
You will need to select which region you want to build.

Run the following command on the root directory to build (if you only type 'make' the default region will be Japan):
- For Japan SDK
"make toggle-jp"

- For Korea SDK
"make toggle-kr"

ANE file for you which will be located under as/.


ENVIROMENT
======================================================================
Following are the requirements for development.

Flash Builder 4.7 (AIR SDK 4.0 or later)   
Eclipse Juno or later
Xcode 5.1 or later
Android Developers Tools 21 or later

CREATING ASDOCS
======================================================================
See the following page on how to create AS DOCS.

http://help.adobe.com/en_US/flex/using/WSd0ded3821e0d52fe1e63e3d11c2f44bc36-7ffa.html

 
DEVELOPMENT FOR ANDROID
======================================================================
 
Import android/ into Eclipse, edit source code, and then run 'make'. 

* Make sure you have setup enviromental path for "android"(located in $YOUR_ADT_PATH/sdk/tools) and "ant"(installed by default on Mac usr/bin/).
 
Note that the Android emulator is not used as a development environment.

About Google Play Games Library
======================================================================
We recommend that you use Google Play Games Services library version 4.X (tested version).  

Adding Google Play library  
  1. Make sure you set the path to google-play-services.jar and res folder on the "./common.mk". 
     The res folder needs to be named as "google-play-services-res".  
  2. Add the following line in <application> to your app.xml for AndroidManifest  
  
     <meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />   
            
  3. Call 'make' to build (For release make sure you add DEBUG option 0)
  
Removing Google Play library from build
  1. Open /ANE4MobageSDK/as/Android-options.xml  
  2. Remove the following lines  

        <packagedDependency>google-play-services.jar</packagedDependency>  

    
    <packagedResources>  
        <packagedResource>  
            <packageName>com.google.android.gms</packageName>  
            <folderName>google-play-services-res</folderName>  
        </packagedResource>  
    </packagedResources>  

  3. Call 'make GOOGLEPLAY=0' to build without Google Play Games Services library  
 
DEVELOPMENT FOR IOS
======================================================================
 
Open ios/ANE4MobageSDK.xcodeproj with Xcode 5.1 or later and edit
source code, and then 'make'.
Please make sure that "Apple iOS SDK" is higher then 6.1 when packaging with FlashBuilder.

Note that this doesn't work on iPhone simulator.
 
RELEASE ENGINEERING
======================================================================
 
Type the following command in the root directory:

    make toggle-?? DEBUG=0

Example:
    make toggle-jp DEBUG=0


RUN TESTS
======================================================================
 
See 'samples/' directory for testing projects.
 
RUN EXAMPLES
======================================================================
 
There is an example project HelloMobage in the samples/ directory.
 
Open the project in Flash Builder and set the ANE library and
'Mobage.initialize()' arguments (i.e. region, server mode, consumer
key, consumer secret and application id).
 
Then, run (or debug run) the AIR application in your device.
