package graphics
{
	import engine.IKObject;
	import engine.KBody;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class KSprite extends FlxSprite implements IKObject
	{
		/**
		 * KBody handles all the physics
		 */
		protected var _body:KBody;
		
		public function KSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);
			_body = new KBody();
		}
		
		override public function update():void
		{
			_body.update(FlxG.elapsed);
			x = _body.x * _body.pixelScale.x;
			y = _body.y * _body.pixelScale.y;
			velocity.x = _body.velocity.x * _body.pixelScale.x;
			velocity.y = _body.velocity.y * _body.pixelScale.y;
			maxVelocity.x = _body.maxVelocity.x * _body.pixelScale.x;
			maxVelocity.y = _body.maxVelocity.y * _body.pixelScale.y;
			
			super.update();
		}
		
		/* INTERFACE engine.IKObject */
		
		/**
		 * Syncs KBody with a sprite that gets displayed
		 */
		public function sync():void
		{
			_body.x = x / _body.pixelScale.x;
			_body.y = y / _body.pixelScale.y;
			_body.velocity.x = velocity.x / _body.pixelScale.x;
			_body.velocity.y = velocity.y / _body.pixelScale.y;
		}
		
		public function get body():KBody
		{
			return _body;
		}
	
	}

}