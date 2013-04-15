package actors
{
	import assets.AssetMap;
	import graphics.KSprite;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class Template extends KSprite
	{
		
		public function Template()
		{
			loadGraphic(AssetMap.TEMPLATE, true, true, 80, 80);
			addAnimation("idle", [1, 2], 3, true);
			addAnimation("walk", [4, 5, 6, 7, 6, 5], 12, true);
			addAnimation("run", [20, 21, 22, 21], 12, true);
			addAnimation("jump", [60, 61, 62], 24, false);
			offset.x = this.width / 2;
			idle();
		}
		
		public function idle():void
		{
			play("idle");
		}
		
		public function walk():void
		{
			play("walk");
		}
		
		public function run():void
		{
			play("run");
		}
		
		public function jump():void
		{
			play("jump");
		}
	
	}

}