
/**
 * @author Floz
 */
package fr.minuit4.core.navigation.nav
{
	import fr.minuit4.bouboup;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	import fr.minuit4.core.navigation.nav.swfaddress.SWFAddressManager;

	import flash.events.EventDispatcher;

	use namespace bouboup;

	public class NavNode extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		bouboup var _manager:SWFAddressManager;
		
		bouboup var _tempId:String;
		bouboup var _idx:int;
		
		private var _currentId:String;
		
		private var _frozen:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavNode() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate( id:String ):void
		{
			if ( frozen )
				return;
			
			if ( _tempId == id )
				return;
				
			_tempId = id;
			
			if ( _manager )
			{
				_manager.updateNode( this );
			}
			else 
			{
				currentId = _tempId;
			}
		}
		
		public function reset():void
		{
			_currentId = null;
			_tempId = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set currentId( value:String ):void
		{
			if( _currentId == value || _frozen )
				return;
			
			_tempId =
			_currentId = value;
			dispatchEvent( new NavEvent( NavEvent.NAV_CHANGE ) );
		}
		
		public function get currentId():String { return _currentId; }
		
		public function set frozen( value:Boolean ):void
		{
			_frozen = value;
			if ( _manager )
				_manager.frozen = value;
		}

		public function get frozen():Boolean
		{
			if ( _manager )
				return _manager.frozen || _frozen;
			
			return _frozen;
		}
		
	}

}