
/**
 * @author Floz
 * CETTE CLASSE N'A PAS ENCORE ETE TESTEE
 */
package fr.minuit4.core.navigation.nav
{
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	
	public class HistoricalNavManager extends NavManager_old
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _historic:NavChainItem;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function HistoricalNavManager() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function activate( id:String ):NavNode_old
		{
			var old:NavNode_old = _currentNode;
			var current:NavNode_old = super.activate( id );
			
			if ( current && old != current )
			{
				var navChainItem:NavChainItem = new NavChainItem( id );
				if ( _historic )
				{
					_historic.next = navChainItem;
					navChainItem.prev = _historic;
					_historic = navChainItem;
				}
				else _historic = navChainItem;
			}
			
			return current;
		}
		
		public function prev():NavNode_old
		{
			if ( frozen )
				return _currentNode;
			
			var navChainItem:NavChainItem = _historic.prev;
			if ( navChainItem == null )
				return _currentNode;
			
			_historic = navChainItem;
			
			_currentNode = _nodesById[ navChainItem.id ];
			dispatchEvent( new NavEvent( NavEvent.NAV_CHANGE ) );
			
			return _currentNode;
		}
		
		public function next():NavNode_old
		{
			if ( frozen )
				return _currentNode;
			
			var navChainItem:NavChainItem = _historic.next;
			if ( navChainItem == null )
				return _currentNode;
			
			_historic = navChainItem;
			
			_currentNode = _nodesById[ navChainItem.id ];
			dispatchEvent( new NavEvent( NavEvent.NAV_CHANGE ) );
			
			return _currentNode;
		}
		
		public function clearHistoric():void
		{
			_historic = new NavChainItem('');
		}
		
		override public function dispose():void
		{
			super.dispose();
			_historic = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}

final class NavChainItem
{
	public var prev:NavChainItem;
	public var next:NavChainItem;
	
	public var id:String;
	
	public function NavChainItem( id:String )
	{
		this.id = id;
	}
}