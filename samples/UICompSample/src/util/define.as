// ActionScript file
package util
{
	import com.mobage.air.Region;
	import com.mobage.air.ServerMode;
	
	public final class define {
		// Initialize
		public static const APPLICATION_ID :String              = "Your_Application_Id";
		public static const ANDROID_CONSUMER_KEY :String        = "Your_Android_Consumer_Key";
		public static const ANDROID_CONSUMER_SECRET :String     = "Your_Android_Consumer_Secret";
		public static const IOS_CONSUMER_KEY :String            = "Your_iOS_Consumer_Key";
		public static const IOS_CONSUMER_SECRET :String         = "Your_iOS_Consumer_Secret";
		public static const REGION :Region                      = Region.JP; // "Your_Application_Region";
		public static const SERVER_MODE	:ServerMode             = ServerMode.SANDBOX; // "Your_Application_ServerMode";

		// Bank
		public static const BANK_ITEM_ID :String                = "Your_Bank_Item_ID";

		// Textdata
		public static const TEXT_GROUP_NAME	:String             = "Your_Textdata_Group_Name";

		// Leaderboard
		public static const LEADERBOARD_ID	:String             = "Your_Leaderboard_ID";
		public static const LEADERBOARD_SCORE :String           = "Your_Leaderboard_Score_Value";
	
		// RemoteNotification
		public static const REMOTENOTIFICATION_MESSAGE :String  = "RemoteNotification_Sending_Message";
	
		// People
		public static const POPLE_TARGET_USERS :String          = "Target users"; // "UserId,UserId,...,UserId" 

		// Profanity
		public static const PROFANITY_NG_WORD :String           = "I love sex.";
		public static const PROFANITY_OK_WORD :String           = "Hello.";

		// BlackList
		public static const BLACK_LIST_TARGET_USER_ID :String   = "Target user Id";

		// AppData
		public static const APPDATA_KEY :String                 = "Appdata_Keys"; // "Key,Key,...,Key"
		public static const APPDATA_VALUE :String               = "Appdata_Values"; // "value,value,...,value"
    }
}

