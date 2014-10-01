package com.mike.utils
{
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	
	import configs.GameInstance;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.Stage;

	public class AirUtil
	{
		public function AirUtil()
		{
		}
		
		/**
		 * 截屏
		 * @param scl
		 * @return 
		 * 
		 */		
		public static function takeScreenshot(sclx:Number=1.0,scly:Number=1.0):BitmapData
		{
			var stage:Stage= Starling.current.stage;
			var width:Number = stage.stageWidth;
			var height:Number = stage.stageHeight;
			
			var rs:RenderSupport = new RenderSupport();
			
			rs.clear(stage.color, 1.0);
			rs.scaleMatrix(sclx, scly);
			rs.setOrthographicProjection(0, 0, width, height);
			
			stage.render(rs, 1.0);
			rs.finishQuadBatch();
			
			var outBmp:BitmapData = new BitmapData(width*sclx, height*scly, true);
			Starling.context.drawToBitmapData(outBmp);
			return outBmp;
		}
		
		/**
		 * 截屏并且保存，返回保存的地址
		 * @return 
		 * 
		 */		
		public static function screenShotAndSave(isStarling:Boolean=true):String
		{
			var bmd:BitmapData = takeScreenshot(GameInstance.instance.sceneWidth/ResolutionUtil.instance.designWidth,GameInstance.instance.sceneHeight/ResolutionUtil.instance.designHeight);
			var img:String;
			if (!DeviceUtil.isIos())
			{
				img = File.userDirectory.url  +"/"+GameInstance.APP_NAME+"/"+new Date().getTime()+".jpg";
			}else{
				img = File.applicationStorageDirectory.nativePath +"/" +new Date().getTime()+".jpg";
			}
			trace(File.userDirectory.url);
			trace(img);
			trace(File.applicationStorageDirectory.nativePath);
			var f:File = new File(img);
			img = img.replace("file://","");
			var fs:FileStream = new FileStream();
			fs.open(f,FileMode.WRITE);
			fs.writeBytes(bmd.encode(bmd.rect,new JPEGEncoderOptions(100)));
			fs.close();
			return img;
		}
		
		/*private static function takeScreenshot(scl:Number=1.0):BitmapData
		{
			var width:Number = GameInstance.instance.sceneWidth;
			var height:Number = GameInstance.instance.sceneHeight;
			var bmd:BitmapData = new BitmapData(width,height,true,0);
			var matrix:Matrix = new Matrix();
			matrix.scale(GameInstance.instance.app.scaleX, GameInstance.instance.app.scaleY);
			bmd.draw(GameInstance.instance.app,matrix);
			return bmd;
			
		}*/
		
		/**
		 * 根据字体大小判断文本框需要的高度
		 * @param size
		 * @return 
		 * 
		 */		
		public static function getHeightByFontSize(size:Number):Number
		{
			return Math.max(Math.ceil(size) + 8,size*1.5);
		}
	}
}