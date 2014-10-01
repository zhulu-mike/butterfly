package com.mike.utils
{
	import com.kunpeng.dianjin91.DianJin91;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import configs.GameInstance;
	
	import so.cuo.platform.baidu.BaiDu;
	import so.cuo.platform.baidu.BaiDuAdEvent;
	import so.cuo.platform.baidu.RelationPosition;

	public class AdvertiseUtil
	{
		public function AdvertiseUtil()
		{
		}
		
		private static var stage:Stage;
		private static var isIos:Boolean = false;
		private  static var _clickCount:int = 0;
		public static var FULLE_AD:int = 2;
		
		public static function initBaiDu(s:Stage):void
		{
			stage = s;
			
				//android和ios之分
//			isIos = DeviceUtil.ios;
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY))
//			{
//				if (Admob.getInstance().supportDevice)
//				{
//					if (isIos)
//						Admob.getInstance().setKeys("ca-app-pub-7801284693895243/8743911815","ca-app-pub-7801284693895243/2697378219");
//					else
//						Admob.getInstance().setKeys("ca-app-pub-7801284693895243/8923551814","ca-app-pub-7801284693895243/1400285010");
//					Admob.getInstance().cacheInterstitial();
//					Admob.getInstance().addEventListener(AdmobEvent.onInterstitialDismiss, onFullMiss);
//					Admob.getInstance().addEventListener(AdmobEvent.onInterstitialReceive, onFullReveive);
//					Admob.getInstance().addEventListener(AdmobEvent.onInterstitialFailedReceive, onFullFailedReveive);
//					Admob.getInstance().addEventListener(AdmobEvent.onInterstitialLeaveApplication, onFullLeave);
//					Admob.getInstance().addEventListener(AdmobEvent.onInterstitialPresent, onFullPresent);
//					Admob.getInstance().addEventListener(AdmobEvent.onBannerLeaveApplication, onBannerPresent);
//				}
//			}else if (PlatUtil.isCertainPlat(PlatType.ANDROID_4399)){
//				SsjjAdsManager.getInstance().init();
//				SsjjAdsManager.getInstance().addEventListener(Constants.EVENT_TYPE_ADS_CALLBACK, onAdsCallback);
//			}else{
//				if (BaiDu.getInstance().supportDevice)
//				{
//					BaiDu.getInstance().setKeys("100421f7","100421f7");// BaiDu.getInstance().setKeys("appsid","计费id");
//					BaiDu.getInstance().cacheInterstitial();
//					BaiDu.getInstance().addEventListener(BaiDuAdEvent.onInterstitialDismiss, onFullMiss);
//					BaiDu.getInstance().addEventListener(BaiDuAdEvent.onInterstitialReceive, onFullReveive);
//					BaiDu.getInstance().addEventListener(BaiDuAdEvent.onInterstitialFailedReceive, onFullFailedReveive);
//					BaiDu.getInstance().addEventListener(BaiDuAdEvent.onInterstitialLeaveApplication, onFullLeave);
//					BaiDu.getInstance().addEventListener(BaiDuAdEvent.onInterstitialPresent, onFullPresent);
//					BaiDu.getInstance().addEventListener(BaiDuAdEvent.onBannerLeaveApplication, onBannerPresent);
//				}
//			}else{
//				if (DianJin91.instance.supportDevice)
//				{
//					DianJin91.instance.setKeys(58441,"1f29d677bf6280806bdc480f603fa2ad",1001);
//				}
//		}
			cacheMoreGame();
		}
		
