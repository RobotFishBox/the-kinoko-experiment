package characters 
{
	import engine.Body;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class TestDummy implements ICharacters 
	{
		private var _frameRate:Number;
		private var _body:Body;
		private var _displayObj:Sprite;
		
		public function TestDummy()
		{
			_frameRate = 12;
			_body = new Body();
		}
		
		/* INTERFACE characters.ICharacters */
		
		public function get frameRate():Number
		{
			return _frameRate;
		}
		
		public function get body():Body
		{
			return _body;
		}
		
		public function get displayObj():DisplayObject
		{
			return _displayObj;
		}
		
		public function load():void
		{
			_displayObj = new Sprite();
			_displayObj.graphics.beginFill(0x123456);
			_displayObj.graphics.drawCircle(0, 0, 5);
		}
		
		public function animate():void
		{
			
		}
		
		public function render():void
		{
			//render animation here if needed
			_displayObj.x = _body.pos.x;
			_displayObj.y = _body.pos.y;
		}
		
		public function cleanUp():void
		{
		
		}
		
	}

}