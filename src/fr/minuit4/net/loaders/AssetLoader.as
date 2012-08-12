
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 14.07.10		0.3		Floz		+ Réecriture complète en changeant un peu l'API.
 * 18.09.09		0.2		Floz		+ Correction de la méthode dispose() : le bitmapdata d'un objet bitmap n'est plus supprimé après l'appel.
 * 17.09.09		0.2		Floz		+ Ajout de la méthode execute
 * 15.09.09		0.2		Floz		+ Ajout de méthodes de AbstractLoader :
 * 										> register();
 * 										> unregister();
 * 									Qui permettent de gérer l'objet Loader.
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders 
{
	import flash.display.Loader;
	import flash.system.LoaderContext;
	
	public class AssetLoader extends AbstractLoader
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _loader:Loader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var loaderContext:LoaderContext;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AssetLoader( url:String = null ) 
		{
			super( url );
			
			_loader = new Loader();
			register( _loader.contentLoaderInfo );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function onLoadComplete():void 
		{
			_content = _loader.contentLoaderInfo.content;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function load( url:String = null ):void 
		{
			super.load( url );
			_loader.load( request, loaderContext );
		}
		
		override public function dispose():void 
		{
			super.dispose();
			
			try { _loader.unload(); _loader.close(); }
			catch ( e:Error ) { }
			
			unregister();
			_loader = null;
			
			_content = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get loader():Loader { return _loader; }
		
	}
	
}