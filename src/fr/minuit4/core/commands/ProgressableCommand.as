
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.core.commands 
{
	import flash.events.EventDispatcher;
	import fr.minuit4.core.commands.events.CommandEvent;
	import fr.minuit4.core.commands.interfaces.IProgressableCommand;
	
	public class ProgressableCommand extends EventDispatcher implements IProgressableCommand
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _progressCount:Number = 0;
		protected var _estimatedCount:Number = 1;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ProgressableCommand() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function setProgressCount( value:Number ):void
		{
			_progressCount = value;
			if ( _progressCount > _estimatedCount ) _progressCount = _estimatedCount;
			
			dispatchEvent( new CommandEvent( CommandEvent.PROGRESS, _progressCount, _estimatedCount ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function execute():void
		{
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get progressCount():Number { return _progressCount; }
		
		public function get estimatedCount():Number { return _estimatedCount; }
		
		public function set estimatedCount(value:Number):void 
		{
			_estimatedCount = value;
		}
		
	}
	
}