package
{
	
	import com.freshplanet.ane.AirAlert.AirAlert;
	import com.mike.utils.AdvertiseUtil;
	import com.mike.utils.ResolutionUtil;
	import com.mike.utils.ShareManager;
	import com.mike.utils.SoundUtil;
	
	import configs.GameInstance;
	import configs.GameState;
	
	import events.GameEvent;
	
	import managers.GameUtil;
	import managers.ResManager;
	
	import modules.mainui.views.MainMenu;
	import modules.mainui.views.PlayerWordPanel;
	import modules.mainui.views.WorkRoomIntroduceStarling;
	import modules.scene.views.ChapterChoosPanel;
	import modules.scene.views.GameOver;
	import modules.scene.views.GameScene;
	import modules.scene.views.MoreGamePanel;
	import modules.scene.views.RecoverAlert;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Game extends Sprite
	{
		private var music:Image;
		private var firstLayer:Sprite;
		private var secondeLayer:Sprite;
		private var thirdLayer:Sprite;
		private var showBG:Boolean = true;
		private var bgItem:Image;
		
		public function Game()
		{
			EventCenter.instance.addEventListener(GameEvent.GAME_STATE_CHANGE, stateHandler);
			EventCenter.instance.addEventListener(GameEvent.START_GAME, beginAfterRes);
			this.addEventListener(Event.ADDED_TO_STAGE,onResize);
		}
		
		
		
		private function onResize(event:Event):void
		{
			trace("添加到舞台");
			EventCenter.instance.dispatchEvent(new GameEvent(GameEvent.STARLING_CREATE));
		}
		
		private function onRender(event:Event):void
		{
//			var t:int = getTimer();
			gameScene.update();
//			trace("背景耗时"+(getTimer() - t));
		}
		
		public function beginAfterRes(e:GameEvent=null):void
		{
			ResManager.assetsManager.addTextureAtlas(ResManager.YLXD_NAME, new TextureAtlas(Texture.fromBitmap(ResManager.resLoader.getContent(ResManager.YLXD)),ResManager.resLoader.getContent(ResManager.YLXDXML)));
			ResManager.assetsManager.addTextureAtlas(ResManager.YLXD_NAME3, new TextureAtlas(Texture.fromBitmap(ResManager.resLoader.getContent(ResManager.YLXD3)),ResManager.resLoader.getContent(ResManager.YLXDXML3)));
			ResManager.assetsManager.addTextureAtlas(ResManager.YLXD_NAME4, new TextureAtlas(Texture.fromBitmap(ResManager.resLoader.getContent(ResManager.YLXD4)),ResManager.resLoader.getContent(ResManager.YLXDXML4)));
//			ResManager.assetsManager.addTextureAtlas(ResManager.MOREGAME, new TextureAtlas(Texture.fromBitmap(ResManager.resLoader.getContent(ResManager.MOREGAMEPNG)),ResManager.resLoader.getContent(ResManager.MOREGAMEXML)));
			initUI();
			
			EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.BEGIN});
			EventCenter.instance.addEventListener(GameEvent.SHOW_INTRODUCE, onShowIntroduce);
			EventCenter.instance.addEventListener(GameEvent.SHOW_HELP_PANEL, onShowHelPanel);
			EventCenter.instance.addEventListener(GameEvent.SHOW_MORE_GAME, onShowMoreGamePanel);
		}
		
		protected function onShowMoreGamePanel(event:GameEvent):void
		{
			if (GameInstance.instance.moreGameOpen)
			{
				AdvertiseUtil.showMoreGame();
			}
		}
		
		private function initUI():void
		{
			firstLayer = new Sprite();
			this.addChild(firstLayer);
			
			secondeLayer = new Sprite();
			this.addChild(secondeLayer);
			
			thirdLayer = new Sprite();
			this.addChild(thirdLayer);
		}
		
		protected function onShowIntroduce(event:GameEvent):void
		{
			secondeLayer.addChild(introduce);
		}
		
		protected function onCloseIntroduce(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				secondeLayer.removeChild(_introduce);
				EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.BEGIN});
				AdvertiseUtil.showBaiDuBanner();
			}
		}
		
		
		
		private var _introduce:WorkRoomIntroduceStarling;
		public function get introduce():WorkRoomIntroduceStarling
		{
			if (_introduce == null){
				_introduce = new WorkRoomIntroduceStarling(ResolutionUtil.instance.designWidth, ResolutionUtil.instance.designHeight);
				_introduce.addEventListener(TouchEvent.TOUCH, onCloseIntroduce);
			}
			return _introduce;
		}
		
		
		private var _mainMenu:MainMenu;

		public function get mainMenu():MainMenu
		{
			if (_mainMenu == null){
				_mainMenu = new MainMenu();
			}
			return _mainMenu;
		}
		
		private var _gameScene:GameScene;

		public function get gameScene():GameScene
		{
			if (_gameScene == null)
				_gameScene = new GameScene();
			return _gameScene;
		}
		
		private var _gameOverPanel:GameOver;
		public function get gameOverPanel():GameOver
		{
			if (_gameOverPanel == null){
				_gameOverPanel = new GameOver();
			}
			return _gameOverPanel;
		}
		
		
		private function stateHandler(event:GameEvent):void
		{
			gameStateChange(event.data);
		}
		
		/**
		 * 游戏状态切换处理
		 * @param state
		 * @see also GameState.as
		 */		
		public function gameStateChange(data:Object):void
		{
			var state:int = data.state;
			GameInstance.instance.gameState = state;
			switch (state)
			{
				case GameState.BEGIN:
					begin();
					break;
				case GameState.RUNNING:
					gameRun();
					break;
				case GameState.PAUSE:
					pauseGame();
					break;
				case GameState.OVER:
					endGame(data);
					break;
				case GameState.CONTINUE:
					continueGame();
					break;
				default:
					break;
			}
		}
		
		private function continueGame():void
		{
			this.addEventListener(Event.ENTER_FRAME, onRender);
		}
		
		private function pauseGame():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onRender);
			
		}
		
		private function begin():void
		{
//			gameScene.removeFromParent();
			thirdLayer.addChild(mainMenu);
			mainMenu.continueTxt.visible = GameInstance.instance.currentLev > 1;
			mainMenu.show();
			if (GameInstance.instance.moreGameOpen == false)
				GameUtil.getData();
			AdvertiseUtil.showBaiDuBanner();
		}
		
		/**
		 * 开始游戏
		 * 
		 */		
		private function gameRun():void
		{
			AdvertiseUtil.hideBaiDuBanner();
			GameInstance.instance.currentLev = 1;
			GameInstance.playCount++;
			secondeLayer.addChild(gameScene);
			gameScene.start();
			this.addEventListener(Event.ENTER_FRAME, onRender);
		}
		
		private function endGame(data:Object):void
		{
			GameInstance.instance.gameState = GameState.OVER;
			this.removeEventListener(Event.ENTER_FRAME, onRender);
			beginLater(data);
		}
		
		
		
		private function beginLater(data:Object):void
		{
			thirdLayer.addChild(gameOverPanel);
			var gh:Number = gameOverPanel.height;
			gameOverPanel.y = -gh;
			gameOverPanel.show(data.level);
			GameUtil.showFullSceenAd();
			
			if (GameInstance.instance.shareLeftCount < 1)
			{
				var okFunc:Function = function():void
				{
					Starling.juggler.delayCall(ShareManager.instance.xuanYao,0.2);
				};
				var cancelFunc:Function = function():void
				{
					
				};
//				AirAlert.getInstance().showAlert(Language.getString("SHARETIP"),"",Language.getString("QUEDING"),okFunc,Language.getString("QUXIAO"),cancelFunc);
				GameInstance.instance.shareLeftCount = 1;
			}else{
				GameInstance.instance.shareLeftCount--;
			}
		}
		
		private function onShowHelPanel(event:GameEvent):void
		{
			var show:Boolean = event.data as Boolean;
			if (show)
				gameScene.showHelpPanel();
			else
				gameScene.hideHelpPanel();
		}
		
	}
}