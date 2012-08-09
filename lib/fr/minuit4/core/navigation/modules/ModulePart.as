
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.core.navigation.modules 
{
	import flash.display.Sprite;
	import fr.minuit4.core.navigation.modules.events.ModuleEvent;
	import fr.minuit4.core.navigation.modules.interfaces.IModulePart;
	
	public class ModulePart extends Sprite implements IModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _id:String;
		protected var _frozen:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ModulePart() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function show( delay:Number = 0 ):Number
		{
			dispatchEvent( new ModuleEvent( ModuleEvent.OPEN ) );
			return 0;
		}
		
		public function hide( delay:Number = 0 ):Number
		{
			dispatchEvent( new ModuleEvent( ModuleEvent.CLOSE ) );
			return 0;
		}
		
		public function freeze():void
		{
			if ( _frozen )
				return;
			
			_frozen = true;
		}
		
		public function unfreeze():void 
		{
			if ( !_frozen )
				return;
			
			_frozen = false;
		}
		
		public function dispose():void
		{
			// ABSTRACT
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get id():String { return _id; }
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get frozen():Boolean { return _frozen; }
		
		public function set frozen(value:Boolean):void 
		{
			if ( value )
				freeze();
			else
				unfreeze();			
		}
		
	}
	
}