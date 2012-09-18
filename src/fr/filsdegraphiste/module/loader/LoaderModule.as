/**
 * @author Floz
 */
package fr.filsdegraphiste.module.loader 
{
	import fr.filsdegraphiste.config.FDGData;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.ui.loading.LoadingIconOK;
	import fr.minuit4.core.configuration.conf;
	import fr.minuit4.core.navigation.modules.Module;
	import fr.minuit4.net.loaders.AssetLoader;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class LoaderModule extends Module
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loadingIcon:LoadingIconOK;
		private var _urlLoader:URLLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LoaderModule() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;		
			stage.frameRate = 60;	
			
			_.stage = stage;
			
			addChild( _loadingIcon = new LoadingIconOK() );
			
			if ( !isDev ) 
			{
				conf.addEventListener( ProgressEvent.PROGRESS, progressHandler );
				conf.addEventListener( Event.COMPLETE, confCompleteHandler );
			}
			else
			{
				addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			}
			
			conf.load( confURL );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function progressHandler( e:ProgressEvent ):void
		{
			_loadingIcon.percent = e.bytesLoaded / e.bytesTotal;
		}
		
		private function confCompleteHandler(e:Event):void 
		{
			_loadData();
		}
		
		private function _enterFrameHandler(e:Event):void 
		{
			_loadingIcon.percent += .05;
			if ( _loadingIcon.percent >= 1 )
			{
				removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
				_loadData();
			}
		}
		
		private function _loadData():void
		{
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.load( new URLRequest( "php/services.php") );
			_urlLoader.addEventListener( Event.COMPLETE, _loadDataCompleteHandler );
		}

		private function _loadDataCompleteHandler(event : Event) : void 
		{
			_.data = new FDGData( JSON.parse( _urlLoader.data ) );			
			_launchSite();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _launchSite():void
		{
			while( numChildren )
				removeChildAt( 0 );
			
			var site:Module = AssetLoader( conf.getItem( "site" ) ).content as Module;
			addChild( site );
			
			site.show();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get confURL():String { return loaderInfo.parameters[ "conf " ] || "./xml/conf.xml"; }
		public function get isDev():Boolean { return loaderInfo.parameters[ "isDev" ] == "true" || false; }
		
	}
	
}