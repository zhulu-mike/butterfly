package modules.mainui.views
{
	import com.mike.utils.AdvertiseUtil;
	
	import configs.GameInstance;
	import configs.GameState;
	
	import core.Controller;
	
	import events.GameEvent;
	
	import managers.GameUtil;
	import managers.LogManager;
	
	import org.zengrong.ane.ANEToolkit;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainMenuController extends Controller
	{
		public function MainMenuController(view:Object)
		{
			super(view);
			initUI();
		}
		
		public function get panel():MainMenu
		{
			return viewComponent as MainMenu;
		}
		
		private function initUI():void
		{
			panel.beginTxt.addEventListener(TouchEvent.TOUCH, onBegin);
			panel.continueTxt.addEventListener(TouchEvent.TOUCH, onContinue);
			panel.more.addEventListener(TouchEvent.TOUCH, onShowMoreGame);
			panel.desc.addEventListener(TouchEvent.TOUCH, onShowIntroduce);
		}
		
		private function onContinue(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				if (GameInstance.instance.needRecover)
				{
					var callBack:Function = function(issure:Boolean):void
					{
						if (issure)
						{
							panel.hide();
							EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.RUNNING});
						}
					}
					EventCenter.instance.dispatchGameEvent(GameEvent.SHOW_RECOVER_ALERT,callBack);
				}else{
					panel.hide();
					EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.RUNNING});
				}
			}
		}		
		
		protected function onShowMoreGame(e:TouchEvent):void
		{
			//展示机场
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				EventCenter.instance.dispatchGameEvent(GameEvent.SHOW_MORE_GAME);
			}
		}
		
		private function onShowIntroduce(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
//				AdvertiseUtil.hideBaiDuBanner();
				panel.parent.removeChild(panel);
				EventCenter.instance.dispatchGameEvent(GameEvent.SHOW_INTRODUCE);
			}
		}
		
		private function onBegin(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				LogManager.logTrace("开始游戏");
				GameInstance.instance.currentLev = 1;
				GameInstance.instance.so.setAt("currentlevel",1);
				GameInstance.instance.needRecover = false;
				panel.hide();
				EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.RUNNING});
			}
		}
		
		
	}
}