package states
{
	import graphics.KSprite;
	import engine.KWorld;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
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
		private var _floor:FlxTileblock = new FlxTileblock(0, 208, 320, 32);
		private var _world:KWorld = new KWorld();
		private var _manGroup:FlxGroup = new FlxGroup();
		
		override public function create():void
		{
			FlxG.mouse.show();
			_floor.makeGraphic(320, 32, 0xff689c16);
			FlxG.camera.drawDebug(FlxG.camera);
			add(_floor);
			add(_manGroup);
			
			_world.pixelScale.make(30, 30);
			_world.gravity.make(1, 10);
			
			var kSprite:KSprite;
			for (var i:int = 0; i < 500; i++) {
				kSprite = new KSprite(Math.random()*300, Math.random()*50);
				kSprite.elasticity = 0.5
				_manGroup.add(kSprite);
				_world.addKObject(kSprite);
			}
			FlxG.camera.follow(kSprite, FlxCamera.STYLE_PLATFORMER);
		}
		
		override public function update():void
		{
			_world.update();
			super.update();
			FlxG.collide(_floor, _manGroup);
		}
	
	}

}