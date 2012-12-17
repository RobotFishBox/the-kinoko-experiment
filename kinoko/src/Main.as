package
{
	import org.flixel.FlxGame;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Anderson Li
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends FlxGame
	{
		
		public function Main()
		{
			super(500, 300, FlxState);
		}
	
	}

}