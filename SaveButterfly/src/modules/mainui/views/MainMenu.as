package modules.mainui.views
{
	import com.mike.utils.MathUtil;
	import com.mike.utils.ResolutionUtil;
	import com.mike.utils.ShareManager;
	import com.mike.utils.SoundUtil;
	
	import configs.GameInstance;
	
	import events.GameEvent;
	
	import managers.ButterflyManager;
	import managers.ResManager;
	
	import modules.display.ScaleEffectImage;
	import modules.scene.views.Butterfly;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainMenu extends Sprite
	{
		
		public var beginTxt:ScaleEffectImage;
		public var continueTxt:ScaleEffectImage;
		public var desc:Image;
		public var log:Image;
		public var more:ScaleEffectImage;
		public var quguanggao:Image;
		public var music:Image;
		private var butterflys:Array = [];
		private var butterLayer:Sprite;
		
		
		public function MainMenu()
		{
			
			var bg:Image = new Image(ResManager.assetsManager.getTexture("mainbg.png"));
			this.addChild(bg);
			bg.touchable = false;
			
			
			desc = new Image(ResManager.assetsManager.getTexture("logodesc.png"));
			this.addChild(desc);
			desc.x = 10;
			desc.y = 10;
			
			var gamename2:Image = new Image(ResManager.assetsManager.getTexture("gamename.png"));
			this.addChild(gamename2);
			gamename2.x = ResolutionUtil.instance.designWidth - gamename2.width >> 1;
			gamename2.y = 75;
			gamename2.touchable = false;
			
			
			continueTxt = new ScaleEffectImage(ResManager.assetsManager.getTexture("jxyx.png"));
			this.addChild(continueTxt);
			continueTxt.y = 370;
			continueTxt.x = bg.width>>1;
			
			beginTxt = new ScaleEffectImage(ResManager.assetsManager.getTexture("cxks.png"));
			this.addChild(beginTxt);
			beginTxt.y = 470;
			beginTxt.x = continueTxt.x
			
			
//			
			more = new ScaleEffectImage(ResManager.assetsManager.getTexture("mfjb.png"));
			this.addChild(more);
			more.x = beginTxt.x
			more.y = 570;
			
			music = new Image(ResManager.assetsManager.getTexture("soundplay2.png"));
			this.addChild(music);
			music.x = 469;
			music.y = 612;
			music.addEventListener(TouchEvent.TOUCH, onTouchMusic);
			
			var share:Image = new Image(ResManager.assetsManager.getTexture("share.png"));
			this.addChild(share);
			share.x = 543;
			share.y = 612;
			share.addEventListener(TouchEvent.TOUCH, onShare);
			
			new MainMenuController(this);
			
			EventCenter.instance.addEventListener(GameEvent.STAGE_ACTIVATE, onStageActivate);
			EventCenter.instance.addEventListener(GameEvent.STAGE_DEACTIVATE, onStageDeactivate);
			
			butterLayer = new Sprite();
			this.addChild(butterLayer);
			butterLayer.touchable = false;
			initButterfly();
		}
		
		private function initButterfly():void
		{
			var i:int = 0, len:int = 10;
			var butter:Butterfly;
//			for (;i<len;i++)
//			{
//				
//				butter.x = MathUtil.random(0,ResolutionUtil.instance.designWidth);
//				butter.y = MathUtil.random(0,ResolutionUtil.instance.designHeight);
//			}
			butter = createButterfly(1);
			butter.originX = 182;
			butter.originY = 87;
			butter.targetX = 487;
			butter.targetY = 178;
			butter.minScale = 0.2;
			butter.maxScale = 0.5;
			butter.scaleY = 0.5;
			
			butter = createButterfly(4);
			butter.originX = 24;
			butter.originY = 883;
			butter.targetX = 127;
			butter.targetY = 860;
			butter.minScale = 0.2;
			butter.maxScale = 0.6;
			butter.scaleY = 0.6;
			
			butter = createButterfly(5);
			butter.originX = 305;
			butter.originY = 772;
			butter.targetX = 447;
			butter.targetY = 737;
			butter.minScale = 0.2;
			butter.maxScale = 0.5;
			butter.scaleY = 0.5;
			
			butter = createButterfly(7);
			butter.originX = 465;
			butter.originY = 748;
			butter.targetX = 607;
			butter.targetY = 852;
			butter.minScale = 0.2;
			butter.maxScale = 0.8;
			butter.scaleY = 0.8;
			
			butter = createButterfly(1);
			butter.originX = 305;
			butter.originY = 772;
			butter.targetX = 89;
			butter.targetY = 874;
			butter.minScale = 0.2;
			butter.maxScale = 0.5;
			butter.scaleY = 0.5;
			
			butter = createButterfly(3);
			butter.originX = 531;
			butter.originY = 84;
			butter.targetX = 92;
			butter.targetY = 200;
			butter.minScale = 0.2;
			butter.maxScale = 0.7;
			butter.scaleY = 0.7;
			
			butter = createButterfly(2);
			butter.originX = 600;
			butter.originY = 793
			butter.targetX = 306;
			butter.targetY = 652;
			butter.minScale = 0.2;
			butter.maxScale = 0.5;
			butter.scaleY = 0.5;
		}
		
		private function createButterfly(id:int=0):Butterfly
		{
			var bid:int, butter:Butterfly;
			bid = id == 0 ? ButterflyManager.randomButterfly() : id;
			butter = new Butterfly(ResManager.assetsManager.getTexture(ButterflyManager.getButterflyName(bid)));
			butterLayer.addChild(butter);
			butterflys.push(butter);
			return butter;
		}
		
		private function playButterfly():void
		{
			var i:int = 0, len:int = butterflys.length;
			var butter:Butterfly;
			for (;i<len;i++)
			{
				butter = butterflys[i];
				butter.flyTo();
			}
		}
		
		private function stopButterfly():void
		{
			var i:int = 0, len:int = butterflys.length;
			var butter:Butterfly;
			for (;i<len;i++)
			{
				butter = butterflys[i];
				butter.stopFlyTo();
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
		
		private var oldSoundEnable:Boolean = false;
		protected function onStageDeactivate(event:GameEvent):void
		{
			oldSoundEnable = GameInstance.instance.soundEnable;
			if (oldSoundEnable)
			{
				playSound(false);
			}
		}
		
		protected function onStageActivate(event:GameEvent):void
		{
			if (oldSoundEnable)
			{
				playSound(true);
			}
		}
		
		private function onTouchMusic(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				playSound(!GameInstance.instance.soundEnable);
			}
		}
		
		private function playSound(bool:Boolean):void
		{
			SoundUtil.allCanPlay = GameInstance.instance.soundEnable = bool;
			if (GameInstance.instance.soundEnable){
				music.texture = ResManager.assetsManager.getTexture("soundplay2.png");
				SoundUtil.recoverAllSound();
			}else{
				music.texture = ResManager.assetsManager.getTexture("soundoff2.png");
				SoundUtil.stopAllSound();
			}
		}
		
		public function hide():void
		{
			continueTxt.stop();
			beginTxt.stop();
			more.stop();
			stopButterfly();
			var t:Tween = new Tween(this,0.5);
			t.animate("x",-ResolutionUtil.instance.designWidth);
			t.onComplete = function():void
			{
				removeFromParent();
				Starling.juggler.remove(t);
			};
			Starling.juggler.add(t);
		}
		
		public function show():void
		{
			if (continueTxt.visible){
				continueTxt.start();
				beginTxt.y = 470;
				more.y =  570;
			}else{
				beginTxt.start();
				beginTxt.y = 400;
				more.y =  500;
			}
			more.start();
			var t:Tween = new Tween(this,0.5);
			t.animate("x",0);
			t.onComplete = function():void
			{
				Starling.juggler.remove(t);
				playButterfly();
			};
			Starling.juggler.add(t);
		}
	}
}