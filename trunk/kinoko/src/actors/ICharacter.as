package actors 
{
	import engine.IKObject;
	import graphics.KSprite;
	/**
	 * Interface for every character
	 * @author Anderson Li
	 */
	public interface ICharacter extends IKObject
	{	
		function idle():void;
		function walk():void;
		function run():void;
		function jump():void;
		function attack():void;
		function get kSprite():KSprite;
		function get runSpeed():Number;
		function get walkSpeed():Number;
		function get jumpThreshold():Number;
		function get jumpForce():Number;
		function get springK():Number;
		function get damperC():Number
	}

}