package com.mike.utils
{
	import com.freshplanet.nativeExtensions.Flurry;
	
	import org.zengrong.ane.ANEToolkit;

	public class FlurryUtil
	{
		public function FlurryUtil()
		{
		}
		
		public static const LOADINGRES:String = "beginloadres";
		public static const ENTER_GAME:String = "entergame";
		public static const PLAYCOUNT:String = "playcount";
		public static const ATTEMPTSHARE:String = "attemptshare";
		public static const SHAREERROR:String = "shareerror";
		public static const SHOWMOREGAME:String = "showmoregame";
		
		public static function init():void
		{
//			if (Flurry.isSupported)
//			{
//				Flurry.getInstance().setAndroidAPIKey("Q7BHVBP8K2RWDG8VYMPK");
//				Flurry.getInstance().setIOSAPIKey("HTXXBBBHVY3NYGN5Y5ZT");
//				Flurry.getInstance().setAppVersion("0.0.1");
//				Flurry.getInstance().startSession();
//				Flurry.getInstance().iOSCrashReportingEnabled = true;
//				Flurry.getInstance().setUserId(DeviceUtil.getDeviceID());
//			}
		}
		
		public static function end():void
		{
//			Flurry.getInstance().stopSession();
		}
		
		public static function logEvent(name:String,data:Object=null):void
		{
//			Flurry.getInstance().logEvent(name,data);
		}
	}
}