package configs
{
	/**
	 * 游戏状态定义
	 * @author Administrator
	 * 
	 */	
	public class GameState
	{
		public function GameState()
		{
		}
		/**
		 * 开始
		 */		
		public static const BEGIN:int = 1;
		
		/**
		 * 关卡选择界面
		 */		
		public static const CHOOSE_CHAPTER:int = 6;
		
		/**
		 * 游戏进行中
		 */		
		public static const RUNNING:int = 2;
		
		/**
		 * 游戏结束
		 */		
		public static const OVER:int = 3;
		
		/**
		 * 进行暂停
		 */		
		public static const PAUSE:int = 4;
		
		/**
		 * 暂停后继续
		 */		
		public static const CONTINUE:int = 5;
	}
}