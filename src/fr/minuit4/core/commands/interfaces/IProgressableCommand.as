
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.core.commands.interfaces
{
	import flash.events.IEventDispatcher;
	
	public interface IProgressableCommand extends ICommand, IEventDispatcher
	{
		function get progressCount():Number;
		
		function set estimatedCount( value:Number ):void;
		
		function get estimatedCount():Number;
	}
	
}