package modules.scene.views
{
	import com.mike.infos.MoreGameInfo;
	import com.mike.utils.ShareManager;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import configs.GameInstance;
	
	import managers.ResManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameItem extends Sprite
	{
		private var log:Image;
		private var desc:Image;
		private var download:Image;
		private var count:TextBitmap;
		public static const ITEM_HEIGHT:int = 100;
		
		
		public function GameItem(info:MoreGameInfo)
		{
			data = info;
			log = new Image(ResManager.assetsManager.getTexture(info.icon));
			this.addChild(log);
			log.y = ITEM_HEIGHT - log.height >> 1;
			log.touchable = false;
			
			desc = new Image(ResManager.assetsManager.getTexture(ResManager.getResKey(info.desc)+".png"));
			this.addChild(desc);
			desc.x = log.x + log.width + 10;
			desc.y = ITEM_HEIGHT - desc.height >> 1;
			desc.touchable = false;
			
			if (info.id != "sharegame")
			{
				if (GameInstance.instance.so.getAt(info.id) as Boolean){
					download = new Image(ResManager.assetsManager.getTexture(ResManager.getResKey("taskcomplete")+".png"));
				}else{
					download = new Image(ResManager.assetsManager.getTexture(ResManager.getResKey("download")+".png"));
					download.addEventListener(TouchEvent.TOUCH, onDown);
				}
				this.addChild(download);
				download.x = desc.x + desc.width + 10;
				download.y = ITEM_HEIGHT - download.height >> 1;
			}else{
//				count = new TextBitmap("huakang30");
//				this.addChild(count);
//				count.x = desc.x + desc.width + 10;
//				count.text = ShareManager.instance.shareCount;
//				
//				download = new Image(ResManager.assetsManager.getTexture("xiegang.png"));
//				this.addChild(download);
//				download.x = count.x + count.width+5;
//				download.y = ITEM_HEIGHT - download.height >> 1;
//				count.y = download.y;
//				this.addEventListener(Event.ADDED_TO_STAGE, onUpdate);
			}
		}
		
		private function onUpdate(e:Event):void
		{
			// TODO Auto Generated method stub
			count.text = ShareManager.instance.shareCount;
		}
		
		private function onDown(e:TouchEvent):void
		{
			var touchs:Vector.<Touch> = e.touches;
			var touch:Touch = touchs[0];
			if (touch.phase == TouchPhase.ENDED)
			{
				navigateToURL(new URLRequest(data.url));
				download.removeEventListener(TouchEvent.TOUCH, onDown);
				download.texture = ResManager.assetsManager.getTexture(ResManager.getResKey("taskcomplete")+".png");
				download.scaleX = download.scaleY = 1;
				GameInstance.instance.so.setAt(data.id,true);
				GameInstance.instance.gold += data.score;
			}
		}
		
		private var _data:MoreGameInfo;
		
		
		public function get data():MoreGameInfo
		{
			return _data;
		}

		public function set data(value:MoreGameInfo):void
		{
			_data = value;
		}

	}
}