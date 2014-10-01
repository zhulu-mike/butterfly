package modules.mainui.views
{
	import com.mike.utils.ResolutionUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import configs.GameInstance;
	
	public class WorkRoomIntroduce extends flash.display.Sprite
	{
		
		
		private var container:Sprite;
		private var loadTxt:TextField;
		public function WorkRoomIntroduce()
		{
			container = new Sprite();
			this.addChild(container);
			var ratio:Number = 1;
			var cl:Class = GameInstance.instance.LOG_CLASS;
			var bp:Bitmap = new Bitmap(new cl().bitmapData);
			bp.scaleX = bp.scaleY = ratio;
			container.addChild(bp);
			
			loadTxt = new TextField();
			container.addChild(loadTxt);
			loadTxt.filters = [new DropShadowFilter()];
			loadTxt.defaultTextFormat = new TextFormat("Verdana",30*ratio,0xffffff,true,null,null,null,null,"center");
			loadTxt.text = Language.QIDONGZHONG;
			loadTxt.width = loadTxt.textWidth + 20;
			loadTxt.height = loadTxt.textHeight + 5;
			loadTxt.y = bp.height + 10;
			if (bp.width > loadTxt.width)
				loadTxt.x = bp.width - loadTxt.width >> 1;
			else
				bp.x = loadTxt.width - bp.width >> 1;
		}
		
		public function resize(w:int, h:int):void
		{
			this.graphics.beginFill(0x1b1b1b);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			container.x = w - container.width >> 1;
			container.y = h - container.height >> 1;
		}
	}
}