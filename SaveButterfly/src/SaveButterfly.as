package
{
	import com.freshplanet.ane.AirAlert.AirAlert;
	import com.mike.utils.AdvertiseUtil;
	import com.mike.utils.DeviceUtil;
	import com.mike.utils.FlurryUtil;
	import com.mike.utils.GameInfo;
	import com.mike.utils.LanUtil;
	import com.mike.utils.MoreGameUtil;
	import com.mike.utils.NetUtil;
	import com.mike.utils.PlatType;
	import com.mike.utils.PlatUtil;
	import com.mike.utils.ResolutionUtil;
	import com.mike.utils.ShareManager;
	import com.mike.utils.TimeUtil;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import configs.GameInstance;
	
	import events.GameEvent;
	
	import infos.data.LocalSO;
	
	import managers.ButterflyManager;
	import managers.GameUtil;
	import managers.ResManager;
	import managers.SoundManager;
	
	import modules.mainui.views.WorkRoomIntroduce;
	
	import starling.core.Starling;
	import starling.utils.AssetManager;
	
	public class SaveButterfly extends Sprite
	{
		
		[Embed(source="assets/logo.png")]
		public var LogAsset:Class;
		
//		[Embed(source="assets/msyahei.ttf", embedAsCFF="false", fontFamily="yahei")]
//		private static const YaHei:Class;
		
		private var app:Starling;
		
		public function SaveButterfly()
		{
			if (stage){
				init(null);
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.BACK)
			{
				if (PlatUtil.isCertainPlat(PlatType.ANDROID_4399))
				{
					AdvertiseUtil.showExitScreen();
					return;
				}
				e.preventDefault();
				var okFunc:Function = function():void
				{
					FlurryUtil.logEvent(FlurryUtil.PLAYCOUNT,GameInstance.playCount);
					NetUtil.sendRecord(DeviceUtil.getDeviceID(),getTimer()-GameInstance.beginTime,GameInstance.playCount,GameInstance.instance.currentLev);
					setTimeout(onExit,500);
				};
				var cancelFunc:Function = function():void
				{
					e.preventDefault();
				};
//				AirAlert.getInstance().showAlert(Language.getString("EXIT_DESC"),"",Language.getString("QUEDING"),okFunc,Language.getString("QUXIAO"),cancelFunc);
			}
		}
		
		protected function onExit(event:Event=null):void
		{
			FlurryUtil.end();
			NativeApplication.nativeApplication.exit();
		}
		
		private function onGameDeactivate(e:Event):void
		{
			EventCenter.instance.dispatchGameEvent(GameEvent.STAGE_DEACTIVATE);
		}
		private function onGameActivate(e:Event):void
		{
			EventCenter.instance.dispatchGameEvent(GameEvent.STAGE_ACTIVATE);
		}
		private var _introduce:WorkRoomIntroduce;
		
		private function init(event:Event=null):void
		{
			GameInfo.NAME = "butterfly";
			DeviceUtil.isIos();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 30;
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			//						Starling.multitouchEnabled = false;
			
			
			ResolutionUtil.instance.init(new Point(640,960));
			
			ShareManager.instance.init();
			FlurryUtil.init();
			beginTime = getTimer();
			FlurryUtil.logEvent(FlurryUtil.LOADINGRES,beginTime);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(Event.DEACTIVATE, onGameDeactivate);
			stage.addEventListener(Event.ACTIVATE, onGameActivate);
			GameInstance.instance.sceneWidth = Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
			GameInstance.instance.sceneHeight = Math.max(stage.fullScreenWidth, stage.fullScreenHeight);
			GameInstance.instance.scaleRatio = 1;//ResolutionUtil.instance.getBestRatio(GameInstance.instance.sceneWidth,GameInstance.instance.sceneHeight);
			
			GameInstance.instance.LOG_CLASS = LogAsset;
			EventCenter.instance.addEventListener(GameEvent.STARLING_CREATE, onStarlingCreated);
			var rect:Rectangle ;
			rect = new Rectangle(0,0,Math.min(stage.fullScreenWidth, stage.fullScreenHeight),Math.max(stage.fullScreenWidth, stage.fullScreenHeight));
			showIntroduce();
			if (!DeviceUtil.ios)
				Starling.handleLostContext = true;
			app = new Starling(Game,stage,rect,null,"auto","auto");
			app.stage.stageWidth = 640;
			app.stage.stageHeight = 960;
			app.stage.color = 0x005982;
			//			app.showStats = true;
			app.start();
			loadRes(null);
			GameUtil.getData();
			//			stage.addEventListener(Event.ENTER_FRAME, onenterframe);
		}
		
		protected function onenterframe(event:Event):void
		{
			trace("1");
		}
		
		private var beginTime:int = 0;
		
		protected function onStarlingCreated(event:GameEvent):void
		{
			GameInstance.instance.haveStarlingCreate = true;
			starGame();
		}
		/**
		 * 显示工作室简介
		 * 
		 */		
		private function showIntroduce():void
		{
			_introduce = new WorkRoomIntroduce();
			_introduce.resize(ResolutionUtil.instance.designWidth,ResolutionUtil.instance.designHeight);
			_introduce.addEventListener(MouseEvent.CLICK, onClick);
			_introduce.scaleX = GameInstance.instance.sceneWidth/ResolutionUtil.instance.designWidth;
			_introduce.scaleY = GameInstance.instance.sceneHeight/ResolutionUtil.instance.designHeight;
			this.addChild(_introduce);
			//			var t:int = getTimer();
			//			setTimeout(timeOut, 2000);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			starGame();
		}
		
		private var timeBool:Boolean = false;
		private function timeOut():void
		{
			timeBool = true;
			starGame();
		}
		
		
		private function initData():void
		{
			GameInstance.instance.so = new LocalSO("com.kunpeng.butterfly.5597key");
			GameUtil.setMaxScore(GameInstance.instance.so.getAt("score") as int);
			GameInstance.instance.maxLevel = GameInstance.instance.so.getAt("maxlevel") as int;
			GameInstance.instance.gold = GameInstance.instance.so.getAt("gold") as int;
			GameInstance.instance.currentLev = GameInstance.instance.so.getAt("currentlevel") as int;
			AdvertiseUtil.clickCount = GameInstance.instance.so.getAt("adclick") as int;
			ShareManager.instance.shareCount = GameInstance.instance.so.getAt("sharecount") as int;
			var lastLoginTime:int = int(GameInstance.instance.so.getAt("last_login_time"));
			if (lastLoginTime == 0 || lastLoginTime < TimeUtil.getTodayZeroTime())
			{
				ShareManager.instance.shareCount = 0;
				var comFunc:Function = function(pa:*):void
				{
					GameInstance.instance.so.setAt("last_login_time",TimeUtil.getNowTime());
				};
//				NetUtil.sendLogin(DeviceUtil.getDeviceID(),DeviceUtil.getDeviceName(),comFunc);
			}
		}
		
		public function loadRes(e:GameEvent):void
		{
			
			
			ResManager.resLoader = new BulkLoader("main");
			
			ResManager.resLoader.add(ResManager.YLXDXML);
			ResManager.resLoader.add(ResManager.YLXD);
			ResManager.resLoader.add(ResManager.YLXDXML3);
			ResManager.resLoader.add(ResManager.YLXD3);
			ResManager.resLoader.add(ResManager.YLXDXML4);
			ResManager.resLoader.add(ResManager.YLXD4);
			ResManager.resLoader.add(ResManager.CANDYCONFIG);
			var item:LoadingItem = ResManager.resLoader.add(ResManager.BASE + LanUtil.getCurrentLangeFile());
			var lanFunc:Function = function(e:flash.events.Event):void
			{
				item.removeEventListener(flash.events.Event.COMPLETE, lanFunc);
				Language.parse(item.content);
			};
			item.addEventListener(flash.events.Event.COMPLETE,lanFunc);
			
			
			var comp:Function = function(e:BulkProgressEvent):void
			{
				ResManager.resLoader.removeEventListener(BulkProgressEvent.COMPLETE, comp);
				GameInstance.instance.resLoadCom = true;
				ButterflyManager.parse(ResManager.resLoader.getContent(ResManager.CANDYCONFIG));
				var am:AssetManager = new AssetManager();
				ResManager.assetsManager = am;
				starGame();
				SoundManager.init();
			};
			ResManager.resLoader.addEventListener(BulkProgressEvent.COMPLETE,comp);
			ResManager.resLoader.start();
		}
		
		private function starGame():void
		{
			if (_introduce.parent == null)
				return;
			trace(GameInstance.instance.resLoadCom,GameInstance.instance.haveStarlingCreate,timeBool);
			if (GameInstance.instance.resLoadCom && GameInstance.instance.haveStarlingCreate)
			{
				AdvertiseUtil.initBaiDu(stage);
				initData();
				GameInstance.instance.leftShowFullAd = AdvertiseUtil.FULLE_AD;
				_introduce.removeEventListener(MouseEvent.CLICK, onClick);
				this.removeChild(_introduce);
				EventCenter.instance.dispatchEvent(new GameEvent(GameEvent.START_GAME));
				GameInstance.beginTime = getTimer();
				FlurryUtil.logEvent(FlurryUtil.ENTER_GAME,getTimer()-beginTime);
			}
		}
	}
}