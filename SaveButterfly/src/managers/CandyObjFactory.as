package managers
{
	import com.mike.utils.BaseFactory;
	
	import modules.scene.views.CandyObject;
	
	import starling.core.Starling;
	
	public class CandyObjFactory extends BaseFactory
	{
		public function CandyObjFactory()
		{
			if (!instance)
			{
				var i:int = 0;
				for (i;i<10;i++)
				{
					freePools.push(new CandyObject());
				}
			}
		}
		
		private static var instance:CandyObjFactory;
		
		public static function getInstance():CandyObjFactory
		{
			if (!instance)
				instance = new CandyObjFactory();
			return instance;
		}
		
		public  function getShape():CandyObject
		{
			var voo:CandyObject;
			if (freePools.length <= 0)
			{
				voo = new CandyObject();
			}
			else
			{
				voo = freePools.shift();
			}
			usePools.push(voo);
			return voo;
		}
		
		/**
		 * 回收
		 */
		public function recycleShape(voo:CandyObject):void
		{
			var index:int = usePools.indexOf(voo);
			if (index >= 0)
			{
				usePools.splice(index, 1);
				freePools.push(voo);
				voo.x = voo.y = -999;
			}
			voo.update = false;
			voo.col = 0;
			voo.row = 0;
			voo.isMoving = false;
			voo.targety = -999;
			Starling.juggler.removeTweens(voo);
		}
	}
}