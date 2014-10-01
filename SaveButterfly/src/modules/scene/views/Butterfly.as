package modules.scene.views
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.mike.utils.MathUtil;
	
	import flash.geom.Point;
	
	import modules.display.MyImage;
	
	import starling.animation.IAnimatable;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class Butterfly extends MyImage
	{
		private var _originX:int;
		private var _originY:int;
		public function Butterfly(texture:Texture)
		{
			super(texture);
			this.pivotX = texture.width>>1;
			this.pivotY = texture.height>>1;
		}
		
		public function fly():void
		{
			stop();
			scaleToMin();
		}
		
		public function stop():void
		{
			this.scaleX = maxScale;
			if (tween)
				Starling.juggler.remove(tween);
		}
		
		private var tween:Tween;
		public var minScale:Number = 0.5;
		public var maxScale:Number = 1.0;
		private function scaleToMax():void
		{
			tween = new Tween(this,0.1);
			tween.animate("scaleX",maxScale);
			tween.onComplete = function():void
			{
				Starling.juggler.remove(tween);
				scaleToMin();
			};
			Starling.juggler.add(tween);
		}
		
		private function scaleToMin():void
		{
			tween = new Tween(this,0.1);
			tween.animate("scaleX",minScale);
			tween.onComplete = function():void
			{
				Starling.juggler.remove(tween);
				scaleToMax();
			};
			Starling.juggler.add(tween);
		}
		
		private var _targetX:Number;
		private var _targetY:Number;
		/**
		 * 巡逻
		 */		
		private var patrolTween:Tween;
		/**
		 * 在目的点之间来回飞
		 * @param xx
		 * @param yy
		 * 
		 */		
		public function flyTo():void
		{
			fly();
			flyToTarget();
		}
		
		private var pos:Point = new Point();
		
		private function flyToTarget():void
		{
			patrolCall = null;
			pos.x = this.x;
			pos.y = this.y;
			var r:Number = MathUtil.getRadiansByXY(this.x,this.y,targetX,targetY);
//			patrolTween = new Tween(this,5);
//			patrolTween.animate("x",targetX);
//			patrolTween.animate("y",targetY);
//			patrolTween.animate("rotation",Math.PI/2-r);
//			patrolTween.onComplete = function():void
//			{
//				Starling.juggler.remove(patrolTween);
//				patrolCall = Starling.juggler.delayCall(backToOrigin, MathUtil.random(1,5));
//			};
//			Starling.juggler.add(patrolTween);
			var func:Function = function():void
			{
				patrolCall = TweenLite.delayedCall(MathUtil.random(1,5),backToOrigin);
			};
			var t:Point = getThoughX(this.x,targetX,this.y,targetY);
//			var t2:Point = getThoughX(this.x,targetX,this.y,targetY);
			TweenMax.to(this,5,{x:targetX, y:targetY, ease:Linear.easeNone, orientToBezier:true, bezierThrough:[{x:t.x,y:t.y}], onComplete:func});
		}
		
		
		private var patrolCall:TweenLite;
		
		private function backToOrigin():void
		{
			patrolCall = null;
			pos.x = this.x;
			pos.y = this.y;
			var r:Number = -MathUtil.getRadiansByXY(this.x,this.y,originX,originY);
//			trace(r*180/Math.PI);
//			patrolTween = new Tween(this,5);
//			patrolTween.animate("x",originX);
//			patrolTween.animate("y",originY);
//			patrolTween.animate("rotation",Math.PI/2-r);
//			patrolTween.onComplete = function():void
//			{
//				Starling.juggler.remove(patrolTween);
//				patrolCall = Starling.juggler.delayCall(flyToTarget, MathUtil.random(1,5));
//			};
//			Starling.juggler.add(patrolTween);
			var func:Function = function():void
			{
				patrolCall = TweenLite.delayedCall(MathUtil.random(1,5),flyToTarget);
			};
			var t:Point = getThoughX(this.x,originX,this.y,originY);
//			var t2:Point = getThoughX(this.x,originX,this.y,originY);
			TweenMax.to(this,5,{x:originX, y:originY, ease:Linear.easeNone,orientToBezier:true, bezierThrough:[{x:t.x,y:t.y}], onComplete:func});
		}
		
		private function getThoughX(bx:Number,tx:Number,by:Number,ty:Number):Point
		{
			if (tx >= bx)
			{
				if (ty >= by)
				{
					return new Point(MathUtil.random(bx,tx),MathUtil.random(by-200,by));
				}else{
					return new Point(MathUtil.random(bx,tx),MathUtil.random(by-200,ty));
				}
			}else{
				if (ty >= by)
				{
					return new Point(MathUtil.random(tx,bx),MathUtil.random(by-200,by));
				}else{
					return new Point(MathUtil.random(tx,bx),MathUtil.random(by+50,by+200));
				}
			}
		}
		
		
		public function stopFlyTo():void
		{
			stop();
			if (patrolTween)
				Starling.juggler.remove(patrolTween);
			if (patrolCall)
				patrolCall.kill();
		}

		public function get originX():int
		{
			return _originX;
		}

		public function set originX(value:int):void
		{
			this.x = _originX = value;
		}

		public function get originY():int
		{
			return _originY;
		}

		public function set originY(value:int):void
		{
			this.y = _originY = value;
		}

		public function get targetX():Number
		{
			return _targetX;
		}

		public function set targetX(value:Number):void
		{
			_targetX = value;
		}

		public function get targetY():Number
		{
			return _targetY;
		}

		public function set targetY(value:Number):void
		{
			_targetY = value;
		}


	}
}