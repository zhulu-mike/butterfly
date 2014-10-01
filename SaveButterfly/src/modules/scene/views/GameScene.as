package modules.scene.views
{
	
	import com.mike.utils.AdvertiseUtil;
	
	import configs.GameInstance;
	import configs.GameState;
	
	import events.GameEvent;
	
	import managers.GameUtil;
	import managers.ResManager;
	import managers.SoundManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameScene extends Sprite
	{
		
		
		
		private var middleLayer:Sprite;
		
		private var helpPanel:HelpPanel;
		
		public function GameScene()
		{
			
			EventCenter.instance.addEventListener(GameEvent.PLAY_GAME_OVER_SOUND, playGameOverSound);
			middleLayer = new Sprite();
			this.addChild(middleLayer);
			

			
			makePuTong();
			
			EventCenter.instance.addEventListener(GameEvent.STAGE_ACTIVATE, onStageActivate);
			EventCenter.instance.addEventListener(GameEvent.STAGE_DEACTIVATE, onStageDeactivate);
		}
		
		private var needRestart:Boolean = false;
		protected function onStageDeactivate(event:GameEvent):void
		{
			if (GameInstance.instance.gameState == GameState.RUNNING)
			{
				needRestart = true;
				pauseGame();
			}
		}
		
		protected function onStageActivate(event:GameEvent):void
		{
			if (needRestart)
			{
				needRestart = false;
				restart();
			}
		}
		
		private function onTouchPause(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				if (GameInstance.instance.gameState != GameState.OVER)
				{
					if (GameInstance.instance.gameState == GameState.PAUSE)
					{
						restart();
					}else{
						pauseGame();
					}
				}
			}
			e.stopImmediatePropagation();
		}
		
		private function pauseGame():void
		{
			GameInstance.instance.gameState = GameState.PAUSE;
			EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.PAUSE});
			var s:ISceneBase;
			for each (s in sceneList)
			{
				s.pauseGame();
			}
		}
		
		public function restart():void
		{
			GameInstance.instance.gameState = GameState.CONTINUE
			EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.CONTINUE});
			var s:ISceneBase;
			for each (s in sceneList)
			{
				s.restart();
			}
		}
		
		public var sceneList:Vector.<ISceneBase> = new Vector.<ISceneBase>();
		
		public function start():void
		{
			var s:ISceneBase;
			for each (s in sceneList)
			{
				s.start();
			}
			AdvertiseUtil.showBaiDuBanner();
		}
		
		/**
		 * 先销毁之前的
		 * 
		 */		
		private function destory():void
		{
			var s:ISceneBase;
			for each (s in sceneList)
			{
				s.destroy();
				middleLayer.removeChild(s as DisplayObject);
			}
			sceneList.length = 0;
		}
		/**
		 * 普通模式
		 * 
		 */		
		private function makePuTong():void
		{
			var scene:NormalScene = new NormalScene();
			middleLayer.addChild(scene);
			sceneList.push(scene);
		}
		
		
		public function update():void
		{
			var s:ISceneBase;
			for each (s in sceneList)
			{
				s.update();
			}
		}
		
		
		private function playGameOverSound(e:GameEvent):void
		{
			SoundManager.playSound(ResManager.GAME_OVER);
		}
		
		public function showHelpPanel():void
		{
			if (helpPanel == null)
			{
				helpPanel = new HelpPanel();
			}
			Starling.juggler.removeTweens(helpPanel);
			middleLayer.addChild(helpPanel);
			helpPanel.y = -helpPanel.height;
			var t:Tween = new Tween(helpPanel,0.5,Transitions.EASE_OUT);
			t.animate("y",0);
			t.onComplete = function():void
			{
				Starling.juggler.remove(t);
			};
			Starling.juggler.add(t);
		}
		
		
		public function hideHelpPanel():void
		{
			Starling.juggler.removeTweens(helpPanel);
			var t:Tween = new Tween(helpPanel,0.5,Transitions.EASE_OUT);
			t.animate("y",-helpPanel.height);
			t.onComplete = function():void
			{
				Starling.juggler.remove(t);
				helpPanel.removeFromParent();
			};
			Starling.juggler.add(t);
		}
		
	}
}