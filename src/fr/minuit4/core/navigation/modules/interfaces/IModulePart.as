
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.core.navigation.modules.interfaces 
{
	import fr.minuit4.core.interfaces.IDisposable;
	
	public interface IModulePart extends IDisposable
	{
		function show( delay:Number = 0 ):Number;
		function hide( delay:Number = 0 ):Number;
		
		function freeze():void;
		function unfreeze():void;
		
		function get id():String;
		function set id( value:String ):void;
	}
	
}