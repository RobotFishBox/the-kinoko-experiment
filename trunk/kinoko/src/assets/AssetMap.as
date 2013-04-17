package assets
{
	
	/**
	 * loads and manages all the image assets the game needs.
	 * @author Anderson Li
	 */
	public class AssetMap
	{
		[Embed(source="../../data/temp/ninja.png")]
		static public var NINJA:Class;
		
		[Embed(source="../../data/temp/ninja2.png")]
		static public var NINJA2:Class;
		
		[Embed(source="../../data/temp/ninja3.png")]
		static public var NINJA3:Class;
	}

}