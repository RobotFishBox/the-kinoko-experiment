package states
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	
	/**
	 * a blank canvas state that can be used for testing
	 * code and other good stuff
	 *
	 * @author Anderson Li
	 */
	public class CanvasState extends FlxState
	{
		private var _player:FlxSprite = new FlxSprite(120, 120);
		
		override public function create():void
		{
			FlxG.mouse.show();
			var floor:FlxTileblock = new FlxTileblock(0, 208, 320, 32);
			floor.makeGraphic(320, 32, 0xff689c16);
			FlxG.camera.drawDebug(FlxG.camera);
			FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);
			add(_player);
			add(floor);
		}
		
		override public function update():void
		{
			_player.x++;
			super.update();
		}
	
	}

}