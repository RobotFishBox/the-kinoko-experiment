package engine
{
	
	/**
	 * models a spring with a mass attached
	 * @author Kinoko
	 */
	public class Spring
	{
		private var _mass:Number; // mass of the attached object
		private var _length:Number; // length of spring - equilibrium
		private var _k:Number; // spring constant
		
		public function Spring(mass:Number, length:Number, k:Number)
		{
			_mass = mass;
			_length = length;
			_k = k;
		}
		
		/* Getters and Setters */
		
		public function get mass():Number
		{
			return _mass;
		}
		
		public function set mass(value:Number):void
		{
			_mass = value;
		}
		
		public function get length():Number
		{
			return _length;
		}
		
		public function set length(value:Number):void
		{
			_length = value;
		}
		
		public function get k():Number
		{
			return _k;
		}
		
		public function set k(value:Number):void
		{
			_k = value;
		}
	
	}

}