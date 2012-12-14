package characters 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import math.KPoint;
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class TestDummy implements ICharacters 
	{
		private var _frameRate:Number;
		private var _point:KPoint;
		private var _displayObj:Sprite;
		
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
		
		public function get displayObj():DisplayObject
		{
			return _displayObj;
		}
		
		public function load():void
		{
			_displayObj = new Sprite();
			_displayObj.graphics.beginFill(0x123456);
			_displayObj.graphics.drawCircle(0, 0, 25);
		}
		
		public function animate():void
		{
		
		}
		
		public function render():void
		{
			//render animation here if needed
			_displayObj.x = _point.x;
			_displayObj.y = _point.y;
		}
		
		public function cleanUp():void
		{
		
		}
		
	}

}