package engine
{
	
	/**
	 * Interface for the KWorld to process. All KObjects contain a KBody
	 * that syncs with a sprite object. The KBody provides the physics
	 * @author Anderson Li
	 */
	public interface IKObject
	{
		/**
		 * Syncs KBody with a sprite that gets displayed
		 */
		function sync():void;
		
		function get body():KBody;
	}

}