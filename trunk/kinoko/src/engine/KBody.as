package engine
{
	import math.KPoint;
	
	/**
	 * a physical body for the widgets.
	 * @author Anderson Li
	 */
	public class KBody
	{
		
		/**
		 * used to relate pixels to meters
		 */
		public var pixelScale:KPoint;
		/**
		 * X position of the upper left corner of this object in world space.
		 * units in meters (m).
		 */
		public var x:Number;
		/**
		 * Y position of the upper left corner of this object in world space.
		 * units in meters (m).
		 */
		public var y:Number;
		/**
		 * The real mass value that is used with widgets, as opposed to
		 * <code>mass</code> that is used for collisions. Should not be
		 * zero. units in kilograms (kg).
		 */
		public var mass:Number;
		/**
		 * velocity applied to this body.
		 * units in meters per second (m/s).
		 */
		public var velocity:KPoint;
		/**
		 * max velocity that can be applied to this body.
		 * units in meters per second (m/s).
		 */
		public var maxVelocity:KPoint;
		/**
		 * accleration applied to this body.
		 * units in meters per second squared (m/s^2).
		 */
		public var acceleration:KPoint;
		/**
		 * force applied to this body.
		 * units in newtons (m/s^2).
		 */
		public var force:KPoint;
		/**
		 * a fixed body will not update motion.
		 */
		public var fixed:Boolean;
		
		/**
		 * is the character touching the ground?
		 */
		public var grounded:Boolean;
		
		public function KBody(X:Number = 0, Y:Number = 0, PixelScale:KPoint = null)
		{
			x = X;
			y = Y;
			mass = 1;
			fixed = grounded = false;
			pixelScale = PixelScale;
			velocity = new KPoint();
			maxVelocity = new KPoint(10000, 10000);
			acceleration = new KPoint();
			force = new KPoint();
		}
		
		/**
		 * updates the motion of the body starting with force
		 * and down to the x and y positions. The change in time
		 * is measured in seconds (s).
		 *
		 * @param	dTime		The elapsed time since last update.
		 */
		public function update(dTime:Number):void
		{
			if (fixed)
			{
				force.make();
				return;
			}
			else
			{
				//compute
				acceleration.x = force.x / mass;
				acceleration.y = force.y / mass;
				
				velocity.x += acceleration.x * dTime;
				velocity.y += acceleration.y * dTime;
				if (velocity.x > maxVelocity.x)
					velocity.x = maxVelocity.x;
				if (velocity.y > maxVelocity.y)
					velocity.y = maxVelocity.y;
				
				x += velocity.x * dTime;
				y += velocity.y * dTime;
				
				//reset, the force applied has been used
				force.make();
				
			}
		}
		
		/**
		 * prints out all information about this object
		 *
		 * @return	a string for tracing
		 */
		public function toSting():String
		{
			return ("pos(" + x + ", " + y + "), vel" + velocity.toSting() + ", accel" + acceleration.toSting());
		}
	}
}