//		protected static function onBannerSwitch(event:YouMiEvent):void
//		{
//			// TODO Auto-generated method stub
//			trace("banner switch");
//		}
//		
//		protected static function onBannerReceived(event:YouMiEvent):void
//		{
//			trace("banner received");
//		}
		
		/*private static function onAdsCallback(e:AdsCallbackEvent):void{
			//广告类展示、关闭、失败回调
			if(e.adType == Constants.AD_TYPE_BANNER){
				//banner
			}else if(e.adType == Constants.AD_TYPE_PAUSE){
				//插屏
			}else if(e.adType == Constants.AD_TYPE_FULL){
				//全屏
			}else if(e.adType == Constants.AD_TYPE_OFFERS){
				//积分墙
			}else if(e.adType == Constants.AD_TYPE_EXIT){
				//退出时广告显示
				if(e.status == Constants.STATUS_EXIT_YES){
					//确定退出
					clearAdCache();
					NativeApplication.nativeApplication.exit();
				}else if(e.status == Constants.STATUS_EXIT_NO){
					//取消退出
				} 
			}
			trace("4399广告类型："+e.adType,"展示状态"+e.status);
		}*/
		
		protected static function onFullPresent(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("全屏广告present");
		}
		protected static function onBannerPresent(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("广告被点击一次present");
			clickCount++;
		}
		
		protected static function onFullLeave(event:Event):void
		{
			//如果全屏广告点击一次，则肯定是关闭，如果超过1次，则说明玩家已经点击了广告
			clickCount++;
			trace("全屏广告离开");
		}
		
		protected static function onFullFailedReveive(event:Event):void
		{
			// TODO Auto-t method stub
			trace("全屏广告接收失败");
		}
		
		protected static function onFullReveive(event:Event):void
		{
			trace("收到全屏广告");
		}
		
		protected static function onFullMiss(event:Event):void
		{
			trace("全屏广告关闭");
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY))
//				Admob.getInstance().cacheInterstitial();
//			else
//				BaiDu.getInstance().cacheInterstitial();
//			else
//				YouMi.getInstance().cacheInterstitial();
		}
		
		
		
		public static function showBaiDuBanner():void
		{
			trace(stage.orientation);
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY))
//				Admob.getInstance().showBanner(Admob.BANNER,AdmobPosition.BOTTOM_CENTER);
//			else if (PlatUtil.isCertainPlat(PlatType.ANDROID_4399))
//				SsjjAdsManager.getInstance().showBanner();
//			else
//				BaiDu.getInstance().showBanner(BaiDu.BANNER,RelationPosition.BOTTOM_CENTER);
//			else
//				YouMi.getInstance().showBanner(RelationPosition.BOTTOM_CENTER);
		}
		
		public static function hideBaiDuBanner():void
		{
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY))
//				Admob.getInstance().hideBanner();
//			else if (PlatUtil.isCertainPlat(PlatType.ANDROID_4399))
//				SsjjAdsManager.getInstance().hideBanner();
//			else
//				BaiDu.getInstance().hideBanner();
//			else
//				YouMi.getInstance().hideBanner();
		}
		
		public static function cacheInterstitial():void
		{
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY))
//				Admob.getInstance().cacheInterstitial();
//			else
//				BaiDu.getInstance().cacheInterstitial();
//			else
//				YouMi.getInstance().cacheInterstitial();
		}
		
		public static function isInterstitialReady():Boolean
		{
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY))
//				return Admob.getInstance().isInterstitialReady();
//			else
//				return BaiDu.getInstance().isInterstitialReady();
//			else
//				return YouMi.getInstance().isInterstitialReady();
			return true;
		}
		
		private static var leaveCount:int = 0;
		
		public static function showInterstitial():void
		{
			leaveCount = 0;
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY)){
//				if (!DeviceUtil.ios && DeviceUtil.getDeviceName().indexOf("HUAWEI") >= 0)
//					return;
//				Admob.getInstance().showInterstitial();
//			}else if (PlatUtil.isCertainPlat(PlatType.ANDROID_4399))
//				SsjjAdsManager.getInstance().showFullScreen();
//			else
//				BaiDu.getInstance().showInterstitial();
//			else
//				YouMi.getInstance().showInterstitial();
		}
		
		public static function getBaiDuInstance():EventDispatcher
		{
//			if (isIos || PlatUtil.isCertainPlat(PlatType.GOOGLE_PLAY))
//				return Admob.getInstance();
//			else if (PlatUtil.isCertainPlat(PlatType.ANDROID_4399))
//				return SsjjAdsManager.getInstance();
//			else
//				return BaiDu.getInstance();
//			else
//				return YouMi.getInstance();
			return null;
		}
		
		/**
		 * 4399显示退出插屏广告
		 * 
		 */		
		public static function showExitScreen():void
		{
//			SsjjAdsManager.getInstance().showExitScreen(); 
		}
		
		/**
		 * 清除广告缓存
		 * 
		 */		
		public static function clearAdCache():void
		{
//			if (PlatUtil.isCertainPlat(PlatType.ANDROID_4399))
//					SsjjAdsManager.getInstance().clearAdsCache();
		}
		
		/**
		 * 积分墙是否准备好
		 * @return 
		 * 
		 */		
		public static function isMoreGameReady():Boolean
		{
			return false;
		}
		
		/**
		 * 显示积分墙广告
		 * 
		 */		
		public static function showMoreGame():void
		{
//			DianJin91.instance.showInterstitial();
//			FlurryUtil.logEvent(FlurryUtil.SHOWMOREGAME);
		}
		
		public static function checkPoints():void
		{
//			DMOfferWallExtension.DMcheckSocre();
		}
		
		public static function cacheMoreGame():void
		{
			
		}

		public static function get clickCount():int
		{
			return _clickCount;
		}

		public static function set clickCount(value:int):void
		{
			_clickCount = value;
			if (value >= 5)
			{
				FULLE_AD = 8;
			}else if (value >= 2)
			{
				FULLE_AD = 4;
			}else{
				FULLE_AD = 2;
			}
			GameInstance.instance.so.setAt("adclick",value);
		}

	}
}