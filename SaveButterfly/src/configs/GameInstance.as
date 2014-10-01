package configs
{
	import flash.display.DisplayObject;
	
	import events.GameEvent;
	
	import infos.GameRecord;
	import infos.data.LocalSO;

	public class GameInstance
	{
		public function GameInstance()
		{
		}
		
		private static var _instance:GameInstance;
		
		public static function get instance():GameInstance
		{
			if (_instance == null)
				_instance = new GameInstance();
			return _instance;
		}
		
		public var app:DisplayObject;
		
		
		public static const APP_NAME:String = "air.com.kunpeng.caimogu";
		
		public var currentLev:int = 1;
		private var _maxLevel:int = 1;
		
		public var leftTime:int = 0;
		
		private var _needRecover:Boolean = false;
		
		public var isIos:Boolean = false;
		
		public var sceneWidth:int = 640;
		
		public var sceneHeight:int = 600;
		
		
		public var shareLeftCount:int = 1;
		
		public var currentRankData:Array = [];
		private  var _gold:int = 0;
		
		public var moreGameOpen:Boolean = false;
		
		public var LOG_CLASS:Class;
		
		public var scoreRecord:GameRecord = new GameRecord();
		
		public var so:LocalSO;
		
		public var lastShowFullAd:int;
		
		
		/**
		 * 剩下几局显示大屏广告
		 */		
		public var leftShowFullAd:int = 2;
		/**
		 *每5局显示一次 
		 */		
		public static const FULLE_AD:int = 2;
		
		
		public var soundEnable:Boolean = true;
		
		public var YLXD_XML:XML = null;
		
		public var haveStarlingCreate:Boolean = false;
		
		public var resLoadCom:Boolean = false;
		
		
		public var gameState:int = 0;
		
		/**
		 * 适应多分辨率，缩放资源大小
		 */		
		public var scaleRatio:Number = 1.0;
		
		
		
		public static var beginTime:int = 0;
		public static var playCount:int = 0;
		
		
		public static function isPause():Boolean
		{
			return instance.gameState == GameState.PAUSE;
		}

		/**
		 * 金币
		 */
		public function get gold():int
		{
			return _gold;
		}

		/**
		 * @private
		 */
		public function set gold(value:int):void
		{
			_gold = value;
			this.so.setAt("gold",value);
			EventCenter.instance.dispatchGameEvent(GameEvent.UPDATE_GOLD);
		}

		public function get maxLevel():int
		{
			return _maxLevel;
		}

		public function set maxLevel(value:int):void
		{
			_maxLevel = value;
			this.so.setAt("maxlevel",value);
		}

		public function get needRecover():Boolean
		{
			return _needRecover;
		}

		public function set needRecover(value:Boolean):void
		{
			_needRecover = value;
			this.so.setAt("needrecover",value);
		}

		

		
	}
}