package fr.filsdegraphiste.event 
{
	import flash.events.Event;

	/**
	 * @author floz
	 */
	public class StepEvent extends Event 
	{
		public static const STEP1_START:String = "stepEventStep1Start";
		public static const STEP1_COMPLETE:String = "stepEventStep1Complete";
		public static const STEP2_START:String = "stepEventStep2Start";
		public static const STEP2_COMPLETE:String = "stepEventStep2Complete";
		
		public function StepEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
	}
}
