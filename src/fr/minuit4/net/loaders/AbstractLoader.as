
/**
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 14.07.10		0.3		Floz		+ Réecriture complète en changeant un peu l'API.
 * 20.09.09		0.2		Floz		+ Implémentation de l'interface IDisposable.
 * 17.09.09		0.2		Floz		+ Implémentation de l'interface ICommand.
 * 									Les loaders peuvent donc être utilisé comme des commands qu'un objet Batch peut exécuter via la méthode execute();
 * 									+ La méthode load n'attend plus obligatoirement un paramètre url.
 * 									Celui ci peut être passé en paramètre au moment de l'instanciation ou via la méthode setUrl.
 * 15.09.09		0.2		Floz		+ Ajout de méthodes :
 * 										> register();
 * 										> unregister();
 * 									Qui permettent de gérer l'objet Loader.
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders 
{
	import fr.minuit4.core.commands.ProgressableCommand;
	import fr.minuit4.core.commands.events.CommandEvent;
	import fr.minuit4.core.interfaces.IDisposable;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	public class AbstractLoader extends ProgressableCommand implements IDisposable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _url:String;
		protected var _dispatcher:IEventDispatcher;
		
		protected var _content:*;
		
		protected var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var request:URLRequest;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractLoader( url:String = null ) 
		{
			_url = url;
			request = new URLRequest();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		protected function initHandler(e:Event):void 
		{
			dispatchEvent( e );
		}
		
		protected function progressHandler(e:ProgressEvent):void 
		{
			setProgressCount( ( e.bytesLoaded / e.bytesTotal ) * _estimatedCount );
			dispatchEvent( e );
		}
		
		protected function completeHandler(e:Event):void 
		{
			onLoadComplete();
			dispatchEvent( e );
			dispatchEvent( new CommandEvent( CommandEvent.COMPLETE ) );
		}
		
		protected function ioErrorHandler(e:IOErrorEvent):void 
		{
			trace( "AbstractLoader.ioErrorHandler > " + request.url );
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void 
		{
			trace( "AbstractLoader.httpStatusHandler > " + e.status );			
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void 
		{
			trace( "AbstractLoader.securityErrorHandler > " + request.url );			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function register( ed:IEventDispatcher ):void
		{
			_dispatcher = ed;
			_dispatcher.addEventListener( Event.INIT, initHandler );
			_dispatcher.addEventListener( ProgressEvent.PROGRESS, progressHandler );
			_dispatcher.addEventListener( Event.COMPLETE, completeHandler );			
			_dispatcher.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			_dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			_dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
		}
		
		protected function unregister():void
		{
			_dispatcher.removeEventListener( Event.INIT, initHandler );
			_dispatcher.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
			_dispatcher.removeEventListener( Event.COMPLETE, completeHandler );
			_dispatcher.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			_dispatcher.removeEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			_dispatcher.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
			_dispatcher = null;
		}
		
		protected function onLoadComplete():void
		{
			// ABSTRACT : Set item loaded
			_running = false;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Démarre le chargement.
		 * @param	url	String	Le lien vers le fichier à charger.
		 */
		public function load( url:String = null ):void
		{
			if ( url )
				_url = url;
			
			request.url = _url;
			_running = true;
		}
		
		/**
		 * Démarre le chargement, nécessite qu'une URL soit renseignée avant.
		 */
		override public function execute():void
		{
			if ( !_url )
			{
				throw new Error( "Impossible de lancer le chargement, l'url n'a pas été renseignée." );
				return;
			}
			
			load( _url );
		}
		
		/**
		 * Dispose le Loader.
		 */
		public function dispose():void
		{
			request = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/** Indique si le Loader procède à un chargement ou non */
		public function get running():Boolean { return _running; }
		
		/** Le contenu chargé par le Loader */
		public function get content():* { return _content; }
		
		/** L'URL vers le ficher à charger */
		public function get url():String { return _url; }		
		public function set url(value:String):void 
		{
			_url = value;
		}
		
	}
	
}