package managers
{
	import com.mike.utils.MathUtil;
	
	import flash.utils.Dictionary;
	
	import infos.LevelInfo;

	public class ButterflyManager
	{
		public function ButterflyManager()
		{
		}
		
		private static var dic:Dictionary = new Dictionary();
		private static var butterflys:Array = [];
		private static var butterflyDic:Dictionary = new Dictionary();
		public static function parse(data:XML):void
		{
			var xmls:XMLList = data.butter;
			var xml:XML;
			for each (xml in xmls)
			{
				butterflys.push(int(xml.@id));
				butterflyDic[int(xml.@id)] = String(xml.@name);
			}
			
			
			/*for each (xml in xmls)
			{
				info = new LevelInfo();
				info.lev = xml.@lev;
				info.name = String(xml.@name);
				info.num = xml.@num;
				info.diff = xml.@diff;
				info.type = xml.@type;
				dic[info.lev] = info;
			}*/
		}
		
		public static function randomButterfly():int
		{
			var random:int = MathUtil.random(0,butterflys.length*50-1);
			random = random / 50;
			return butterflys[random];
		}
		
		public static function getButterflyName(id:int):String
		{
			return butterflyDic[id];
		}
		
		
		public static function getLevelInfo(lev:int):LevelInfo
		{
			return dic[lev];
		}
		
		public static function getLevelName(lev:int):String
		{
			return dic[lev].name;
		}
		
		public static function getTypeName(type:int):String
		{
			if (type == 1)
				return "guo";
			if (type == 2)
				return "qing";
			if (type == 3)
				return "kuai";
			return "le";
		}
	}
}