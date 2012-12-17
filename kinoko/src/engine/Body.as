package engine 
{
	import math.KPoint;
	/**
	 * a physical body in the engine
	 * @author Anderson Li
	 */
	public class Body 
	{
		private var _pos:KPoint;
		private var _vel:KPoint;
		private var _accel:KPoint;
		private var _force:KPoint;
		
		public function Body() 
		{
			_pos = new KPoint();
			_vel = new KPoint();
		}
		
		public function get pos():KPoint 
		{
			return _pos;
		}
		
		public function set pos(value:KPoint):void 
		{
			_pos = value;
		}
		
		public function get vel():KPoint 
		{
			return _vel;
		}
		
		public function set vel(value:KPoint):void 
		{
			_vel = value;
		}
		
		public function get accel():KPoint 
		{
			return _accel;
		}
		
		public function set accel(value:KPoint):void 
		{
			_accel = value;
		}
		
		public function get force():KPoint 
		{
			return _force;
		}
		
		public function set force(value:KPoint):void 
		{
			_force = value;
		}
		
	}

}