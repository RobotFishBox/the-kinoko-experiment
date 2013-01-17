package actors 
{
	import graphics.KSprite;
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class Template extends KSprite 
	{
		[Embed(source = "../../data/temp/ninja.png")]protected var NinjaKun:Class;
		
		public function Template() 
		{
			loadGraphic(NinjaKun, true, true, 30, 28);
			addAnimation("walking", [0, 1, 2, 3], 12, true);
			play("walking");
		}
		
	}

}