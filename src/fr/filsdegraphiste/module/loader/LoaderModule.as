/**
 * @author Floz
 */
package fr.filsdegraphiste.module.loader 
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.ui.loading.LoadingIcon;
	import fr.minuit4.core.configuration.conf;
	import fr.minuit4.core.navigation.modules.Module;
	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.net.loaders.AssetLoader;
	
	public class LoaderModule extends Module
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loadingIcon:LoadingIcon;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LoaderModule() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_.stage = stage;
			
			addChild( _loadingIcon = new LoadingIcon() );
			
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
			_launchSite();
		}
		
		private function _enterFrameHandler(e:Event):void 
		{
			_loadingIcon.percent += .01;
			if ( _loadingIcon.percent >= 1 )
			{
				removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
				_launchSite();
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _launchSite():void
		{
			addChild( ModulePart( AssetLoader( conf.getItem( "site" ) ).content ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get confURL():String { return loaderInfo.parameters.conf || "./xml/conf.xml"; }
		public function get isDev():Boolean { return loaderInfo.parameters.isDev == "true" || false; }
		
	}
	
}