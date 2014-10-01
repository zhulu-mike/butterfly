package modules.scene.views
{
	import com.mike.utils.AdvertiseUtil;
	import com.mike.utils.ResolutionUtil;
	import com.mike.utils.ShareManager;
	import com.mike.utils.SoundUtil;
	
	import configs.GameInstance;
	import configs.GameState;
	
	import events.GameEvent;
	
	import managers.ResManager;
	import managers.ButterflyManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class GameOver extends Sprite
	{
		
		
		private var scoretxt:TextField;
		
		private var dabai:TextField;
		
		private var returnBtn:Image;

		private var xiuxi:Image;
		
		public function GameOver()
		{
			
			var bg:Quad = new Quad(ResolutionUtil.instance.designWidth,ResolutionUtil.instance.designHeight,0x1b1b1b);
			this.addChild(bg);
			
			returnBtn = new Image(ResManager.assetsManager.getTexture("return.png"));
			this.addChild(returnBtn);
			returnBtn.x = ResolutionUtil.instance.designWidth - returnBtn.width >> 1;
			returnBtn.y = 30;
			
			var title:Image = new Image(ResManager.assetsManager.getTexture("title1.png"));
			this.addChild(title);
			title.x = ResolutionUtil.instance.designWidth - title.width >> 1;
			title.y = 110;
			
			scoretxt = new TextField(400,50,"","yahei",48,0x00ffff);
			this.addChild(scoretxt);
			scoretxt.x = ResolutionUtil.instance.designWidth - scoretxt.width >> 1;
			scoretxt.y = 170;
			
			dabai = new TextField(400,50,"","yahei",30,0x18871a);
			this.addChild(dabai);
			dabai.x = ResolutionUtil.instance.designWidth - dabai.width >> 1;
			dabai.y = 230;
			
			var sharedesc:Image = new Image(ResManager.assetsManager.getTexture("sharedesc.png"));
			this.addChild(sharedesc);
			sharedesc.x = ResolutionUtil.instance.designWidth - sharedesc.width >> 1;
			sharedesc.y = 300;
			
			var share:Image = new Image(ResManager.assetsManager.getTexture("share.png"));
			this.addChild(share);
			share.x = ResolutionUtil.instance.designWidth - share.width >> 1;
			share.y = 390;
			share.addEventListener(TouchEvent.TOUCH, onShare);
			
			var tiaozhan:Image = new Image(ResManager.assetsManager.getTexture("again.png"));
			this.addChild(tiaozhan);
			tiaozhan.y = 490;
			tiaozhan.x = ResolutionUtil.instance.designWidth - tiaozhan.width >> 1;
			
			xiuxi = new Image(ResManager.assetsManager.getTexture("moregame.png"));
			this.addChild(xiuxi);
			xiuxi.y = 600;
			xiuxi.x = ResolutionUtil.instance.designWidth - xiuxi.width >> 1;
			
			
			
			tiaozhan.addEventListener(TouchEvent.TOUCH, onAgain);
			returnBtn.addEventListener(TouchEvent.TOUCH, onReturn);
			xiuxi.addEventListener(TouchEvent.TOUCH, onMoreGame);
		}
		
		private function onMoreGame(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
//				EventCenter.instance.dispatchGameEvent(GameEvent.SHOW_MORE_GAME);
				AdvertiseUtil.showMoreGame();
			}
		}
		
		private function onShare(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				ShareManager.instance.xuanYao();
			}
		}
		
		
		
		public function show(score:int):void
		{
			scoretxt.text = ButterflyManager.getLevelName(score)+"lv"+score;
			xiuxi.visible = GameInstance.instance.moreGameOpen;
			if (score < 40)
				dabai.text = "恭喜你比全国"+int(score/40*100)+"%的人爱国";
			else
				dabai.text = "天啊，没有人比你更爱国了";
			Starling.juggler.removeTweens(this);
			var t:Tween = new Tween(this,0.5,Transitions.EASE_OUT_BACK);
			t.animate("y",0);
			t.onComplete = function():void
			{
				Starling.juggler.remove(t);
			};
			Starling.juggler.add(t);
		}
		
		private function onReturn(e:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var t:Touch = e.touches[0];
			if (t.phase == TouchPhase.ENDED)
			{
				hide();
				EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.BEGIN});
			}
		}
		
		private function onAgain(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			if (t.phase == TouchPhase.ENDED)
			{
				hide();
				EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.RUNNING});
			}
		}
		
		private function hide():void
		{
			// TODO Auto Generated method stub
			Starling.juggler.removeTweens(this);
			var t:Tween = new Tween(this,0.5,Transitions.EASE_OUT_BACK);
			t.animate("y",-this.height);
			t.onComplete = function():void
			{
				removeFromParent();
				Starling.juggler.remove(t);
			};
			Starling.juggler.add(t);
		}
		
	}
}