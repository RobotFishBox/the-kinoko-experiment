package
{
	import characters.TestDummy;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Anderson Li
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var foo:TestDummy = new TestDummy();
			foo.load();
			foo.point.x = 125;
			foo.point.y = 125;
			foo.render();
			stage.addChild(foo.displayObj);
		}
	
	}

}