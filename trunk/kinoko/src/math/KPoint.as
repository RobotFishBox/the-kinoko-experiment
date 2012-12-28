package math
{
	
	/**
	 * Stores a 2D floating point coordinate.
	 *
	 * @author Anderson Li
	 */
	public class KPoint
	{
		/**
		 * @default 0
		 */
		public var x:Number;
		/**
		 * @default 0
		 */
		public var y:Number;
		
		/**
		 * Instantiate a new point object.
		 *
		 * @param	X		The X-coordinate of the point in space.
		 * @param	Y		The Y-coordinate of the point in space.
		 */
		public function KPoint(X:Number = 0, Y:Number = 0)
		{
			x = X;
			y = Y;
		}
		
		/**
		 * Instantiate a new point object.
		 *
		 * @param	X		The X-coordinate of the point in space.
		 * @param	Y		The Y-coordinate of the point in space.
		 */
		public function make(X:Number = 0, Y:Number = 0):KPoint
		{
			x = X;
			y = Y;
			return this;
		}
		
		/**
		 * prints out all information about this object
		 *
		 * @return	a string for tracing
		 */
		public function toSting():String
		{
			return ("(" + x + ", " + y + ")");
		}
	}

}