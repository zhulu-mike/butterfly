package managers
{
	import com.mike.utils.AdvertiseUtil;
	import com.mike.utils.MathUtil;
	import com.mike.utils.NetUtil;
	
	import configs.FlyDirection;
	import configs.GameInstance;
	
	import events.GameEvent;

	public class GameUtil
	{
		public function GameUtil()
		{
		}
		
		/**
		 * 获取某种模式的最高纪录
		 * @param pattern
		 * @return 
		 * 
		 */		
		public static function getMaxScore():int
		{
			return GameInstance.instance.scoreRecord.maxScores;
		}
		
		/**
		 * 写某种模式的最高纪录
		 * @param pattern
		 * @param score
		 * 
		 */		
		public static function setMaxScore( score:int):void
		{
			GameInstance.instance.scoreRecord.maxScores = score;
			GameInstance.instance.so.setAt("score",score);
		}
		
		
		
		private static var noFullCount:int = 0;
		
		
		
		/**
		 * 根据数组规则随机其中一种
		 * @param src
		 * @return 
		 * 
		 */		
		public static function getRandomData(src:Array):*
		{
			if (src.length == 1)
				return src[0][0];
			var len:int = src.length;
			var max:int = src[len-1][1];
			var rand:int = MathUtil.random(0,max);
			var i:int = 0;
			for (;i<len;i++)
			{
				if (rand <= src[i][1])
					return src[i][0];
			}
			return src[len-1][0];
		}
		
		public static function getRank(score:int):int
		{
			var tar:Array = GameInstance.instance.currentRankData;
			var i:int = 0, len:int = tar.length;
			var c:int = 0, t:int;
			for (;i<len;i++)
			{
				if (score >= tar[i].score)
				{
					c = tar[i].count;
				}
				t = Math.max(tar[i].count,t);
			}
			if (t <= 0)
				return 100;
			return (t-c)/t*100;
		}
		
		public static function getRankCount(score:int):int
		{
			var tar:Array = GameInstance.instance.currentRankData;
			var i:int = 0, len:int = tar.length;
			var c:int = 0;
			for (;i<len;i++)
			{
				if (score >= tar[i].score)
				{
					c = tar[i].count;
				}
			}
			return c;
		}
		
		
		public static function getData():void
		{
			var callback:Function = function(data:*):void
			{
				GameInstance.instance.moreGameOpen = data == 1 ? true : false;
			};
			NetUtil.getData(callback);
		}
		
		public static function showFullSceenAd():void
		{
			GameInstance.instance.leftShowFullAd--;
			if (GameInstance.instance.leftShowFullAd <= 0)
			{
				if (AdvertiseUtil.isInterstitialReady())
				{
					noFullCount = 0;
					AdvertiseUtil.showInterstitial();
					GameInstance.instance.leftShowFullAd = AdvertiseUtil.FULLE_AD;
					EventCenter.instance.dispatchGameEvent(GameEvent.SHOW_FULL_AD);
				}else{
					noFullCount++;
					if (noFullCount > 5)
					{
						AdvertiseUtil.cacheInterstitial();
						noFullCount = 0;
					}
				}
			}
		}
		
	}
}