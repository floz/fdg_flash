/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall.events 
{
	import flash.events.Event;
	public class ViewAllEvent extends Event
	{
		public static const PROJECT_SELECTED:String = "viewAllEventProjectSelected";
		
		public var idx:int;
		
		public function ViewAllEvent( type:String, idx:int = -1, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			this.idx = idx;
			super( type, bubbles, cancelable );
		}

		override public function clone():Event
		{
			return new ViewAllEvent( type, idx, bubbles, cancelable );
		}
	}
}

