package
{
	import org.flixel.FlxGame;
	import states.CanvasState;
	/**
	 * ...
	 * @author Anderson Li
	 */
	[SWF(backgroundColor="#000000",width="900",height="650",frameRate="30")]
	[Frame(factoryClass="Preloader")]
	
	public class Main extends FlxGame
	{
		
		public function Main()
		{
			super(900, 650, CanvasState);
		}
	
	}

}