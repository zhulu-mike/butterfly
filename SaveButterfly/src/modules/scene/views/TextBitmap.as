package modules.scene.views
{
	import managers.ResManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class TextBitmap extends Sprite
	{
		private var prevName:String = "";
		public function TextBitmap(prname:String)
		{
			prevName = prname;
		}
		
		private var _text:int = -1;
		
		public function set text(value:int):void
		{
			if (value < 0)
				value = 0;
			if (_text != value)
			{
				_text = value;
				create();
			}
		}
		
		public function get text():int
		{
			return _text;
		}
		
		private function create():void
		{
			if (this.numChildren > 0)
				this.removeChildren(0,this.numChildren-1);
			var mh:int;
			var str:String = _text.toString();
			var i:int = 0, len:int = str.length;
			var cb:Texture;
			for (;i<len;i++)
			{
				cb = ResManager.assetsManager.getTexture(prevName+"_"+str.substr(i,1)+".png");
				mh = Math.max(mh,cb.height);
			}
			var bmd:Image;
			var cw:int;
			for (i=0;i<len;i++)
			{
				cb = ResManager.assetsManager.getTexture(prevName+"_"+str.substr(i,1)+".png");
				bmd = new Image(cb);
				bmd.x = cw;
				bmd.y = mh-cb.height>>1;
				this.addChild(bmd);
				cw += (cb.width+2);
			}
		}
		
		
	}
}