
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 23/08/2010		0.1		Première version du NavManager.
 */
package fr.minuit4.core.navigation.nav 
{
	import flash.events.EventDispatcher;
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	
	public class NavManager extends EventDispatcher implements IDisposable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _nodesById:Object;
		protected var _historic:NavChainItem;
		
		protected var _currentNode:NavNode;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var frozen:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavManager() 
		{
			_nodesById = { };
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Crée un noeud de navigation.
		 * En créant un noeud, celui ci peut par la suite être activé via la méthode activate de cet objet.
		 * @param	id	String	Correspond à l'identifiant du noeud. Permettra de l'appeller via la méthode activate.
		 * @param	targetId	String	Correspond à l'identifiant qui doit être activé. Par défaut, targetId est null.
		 * 								Exemple d'utilisation : un menu avec plusieurs items (item1, item2, ..., itemn), on active item1,
		 * 								mais on souhaite que ce soit l'item7 qui soit visuellement activé. targetId contiendra "item7", et non "item1" ou 'null'.
		 * @param	depth	int	Un paramètre permettant de spécifier la profondeur du noeud, et donc de l'éventuel module associé.
		 */
		public function createNode( id:String, targetId:String = "null", depth:int = -1 ):void
		{
			var node:NavNode = new NavNode( id, targetId, depth );
			addNode( node );
		}
		
		/**
		 * Ajoute un noeud de navigation.
		 * En ajoutant un noeud, celui ci peut par la suite être activé via la méthode activate de cet objet.
		 * @param	id	String	Correspond à l'identifiant du noeud. Permettra de l'appeller via la méthode activate.
		 * @param	targetId	String	Correspond à l'identifiant qui doit être activé. Par défaut, targetId est null.
		 * 								Exemple d'utilisation : un menu avec plusieurs items (item1, item2, ..., itemn), on active item1,
		 * 								mais on souhaite que ce soit l'item7 qui soit visuellement activé. targetId contiendra "item7", et non "item1" ou 'null'.
		 * @param	depth	int	Un paramètre permettant de spécifier la profondeur du noeud, et donc de l'éventuel module associé.
		 */
		public function addNode( node:NavNode ):void
		{
			node._navManager = this;
			_nodesById[ node.id ] = node;
		}
		
		/**
		 * Renvoie un objet NavNode précédemment crée ou ajouté au NavManager.
		 * @param	id	String	L'identifiant du NavNode.
		 * @return	NavNode
		 */
		public function getNode( id:String ):NavNode
		{
			return _nodesById[ id ];
		}
		
		/**
		 * Active un noeud de navigation.
		 * Lorsqu'un noeud de navigation est activé, NavEvent.CHANGE est dispatché.
		 * Cette méthode n'aura pas d'effet si le noeud que l'on tente d'activer l'est déjà, ou si le paramètre frozen vaut 'true'.
		 * @param	id	String	L'identifiant du noeuf que l'on souhaite activer.
		 */
		public function activate( id:String ):NavNode
		{
			if ( frozen )
				return currentNode;
			
			var node:NavNode = NavNode( _nodesById[ id ] );
			if ( !node )
				return null;
			
			if ( node == _currentNode )
				return _currentNode;
			
			var navChainItem:NavChainItem = new NavChainItem( id );
			if ( _historic )
			{
				_historic.next = navChainItem;
				navChainItem.prev = _historic;
				_historic = navChainItem;
			}
			else _historic = navChainItem;
			
			_currentNode = node;
			dispatchEvent( new NavEvent( NavEvent.NAV_CHANGE ) );
			
			return _currentNode;
		}
		
		public function prev():NavNode
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
		
		public function next():NavNode
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
		
		public function deselect():void
		{
			_currentNode = null;
		}
		
		public function clearHistoric():void
		{
			_historic = new Vector.<NavNode>();
		}
		
		public function freeze( value:Boolean ):void { frozen = value; }
		
		public function dispose():void
		{
			_currentNode = null;
			_historic = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get currentNode():NavNode { return _currentNode; }
		
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