
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 14.07.10		0.3		Floz		+ Réecriture complète en changeant un peu l'API.
 * 21.09.09		0.2		Floz		+ Renommage en DataLoader
 * 17.09.09		0.2		Floz		+ Ajout de la méthode execute
 * 15.09.09		0.2		Floz		+ Ajout de méthodes de AbstractLoader :
 * 										> register();
 * 										> unregister();
 * 									Qui permettent de gérer l'objet Loader.
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders 
{
	import flash.net.URLLoader;
	
	public class DataLoader extends AbstractLoader
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _loader:URLLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DataLoader( url:String = null ) 
		{
			super( url );
			
			_loader = new URLLoader();
			register( _loader );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function onLoadComplete():void 
		{
			_content = _loader.data;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function load(url:String = null):void 
		{
			super.load( url );
			_loader.load( request );
		}
		
		override public function dispose():void 
		{
			super.dispose();
			
			try { _loader.close(); }
			catch ( e:Error ) { }
			
			unregister();
			_loader = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}