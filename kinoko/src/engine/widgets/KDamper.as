package engine.widgets
{
	import engine.IKObject;
	import math.KPoint;
	
	/**
	 * KDamper mimicks the function of a real damper
	 * @author Anderson Li
	 */
	public class KDamper implements IKWidgets
	{
		/**
		 * damper coefficient. Units in N/(m/s)
		 */
		public var c:Number;
		/**
		 * effectiveness of the spring in the x or y in percentage from 0 to 1.
		 *
		 * WARNING: do not make this negative or more than 1
		 */
		public var effect:KPoint;
		/**
		 * Array of all the <code>kObjects</code>s that the damper applies to.
		 */
		public var kObjects:Array;
		
		/**
		 * Creates a new damper
		 *
		 * @param	C			The damper coefficent.
		 */
		public function KDamper(C:Number = 0)
		{
			c = C;
			effect = new KPoint(1, 1);
			kObjects = new Array();
		}
		
		/**
		 * Adds a new <code>IKObject</code> to this damper.
		 *
		 * @param	kObject		The kObject you want to add to the damper.
		 *
		 * @return	The same <code>IKObject</code> object that was passed in.
		 */
		public function attach(kObject:IKObject):IKObject
		{
			kObjects.push(kObject);
			return (kObject);
		}
		
		/**
		 * Removes a IKObject from the damper.
		 *
		 * @param	kObject	The <code>IKObject</code> you want to remove.
		 *
		 * @return	The removed object.
		 */
		public function removeKObject(kObject:IKObject):IKObject
		{
			var index:int = kObjects.indexOf(kObject);
			kObjects.splice(index, 1);
			return kObject;
		}
		
		/* INTERFACE engine.widgets.IKWidgets */
		
		/**
		 * Operate runs the widget and applies forces to bodies
		 */
		public function operate():void
		{
			for each (var kObject:IKObject in kObjects)
			{
				//dampers applies forces opposite to velocity
				kObject.body.force.x -= kObject.body.velocity.x * c * effect.x;
				kObject.body.force.y -= kObject.body.velocity.x * c * effect.y;
			}
		}
	
	}

}