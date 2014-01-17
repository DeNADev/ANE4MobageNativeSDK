ANE4MobageNativeSDK 
==========================================================================
	Introduction
	Instructions
	Known Issues
	ChangeLog
	Device/Simulator Support
	Support
	License

Introduction
==========================================================================
Please notice that this release is a sample for Mobage AIR SDK (JP & KR). The functions have been smoked tested but not guaranteed. 
Please fix any issue you encountered with the attached source code.


Setup Instructions
==========================================================================
iOS:
- Please refer to docs/ANEForMobageNativeSDKProgrammingGuide.pdf
- For development please see README-dev

Android:
- Please refer to docs/ANEForMobageNativeSDKProgrammingGuide.pdf
- For development please see README-dev

REST APIs specification:
- Please refer to https://docs.mobage.com/display/JPSA/REST_API_Reference_JP


Known Issues
==========================================================================
- Exporting apk file from FlashBuilder will automatically add "air." to the package name
  which will cause issues with remote notification and submission build. See Programing
  Guide section "How to setup correct Android package name when exporting for release
  build?" for more details.

- FlashBuilder exports apk with incorrect resources causing upload error on JP Mobage
  Developers. Please insert dummy icon.png in "res/drawables/" as workaround until the
  issue is solved.

- Under a specific condition on Android 3.x, an issue is found where
  the screen orientation of the Mobage login view is not handled correctly.
  This issue is observed on Galaxy TAB 7.0 / 10.1 with Android 3.2.

- On some Optimus devices, an issue is found where the new user registration
  web view does not close upon registration success. Pressing the back key
  dismisses the web view and player can continue with the game normally.
  This issue is observed on Optimus PAD Android 3.0.1

ChangeLog
==========================================================================


ENVIRONMENT
==========================================================================
Android:
	Minimum OS Version: 2.2
	
	Only hardware device is supported
    	(Android emulator is not supported)

iOS:
	iOS 5.0 or later
	(iOS Simulator with iOS 6.0 or later is partially supported)

Smartphone simulator (Flash Builder built-in):
	Not supported

Mobage Native SDK:
	*Only 1.4.6 or later

See README-dev for development.
