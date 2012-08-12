
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.core.navigation.modules.interfaces 
{
	
	public interface IModule extends IModulePart
	{
		function loadData( url:String ):void;
		
		function get data():XML;
		function set data( value:XML ):void;
	}
	
}