package modules.scene.views
{
	import com.mike.utils.ResolutionUtil;
	
	import events.GameEvent;
	
	import managers.ResManager;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class HelpPanel extends Sprite
	{
		public function HelpPanel()
		{
			var bg:Quad = new Quad(ResolutionUtil.instance.designWidth,ResolutionUtil.instance.designHeight,0x1b1b1b);
			this.addChild(bg);
			
			var pause:Image = new Image(ResManager.assetsManager.getTexture("continue.png"));
			pause.x = bg.width - pause.width >> 1;
			pause.y = 500;
			this.addChild(pause);
			pause.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			if (t.phase == TouchPhase.ENDED)
			{
				EventCenter.instance.dispatchGameEvent(GameEvent.STAGE_ACTIVATE);
				EventCenter.instance.dispatchGameEvent(GameEvent.SHOW_HELP_PANEL,false);
			}
		}
	}
}