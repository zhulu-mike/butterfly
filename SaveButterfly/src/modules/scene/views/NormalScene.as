package modules.scene.views
{
	import com.mike.utils.MathUtil;
	import com.mike.utils.ResolutionUtil;
	import com.mike.utils.SoundUtil;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import configs.FengCheColor;
	import configs.GameConfig;
	import configs.GameInstance;
	import configs.GameState;
	import configs.StarDiffType;
	
	import events.GameEvent;
	
	import infos.LevelInfo;
	
	import managers.GameUtil;
	import managers.ResManager;
	import managers.SoundManager;
	import managers.ButterflyManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class NormalScene extends Sprite implements ISceneBase
	{
		private var starLayer:Sprite;
		private var starContainer:Sprite;
		private var levelTxt:TextField;
		private var bgBatch:QuadBatch;
		
		private var isBegin:Boolean = false;
		private var isEnd:Boolean = false;
		private var _score:int = 0;
		private var starList:Array = [];
		private var beginTime:int = 0;
		private var guo:Sprite;
		private var guoTxt:Image;
		private var qing:Sprite;
		private var qingTxt:Image;
		private var kuai:Sprite;
		private var kuaiTxt:Image;
		private var le:Sprite;
		private var leTxt:Image;
		private var pauseBtn:Image;
		
		public function NormalScene()
		{
			var bg:Quad = new Quad(ResolutionUtil.instance.designWidth,ResolutionUtil.instance.designHeight,0x008262);
			this.addChild(bg);
			
			timetxt = new TextField(300,60,"","yahei",40,0xffffff);
			this.addChild(timetxt);
//			timetxt.text = 32;
			timetxt.x = ResolutionUtil.instance.designWidth-timetxt.width>>1;
			timetxt.y = 20;
			
			
			levelTxt = new TextField(300,50,"","yahei",30,0x00ffff);
			this.addChild(levelTxt);
			levelTxt.x = ResolutionUtil.instance.designWidth-levelTxt.width>>1;
			levelTxt.y = 86;
			
			guo = new Sprite();
			this.addChild(guo);
			guo.x = 105;
			guo.y = 160;
			var guobg:Image = new Image(ResManager.assetsManager.getTexture("bg.png"));
			guo.addChild(guobg);
			
			guoTxt = new Image(ResManager.assetsManager.getTexture("guo.png"));
			guo.addChild(guoTxt);
			guoTxt.scaleX = guoTxt.scaleY = 60/133;
			guoTxt.x = guobg.width - guoTxt.width >> 1;
			guoTxt.y = guobg.height - guoTxt.height >> 1;
			
			qing = new Sprite();
			this.addChild(qing);
			qing.x = 175;
			qing.y = 160;
			var qingbg:Image = new Image(ResManager.assetsManager.getTexture("bg.png"));
			qing.addChild(qingbg);
			
			qingTxt = new Image(ResManager.assetsManager.getTexture("qing.png"));
			qing.addChild(qingTxt);
			qingTxt.scaleX = qingTxt.scaleY = 60/133;
			qingTxt.x = qingbg.width - qingTxt.width >> 1;
			qingTxt.y = qingbg.height - qingTxt.height >> 1;
			
			kuai = new Sprite();
			this.addChild(kuai);
			kuai.x = 245;
			kuai.y = 160;
			var kuaibg:Image = new Image(ResManager.assetsManager.getTexture("bg.png"));
			kuai.addChild(kuaibg);
			
			kuaiTxt = new Image(ResManager.assetsManager.getTexture("kuai.png"));
			kuai.addChild(kuaiTxt);
			kuaiTxt.scaleX = kuaiTxt.scaleY = 60/133;
			kuaiTxt.x = kuaibg.width - kuaiTxt.width >> 1;
			kuaiTxt.y = kuaibg.height - kuaiTxt.height >> 1;
			
			le = new Sprite();
			this.addChild(le);
			le.x = 315;
			le.y = 160;
			var lebg:Image = new Image(ResManager.assetsManager.getTexture("bg.png"));
			le.addChild(lebg);
			
			leTxt = new Image(ResManager.assetsManager.getTexture("le.png"));
			le.addChild(leTxt);
			leTxt.scaleX = leTxt.scaleY = 60/133;
			leTxt.x = lebg.width - leTxt.width >> 1;
			leTxt.y = lebg.height - leTxt.height >> 1;
			
			starLayer = new Sprite();
			this.addChild(starLayer);
			starLayer.y = 300;
			starLayer.x = 40;
			
			bgBatch = new QuadBatch();
			starLayer.addChild(bgBatch);
				
			starContainer = new Sprite();
			starLayer.addChild(starContainer);
			
			pauseBtn = new Image(ResManager.assetsManager.getTexture("return.png"));
			this.addChild(pauseBtn);
			pauseBtn.x = 360;
			pauseBtn.y = 32;
			pauseBtn.addEventListener(TouchEvent.TOUCH, onReturn);
			
			starLayer.addEventListener(TouchEvent.TOUCH, onClick);
			EventCenter.instance.addEventListener(GameEvent.SHOW_FULL_AD, showPausePanel);
		}
		
		private function onReturn(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			if (t.phase == TouchPhase.ENDED)
			{
				gameOver();
			}
		}
		
		protected function showPausePanel(event:GameEvent):void
		{
			EventCenter.instance.dispatchGameEvent(GameEvent.STAGE_DEACTIVATE);
			EventCenter.instance.dispatchGameEvent(GameEvent.SHOW_HELP_PANEL,true);
		}
		
		private var ccount:int = 0;
		private function onClick(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			if (t.phase == TouchPhase.ENDED)
			{
				if (this.isEnd || GameInstance.isPause())
					return;
				var p:Point = new Point(t.globalX,t.globalY);
				p = starContainer.globalToLocal(p);
				var tilex:int = p.x/info.size;
				var tiley:int = p.y/info.size;
				var index:int = getIndex(tiley,tilex);
				if (index >=0 && index < starList.length)
				{
					var star:Star = starList[index];
					if (star.valid)
					{
						if (!star.isSame)
						{
							star.valid = false;
							star.removeFromParent();
							if (star.type == 1)
								guoTxt.visible = true;
							else if (star.type == 2)
								qingTxt.visible = true;
							else if (star.type == 3)
								kuaiTxt.visible = true;
							else
								leTxt.visible = true;
							ccount++;
							if (info.lev < 40)
							{
								GameInstance.instance.currentLev++;
								Starling.juggler.delayCall(goon,0.2);
								trace(GameInstance.instance.currentLev);
							}else if (ccount >= 4){
								GameInstance.instance.currentLev++;
								Starling.juggler.delayCall(gameOver,0.2);
							}
						}else{
							beginTime -= 1000;
							showTimeReduce(t.globalX,t.globalY);
						}
					}
				}
			}
		}
		
		private function showTimeReduce(xx:Number, yy:Number):void
		{
			var img:Image = new Image(ResManager.assetsManager.getTexture(ResManager.getResKey("jianyimiao")+".png"));
			img.x = xx - img.width*0.5;
			img.y = yy - img.height*0.5;
			this.addChild(img);
			var t:Tween = new Tween(img,0.5,Transitions.EASE_OUT);
			t.animate("y",img.y-50);
			t.onComplete = function():void
			{
				Starling.juggler.remove(t);
				img.removeFromParent(true);
			};
			Starling.juggler.add(t);
		}
		
		private var info:LevelInfo;
		
		public function start():void
		{
			isBegin = true;
			isEnd = false;
			beginTime = getTimer();
			goon();
		}
		
		private function goon():void
		{
			GameUtil.showFullSceenAd();
			ccount = 0;
			destroy();
			starList.length = 0;
			info = ButterflyManager.getLevelInfo(GameInstance.instance.currentLev);
			info.size = 400/info.num;
			levelTxt.text = info.name+"lv"+info.lev;
			draw();
			createStars();
			if (info.type == 0){
				guoTxt.visible = false;
				qingTxt.visible = false;
				kuaiTxt.visible = false;
				leTxt.visible = false;
			}else if(info.type == 1){
				guoTxt.visible = false;
				qingTxt.visible = true;
				kuaiTxt.visible = true;
				leTxt.visible = true;
			}else if(info.type == 2){
				guoTxt.visible = true;
				qingTxt.visible = false;
				kuaiTxt.visible = true;
				leTxt.visible = true;
			}else if(info.type == 3){
				guoTxt.visible = true;
				qingTxt.visible = true;
				kuaiTxt.visible = false;
				leTxt.visible = true;
			}else if(info.type == 4){
				guoTxt.visible = true;
				qingTxt.visible = true;
				kuaiTxt.visible = true;
				leTxt.visible = false;
			}
		}
		
		private function draw():void
		{
			bgBatch.reset();
			var item:Image = new Image(ResManager.assetsManager.getTexture("bg.png"));
			item.width = info.size;
			item.height = info.size;
			var i:int, j:int;
			for (;i<info.num;i++)
			{
				for (j=0;j<info.num;j++)
				{
					item.x = i*info.size;
					item.y = j*info.size;
					bgBatch.addImage(item);
				}
			}
		}
		
		public function update():void
		{
			if (isEnd)
			{
				return;
			}
			if (GameInstance.isPause())
			{
				return;
			}
			if (isBegin)
			{
				setLeftTime(200-(getTimer()-beginTime)*0.001);
			}
		}
		
		private var timeLeftPlay:Boolean = false;
		private function setLeftTime(time:int):void
		{
			timetxt.text = time.toString();
			if (time <= 5 && !timeLeftPlay)
			{
				timeLeftPlay = true;
			}
			if (time <= 0)
			{
				gameOver();
				return;
			}
		}
		
		private function updateStar():void
		{
		}
		
		
		private function createStars():void
		{
			var w:int = info.num;
			var h:int = w;
			var i:int, j:int;
			var diffpos:Array = [];
			var max:int = info.num*info.num-1;
			var rand:int, index:int;
			var starItem:Star;
			if (info.lev < 40)
			{
				rand = MathUtil.random(0,max);
				diffpos.push(rand);
				starItem = new Star(ResManager.assetsManager.getTexture(ButterflyManager.getTypeName(info.type)+".png"));
				starContainer.addChild(starItem);
				starItem.scaleX = starItem.scaleY = info.size/133;
				starItem.x = (rand%w)*info.size+(info.size-starItem.width>>1);
				starItem.y = int(rand/w)*info.size+(info.size-starItem.height>>1);
				starItem.isSame = false;
				starItem.type = info.type;
				starList[rand] = starItem;
			}else{
				rand = MathUtil.random(0,max);
				while (true)
				{
					if (diffpos.indexOf(rand) < 0)
					{
						diffpos.push(rand);
						starItem = new Star(ResManager.assetsManager.getTexture(ButterflyManager.getTypeName(1)+".png"));
						starContainer.addChild(starItem);
						starItem.scaleX = starItem.scaleY = info.size/133;
						starItem.x = (rand%w)*info.size+(info.size-starItem.width>>1);
						starItem.y = int(rand/w)*info.size+(info.size-starItem.height>>1);
						starItem.isSame = false;
						starItem.type = 1;
						starList[rand] = starItem;
						break;
					}else{
						rand = MathUtil.random(0,max);
					}
				}
				rand = MathUtil.random(0,max);
				while (true)
				{
					if (diffpos.indexOf(rand) < 0)
					{
						diffpos.push(rand);
						starItem = new Star(ResManager.assetsManager.getTexture(ButterflyManager.getTypeName(2)+".png"));
						starContainer.addChild(starItem);
						starItem.scaleX = starItem.scaleY = info.size/133;
						starItem.x = (rand%w)*info.size+(info.size-starItem.width>>1);
						starItem.y = int(rand/w)*info.size+(info.size-starItem.height>>1);
						starItem.isSame = false;
						starItem.type = 2;
						starList[rand] = starItem;
						break;
					}else{
						rand = MathUtil.random(0,max);
					}
				}
				rand = MathUtil.random(0,max);
				while (true)
				{
					if (diffpos.indexOf(rand) < 0)
					{
						diffpos.push(rand);
						starItem = new Star(ResManager.assetsManager.getTexture(ButterflyManager.getTypeName(3)+".png"));
						starContainer.addChild(starItem);
						starItem.scaleX = starItem.scaleY = info.size/133;
						starItem.x = (rand%w)*info.size+(info.size-starItem.width>>1);
						starItem.y = int(rand/w)*info.size+(info.size-starItem.height>>1);
						starItem.isSame = false;
						starItem.type = 3;
						starList[rand] = starItem;
						break;
					}else{
						rand = MathUtil.random(0,max);
					}
				}
				rand = MathUtil.random(0,max);
				while (true)
				{
					if (diffpos.indexOf(rand) < 0)
					{
						diffpos.push(rand);
						starItem = new Star(ResManager.assetsManager.getTexture(ButterflyManager.getTypeName(4)+".png"));
						starContainer.addChild(starItem);
						starItem.scaleX = starItem.scaleY = info.size/133;
						starItem.x = (rand%w)*info.size+(info.size-starItem.width>>1);
						starItem.y = int(rand/w)*info.size+(info.size-starItem.height>>1);
						starItem.isSame = false;
						starItem.type = 4;
						starList[rand] = starItem;
						break;
					}else{
						rand = MathUtil.random(0,max);
					}
				}
			}
			
			var types:Array = ["guo_6","qing_6","kuai_6","le_6"];
			var tr:int;
			for(j=0;j<h;j++)
			{
				for (i=0;i<w;i++)
				{
					index = getIndex(j,i);
					if (diffpos.indexOf(index) < 0)
					{
						if (info.lev < 40){
							starItem = new Star(ResManager.assetsManager.getTexture(info.diff+".png"));
						}else{
							tr = MathUtil.random(0,199);
							tr /= 50;
							starItem = new Star(ResManager.assetsManager.getTexture(types[tr]+".png"));
						}
						starContainer.addChild(starItem);
						starItem.scaleX = starItem.scaleY = info.size/133;
						starItem.x = i*info.size+(info.size-starItem.width>>1);
						starItem.y = j*info.size+(info.size-starItem.height>>1);
						starList[index] = starItem;
					}
				}
			}
		}
		
		private function getIndex(r:int,c:int):int
		{
			return r*info.num+c;
		}
		

		private var timetxt:TextField;
		
		private function gameOver():void
		{
			isEnd = true;
			if (timeLeftPlay)
			{
				timeLeftPlay = false;
				SoundUtil.stopSound(ResManager.BASE+"daojishi.mp3");
			}
			EventCenter.instance.dispatchGameEvent(GameEvent.GAME_STATE_CHANGE,{state:GameState.OVER, level:Math.max(1,GameInstance.instance.currentLev-1)});
		}
		
		public function destroy():void
		{
			var star:Star;
			for each (star in starList)
			{
				star.removeFromParent();
			}
			
		}
		
		private var pauseBeginTime:int = 0;
		
		public function pauseGame():void
		{
			pauseBeginTime = getTimer();
			if (timeLeftPlay)
			{
				timeLeftPlay = false;
				SoundUtil.stopSound(ResManager.BASE+"daojishi.mp3");
			}
		}
		
		public function restart():void
		{
			var t:int = getTimer() - pauseBeginTime;
			beginTime += t;
		}

	}
}