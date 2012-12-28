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
		 * spring constant (stiffness)
		 */
		public var k:Number;
		/**
		 * natural length of the spring
		 */
		public var kObject1:IKObject;
		/**
		 * natural length of the spring
		 */
		public var kObject2:IKObject;
		
		public function KSpring(kObject_1:IKObject = null, kObject_2:IKObject = null)
		{
			k = 1;
			nLength = 0;
			attach(kObject_1, kObject_2);
		}
		
		/**
		 * attach objects to the end of the spring
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
			var delta:KPoint = new KPoint();
			delta.x = kObject1.body.x - kObject2.body.x;
			delta.y = kObject1.body.y - kObject2.body.y;
			
			var length:Number = Math.sqrt(delta.x * delta.x + delta.y + delta.y);
			
			if (length > nLength)
			{
				//in tension
				var force:Number = k * (length - nLength);
				
			}
		}
	
	}

}