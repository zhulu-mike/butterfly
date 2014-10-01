package modules.scene.views
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Star extends Image
	{
		public function Star(texture:Texture)
		{
			super(texture);
		}
		
		public var type:int = 0;
		
		public var isSame:Boolean = true;
		
		public var valid:Boolean = true;
	}
}