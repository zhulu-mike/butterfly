package modules.display
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.textures.Texture;
	
	public class ScaleEffectImage extends MyImage
	{
		private var minScale:Number = 0;
		
		public function ScaleEffectImage(texture:Texture, minscale:Number=0.9)
		{
			super(texture);
			this.pivotX = texture.width>>1;
			this.pivotY = texture.height>>1;
			minScale = minscale;
		}
		
		public function start():void
		{
			scaleToMin();
		}
		
		public function stop():void
		{
			this.scaleX = 1;
			this.scaleY = 1;
			if (tween)
				Starling.juggler.remove(tween);
		}
		
		private var tween:Tween;
		private function scaleToMax():void
		{
			tween = new Tween(this,1);
			tween.animate("scaleX",1);
			tween.animate("scaleY",1);
			tween.onComplete = function():void
			{
				Starling.juggler.remove(tween);
				scaleToMin();
			};
			Starling.juggler.add(tween);
		}
		
		private function scaleToMin():void
		{
			tween = new Tween(this,1);
			tween.animate("scaleX",minScale);
			tween.animate("scaleY",minScale);
			tween.onComplete = function():void
			{
				Starling.juggler.remove(tween);
				scaleToMax();
			};
			Starling.juggler.add(tween);
		}
		
		
	}
}