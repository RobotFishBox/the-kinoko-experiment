package engine.widgets
{
	import engine.IKObject;
	import math.KPoint;
	
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class KSpring implements IKWidgets
	{
		/**
		 * natural length of the spring
		 */
		public var nLength:Number;
		/**
		 * spring constant (stiffness). Units in N/m
		 */
		public var k:Number;
		/**
		 * effectiveness of the spring in the x or y in percentage from 0 to 1.
		 *
		 * WARNING: do not make this negative or more than 1
		 */
		public var effect:KPoint;
		/**
		 * attached object 1
		 */
		public var kObject1:IKObject;
		/**
		 * attached object 2
		 */
		public var kObject2:IKObject;
		
		/**
		 * Creates a new spring
		 *
		 * @param	kObject1	The <code>IKObject</code> you want to attach.
		 * @param	kObject2	The <code>IKObject</code> you want to attach.
		 * @param	K			The spring constant.
		 * @param	NLength		Natural length of the spring.
		 */
		public function KSpring(kObject_1:IKObject = null, kObject_2:IKObject = null, K:Number = 1, NLength:Number = 0)
		{
			k = K;
			nLength = NLength;
			effect = new KPoint(1, 1);
			attach(kObject_1, kObject_2);
		}
		
		/**
		 * Attach two <code>IKObject</code>s to the spring.
		 *
		 * @param	kObject		The kObject you want to add to the spring.
		 *
		 */
		public function attach(kObject_1:IKObject, kObject_2:IKObject):void
		{
			kObject1 = kObject_1;
			kObject2 = kObject_2;
		}
		
		/* INTERFACE engine.widgets.IKWidgets */
		
		/**
		 * Operate runs the widget and applies forces to bodies
		 */
		public function operate():void
		{
			//delta is calculated from Object 1 - Object 2
			var delta_x:Number = kObject1.body.x - kObject2.body.x;
			var delta_y:Number = kObject1.body.y - kObject2.body.y;
			var length:Number = Math.sqrt(delta_x * delta_x + delta_y * delta_y);
			var cos:Number;
			var sin:Number;
			
			if (length == 0)
			{
				cos = Math.random();
				sin = Math.random();
			}
			else
			{
				cos = delta_x / length;
				sin = delta_y / length;
			}
			var force:Number = k * Math.abs(length - nLength);
			var force_x:Number = force * cos;
			var force_y:Number = force * sin;
			
			if (length > nLength)
			{
				//in tension
				kObject1.body.force.x -= force_x * effect.x;
				kObject2.body.force.x += force_x * effect.x;
				
				kObject1.body.force.y -= force_y * effect.y;
				kObject2.body.force.y += force_y * effect.y;
			}
			else if (length < nLength)
			{
				//in compression
				kObject1.body.force.x += force_x * effect.x;
				kObject2.body.force.x -= force_x * effect.x;
				
				kObject1.body.force.y += force_y * effect.y;
				kObject2.body.force.y -= force_y * effect.y;
			}
		}
	
	}

}