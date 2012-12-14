package characters 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import math.KPoint;
	/**
	 * ...
	 * @author Kinoko
	 */
	public class TestDummy implements ICharacters 
	{
		private var _frameRate:Number;
		private var _point:KPoint;
		private var _body:Sprite;
		
		public function TestDummy()
		{
			_frameRate = 12;
			_point = new KPoint();
		}
		
		/* INTERFACE characters.ICharacters */
		
		public function get frameRate():Number
		{
			return _frameRate;
		}
		
		public function get point():KPoint
		{
			return _point;
		}
		
		public function get body():DisplayObject
		{
			return _body;
		}
		
		public function load():void
		{
			_body = new Sprite();
			_body.graphics.beginFill(0x123456);
			_body.graphics.drawCircle(0, 0, 25);
		}
		
		public function animate():void
		{
		
		}
		
		public function render():void
		{
			//render animation here if needed
			_body.x = _point.x;
			_body.y = _point.y;
		}
		
		public function cleanUp():void
		{
		
		}
		
	}

}