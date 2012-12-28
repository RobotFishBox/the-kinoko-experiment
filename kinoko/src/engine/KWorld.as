package engine
{
	import engine.widgets.IKWidgets;
	import math.KPoint;
	
	/**
	 * KWorld manages the KWidgets and KBodies
	 * @author Anderson Li
	 */
	public class KWorld
	{
		/**
		 * used to relate pixels to meters
		 */
		public var pixelScale:KPoint;
		
		/**
		 * gravity of the world.
		 * units measured in newtons (N).
		 */
		public var gravity:KPoint;
		
		/**
		 * Array of all the <code>KBody</code>s that exist in this world.
		 */
		public var kObjects:Array;
		
		/**
		 * Array of all the <code>kWidgets</code>s that exist in this world.
		 */
		public var kWidgets:Array;
		
		public function KWorld()
		{
			pixelScale = new KPoint(1, 1);
			gravity = new KPoint();
			kObjects = new Array();
		}
		
		/**
		 * Automatically goes through and calls update on everything you added.
		 */
		public function update():void
		{
			//sync and apply gravity force
			for each (var kObject:IKObject in kObjects)
			{
				kObject.sync();
				kObject.body.force.y += gravity.y;
				kObject.body.force.x += gravity.x;
			}
		
			//operate all the widgets
			for each (var kWidget:IKWidgets in kWidgets)
			{
				kWidget.operate();
			}
		}
		
		/**
		 * Adds a new <code>IKObject</code> to the world.
		 *
		 * @param	kObject		The kObject you want to add to the group.
		 *
		 * @return	The same <code>IKObject</code> object that was passed in.
		 */
		public function addKObject(kObject:IKObject):IKObject
		{
			kObject.body.pixelScale = pixelScale;
			kObjects.push(kObject);
			return kObject;
		}
		
		/**
		 * Removes a IKObject from the group.
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
		
		/**
		 * Adds a new <code>IKWidgets</code> to the world.
		 *
		 * @param	kWidget		The object you want to add to the group.
		 *
		 * @return	The same <code>IKWidgets</code> object that was passed in.
		 */
		public function addKWidget(kWidget:IKWidgets):IKWidgets
		{
			kWidgets.push(kWidget);
			return kWidget;
		}
		
		/**
		 * Removes a IKWidgets from the group.
		 *
		 * @param	kWidget	The <code>IKWidgets</code> you want to remove.
		 *
		 * @return	The removed object.
		 */
		public function removeKWidget(kWidget:IKWidgets):IKWidgets
		{
			var index:int = kWidgets.indexOf(kWidget);
			kWidgets.splice(index, 1);
			return kWidget;
		}
	
	}

}