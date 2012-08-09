
/**
 * @author Floz
 */
package fr.minuit4.core.navigation.nav.swfaddress
{
	import fr.minuit4.bouboup;
	import fr.minuit4.core.navigation.nav.NavNode;
	import fr.minuit4.core.navigation.swfaddress.SWFAddress;
	import fr.minuit4.core.navigation.swfaddress.SWFAddressEvent;

	use namespace bouboup;

	public class SWFAddressManager
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _defaultNodeId:String;
		
		private var _requestedPath:String;
		private var _path:/*NavNode*/Array;
		private var _nodes:/*NavNode*/Array;
		
		private var _lastPathNames:/*String*/Array;
		
		private var _length:int;
		private var _rules:XML;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var frozen:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SWFAddressManager( defaultNodeId:String ) 
		{
			_defaultNodeId = defaultNodeId;
			
			_path = [];
			_nodes = [];
			
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, swfAddressChangeHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function swfAddressChangeHandler( e:SWFAddressEvent ):void
		{
			var pathNames:/*String*/Array = e.pathNames;
			_length = pathNames.length;
			
			if ( pathNames.length == 0 )
			{
				var node:NavNode = getNodeAt( 0 );
				node.activate( _defaultNodeId );
			}
			else
			{				
				if ( _lastPathNames )
				{
					if ( _lastPathNames.length > pathNames.length )
					{
						i = _lastPathNames.length;
						var idx:int = pathNames.length - 1;
						while( --i > idx )
							getNodeAt( i ).reset();
					}
				}
				
				var n:int = pathNames.length;
				for( var i:int; i < n; ++i )
					getNodeAt( i ).currentId = pathNames[ i ];
			}
			
			_lastPathNames = pathNames;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		bouboup function updateNode( node:NavNode ):void
		{
			var idx:int = node._idx;
			
			_path[ idx ] = node;
			var i:int = _path.length;
			while ( --i > idx )
				_path.length--;
			
			update();
		}
		
		private function validateRules( path:String ):String
		{
			var x:XML = XML( _rules.url.( @id == path )[ 0 ] );
			if ( x != "" )
				path = x.rewrite[ 0 ];
			
			return path;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getNodeAt( idx:int ):NavNode
		{
			var node:NavNode = _nodes[ idx ];
			if ( !node )
			{
				node = new NavNode();
				node._manager = this;
				node._idx = idx;
				
				_nodes[ idx ] = node;
			}
			
			
			return node;
		}
		
		public function update():void
		{			
			var idx:int = -1;
			
			_requestedPath = "/";
			
			var node:NavNode;
			while( node = _path[ ++idx ] )
			{
				if ( node._tempId )
					_requestedPath += node._tempId + "/";
			}
			
			if ( _rules )
				_requestedPath = validateRules( _requestedPath );
			
			SWFAddress.setValue( _requestedPath );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get length():int { return _length; }
		
		public function set rules( value:XML ):void
		{
			_rules = value;
		}
		
	}

}