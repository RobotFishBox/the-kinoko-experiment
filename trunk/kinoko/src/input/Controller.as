package input
{
	import engine.widgets.KDamper;
	import engine.widgets.KSpring;
	
	/**
	 * The input controller for the actors
	 * @author Anderson Li
	 */
	public class Controller
	{
		/**
		 * spring that is attached to the cursor
		 */
		private var _kSpring:KSpring;
		/**
		 * the damper that is attached to the cursor
		 */
		private var _kDamper:KDamper;

		
		public function Controller()
		{
			_kSpring = new KSpring();
			_kDamper = new KDamper();
		}
		
		public function attach() {
			
		}
	
	}

}