
/**
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.core.commands.events 
{
	import flash.events.Event;
	
	public class CommandEvent extends Event 
	{
		public static const START:String = "start_command_event";
		public static const PROGRESS:String = "progress_command_event";
		public static const COMMAND_COMPLETE:String = "command_complete_command_event";
		public static const COMPLETE:String = "complete_command_event";
		
		/** Le pourcentage de progression de la commande executée */
		public var progressCount:Number;
		/** Le cout total de la commande executée */
		public var totalCount:Number;
		
		public function CommandEvent(type:String, progressCount:Number = 0, totalCount:Number = 0, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			this.progressCount = progressCount;
			this.totalCount = totalCount;
			
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new CommandEvent(type, progressCount, totalCount, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CommandEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}