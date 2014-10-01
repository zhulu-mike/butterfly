package modules.mainui.views
{
	import configs.GameInstance;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class WorkRoomIntroduceStarling extends Sprite
	{
		private var container:Sprite;
		private var bg:Quad;
		
		public function WorkRoomIntroduceStarling(w:int, h:int)
		{
			this.touchGroup = true;
			
			bg = new Quad(w,h,0x1b1b1b);
			this.addChild(bg);
			
			container = new Sprite();
			this.addChild(container);
			
			var ratio:Number = GameInstance.instance.scaleRatio;
			
			var bp:Image = new Image(Texture.fromEmbeddedAsset(GameInstance.instance.LOG_CLASS));
			container.addChild(bp);
			
			var s:int = 32*ratio;
			var desc:TextField = new TextField(350,47,Language.getString("WORKROOM_DESC"),"Verdana",20,0x00ffff);
			desc.y = bp.height + 32*ratio;
			desc.x = bp.width - desc.width >> 1;
			container.addChild(desc);
			
			s = 32 * ratio;
			var author:TextField = new TextField(350,47,Language.getString("ZHIZUOREN"),"Verdana",20,0x89c997);
			author.y = desc.y + desc.height + s;
			author.x = bp.width - author.width >> 1;
			container.addChild(author);
			
			var weibo:TextField = new TextField(350,47,Language.getString("WEIBO"),"Verdana",20,0x89c997);
			weibo.y = author.y + author.height + s;
			container.addChild(weibo);
			weibo.x = bp.width - weibo.width >> 1;
			
			container.x = w - container.width >> 1;
			container.y = h - container.height >> 1;
		}
	}
}