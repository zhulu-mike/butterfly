package com.mike.utils
{
	import cn.sharesdk.ane.PlatformID;
	import cn.sharesdk.ane.ShareMenuArrowDirection;
	import cn.sharesdk.ane.ShareSDKExtension;
	import cn.sharesdk.ane.ShareType;
	
	import configs.GameInstance;
	
	import infos.data.LocalSO;
	
	import managers.ButterflyManager;

	public class ShareManager
	{
		public function ShareManager()
		{
		}
		
		private static var _instance:ShareManager;
		
		public static function get instance():ShareManager
		{
			if (_instance == null)
				_instance = new ShareManager();
			return _instance;
		}
		private var _shareCount:int = 0;
//		private var sdk:ShareSDKExtension;
		
		/**
		 * 初始化ShareSDK
		 * 
		 */		
		public function init():void
		{
//			sdk = new ShareSDKExtension();
			//android和ios之分
//			if (DeviceUtil.ios){
//				sdk.open("3244fa17d870",true);//284c24ba9586//iosv1101
//				sdk.setPlatformConfig(PlatformID.SinaWeibo,{app_key:"458182349",app_secret:"fee52007358c5ba2c46ee30c0aba6209",redirect_uri:"http://www.g6game.com/butterfly/"});
//				sdk.setPlatformConfig(PlatformID.WeChatTimeline,{app_id:"wxe763610d5c2f30e5"});
//				sdk.setPlatformConfig(PlatformID.WeChatFav,{app_id:"wxe763610d5c2f30e5"});
//				sdk.setPlatformConfig(PlatformID.WeChatSession,{app_id:"wxe763610d5c2f30e5"});
//			}else{
//				sdk.open("3244a4aec759",true);
//			}
//			sdk.setPlatformActionListener(shareComplete,shareError,sharecancel);
		}
		private function shareComplete(platform:int, action:int, res:Object):void
		{
			
			var json:String = (res == null ? "" : JSON.stringify(res));
			var message:String = "onComplete\nPlatform=" + platform + ", action=" + action + "\nres=" + json;
//			AirAlert.getInstance().showAlert(message,"");
//			sdk.toast(message);
			if (shareCount < 2)
			{
				GameInstance.instance.gold += 20;
			}
			shareCount++;
			trace(message);
		}
		private function shareError(platform:int, action:int, err:Object):void
		{
			var json:String = (err == null ? "" : JSON.stringify(err));
			var message:String = "onError\nPlatform=" + platform + ", action=" + action + "\nres=" + json;
//			AirAlert.getInstance().showAlert(message,"");
//			sdk.toast(message);
//			FlurryUtil.logEvent(FlurryUtil.SHAREERROR,message);
			trace(message);
		}
		private function sharecancel(platform:int, action:int):void
		{
			var message:String = "onCancel\nPlatform=" + platform + ", action=" + action;
//			AirAlert.getInstance().showAlert(message,"");
//			sdk.toast(message);
			trace(message);
		}
		
		/**
		 * 分享
		 * 
		 */		
		public function xuanYao():void
		{
			var shareParams:Object = new Object();
			shareParams.title = Language.getString("GAMENAME");
			shareParams.titleUrl = "http://www.g6game.com/butterfly/";
			var nn:String = ButterflyManager.getLevelName(Math.max(1,GameInstance.instance.currentLev-1))+"lv"+Math.max(1,GameInstance.instance.currentLev-1);
			shareParams.text = Language.getString("SHARECONTENT").replace("$SCORE",nn);
			shareParams.site = shareParams.title;
			shareParams.url = "http://www.g6game.com/butterfly/";
			shareParams.description = shareParams.title;
			shareParams.siteUrl = "http://www.g6game.com/butterfly/";
			shareParams.imagePath = AirUtil.screenShotAndSave();
			shareParams.comment = shareParams.text;
//			shareParams.type = ShareType.SHARE_WEBPAGE;
//			sdk.showShareMenu(null, shareParams, GameInstance.instance.sceneWidth>>2, 50, ShareMenuArrowDirection.Up);
		}
		
		public function get shareCount():int
		{
			return _shareCount;
		}
		
		public function set shareCount(value:int):void
		{
			_shareCount = value;
			GameInstance.instance.so.setAt("sharecount",value);
		}
	}
}