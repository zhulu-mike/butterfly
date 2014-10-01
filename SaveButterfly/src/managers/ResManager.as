package managers
{
	import com.mike.utils.LanUtil;
	
	import flash.display.BitmapData;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import starling.utils.AssetManager;

	public class ResManager
	{
		public function ResManager()
		{
		}
		
		public static const BASE:String = "assets/";
		
		public static const YLXD:String = BASE + "butterfly.png";
		
		public static const YLXDXML:String = BASE + "butterfly.xml";
		
		public static const YLXD2:String = BASE + "butterfly2.png";
		public static const YLXDXML2:String = BASE + "butterfly2.xml";
		
		public static const CANDYCONFIG:String = BASE + "butterflyconfig.xml";
		
		public static const YLXD3:String = BASE + "butterfly3.png";
		public static const YLXDXML3:String = BASE + "butterfly3.xml";
		public static const YLXD4:String = BASE + "butterfly4.png";
		public static const YLXDXML4:String = BASE + "butterfly4.xml";
		
		public static var assetsManager:AssetManager;
		
		public static var resLoader:BulkLoader;
		
		public static var YLXD_NAME:String = "butterfly";
		public static var YLXD_NAME2:String = "butterfly2";
		public static var YLXD_NAME3:String = "butterfly3";
		public static var YLXD_NAME4:String = "butterfly4";
		
		public static const PASS_SOUND:String = BASE + "pass.mp3";
		
		public static const BEYOND_MAX:String = BASE + "win.mp3";
		public static const GAME_OVER:String = BASE + "gameover.mp3";
		public static var backGroundBmd:BitmapData;
		
		public static const BUFF_BASE:String = "buff_";
		
		public static const MOREGAME:String = "moregame";
		public static const MOREGAMEPNG:String = BASE + "gamesres.png";
		public static const MOREGAMEXML:String = BASE + "gamesres.xml";
		
		public static function getResKey(key:String):String
		{
			return key;
			return LanUtil.isChinese ? key : key+"_en";
		}
	}
}