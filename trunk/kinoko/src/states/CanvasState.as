package states
{
	import actors.Ninja;
	import engine.widgets.KDamper;
	import engine.widgets.KSpring;
	import graphics.KSprite;
	import engine.KWorld;
	import input.Controller;
	import input.Cursor;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
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
		private var _floor:FlxTileblock = new FlxTileblock(-50, 650, 1000, 32);
		private var _world:KWorld = new KWorld();
		private var _ninja:Ninja = new Ninja();
		private var _mouse:Cursor = new Cursor();
		private var _controller:Controller = new Controller();
		
		override public function create():void
		{
			_floor.makeGraphic(1000, 32, 0xff689c16);
			FlxG.camera.drawDebug(FlxG.camera);
			add(_floor);
			
			_world.pixelScale.make(45, 45);
			_world.gravity.make(0, 10);
			
			_controller.attach(_mouse, _ninja);
			_controller.addToWorld(_world);
			
			add(_controller);
			add(_ninja);
			
			FlxG.camera.follow(_ninja, FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.setBounds(0, -2000, 900, 5000);
		}
		
		override public function update():void
		{	
			_controller.grounded = FlxG.collide(_floor, _ninja);
			_world.update();
			super.update();
		}
	
	}

}