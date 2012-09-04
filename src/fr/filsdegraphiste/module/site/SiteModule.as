/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site 
{
	import fr.minuit4.debug.FPS;
	import fr.filsdegraphiste.module.site.ui.about.AboutContent;
	import fr.filsdegraphiste.module.site.nav.NavWorkId;
	import fr.filsdegraphiste.module.site.nav.navWorkManager;
	import flash.events.Event;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.event.StepEvent;
	import fr.filsdegraphiste.module.site.nav.NavSiteId;
	import fr.filsdegraphiste.module.site.nav.navSiteManager;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.loading.ExpandableLoadingIcon;
	import fr.filsdegraphiste.module.site.ui.loading.LoadingRubView;
	import fr.minuit4.core.navigation.modules.Module;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	
	public class SiteModule extends Module
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loadingIcon:ExpandableLoadingIcon;
		private var _mainView:MainView;
		
		private var _loadingRubView:LoadingRubView;
		
		private var _firstLoad:Boolean = true;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SiteModule() 
		{
			addChild( _loadingIcon = new ExpandableLoadingIcon() );
			_loadingIcon.addEventListener( StepEvent.STEP1_COMPLETE, _step1CompleteHandler );
			_loadingIcon.addEventListener( StepEvent.STEP2_COMPLETE, _step2CompleteHandler );
			_loadingIcon.percent = 1;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function _step1CompleteHandler(event : StepEvent) : void
		{
			_loadingIcon.removeEventListener( StepEvent.STEP1_COMPLETE, _step1CompleteHandler );
			
			addChildAt( _mainView = new MainView(), 0 );
			_mainView.show();
		}

		private function _step2CompleteHandler(event : StepEvent) : void 
		{
			_loadingIcon.removeEventListener( StepEvent.STEP2_COMPLETE, _step2CompleteHandler );
			
			removeChild( _loadingIcon );
			_start();
		}
		
		private function _navChangeHandler(event : NavEvent) : void 
		{ 
			navSiteManager.frozen = true;
			
			switch( navSiteManager.currentId )
			{
				case NavSiteId.NEWS: _showLoadingView( "news", _.data.news, _.data.news.files_to_load ); break;
				case NavSiteId.WORKS:
					navWorkManager.currentId = NavWorkId.WEB; 
					_showLoadingView( "works", _.data.works[ navWorkManager.currentId ], _.data.works.files_to_load ); 
					break;
				case NavSiteId.LAB: _showLoadingView( "lab", _.data.lab, _.data.lab.files_to_load ); break;
				case NavSiteId.ABOUT: _showLoadingView( "fdg" ); break;
			}
			
			if( navSiteManager.currentId != NavSiteId.WORKS )
				_mainView.mid.workMenu.hide();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _start():void
		{
			navSiteManager.addEventListener( NavEvent.NAV_CHANGE, _navChangeHandler );
			navSiteManager.currentId = NavSiteId.WORKS;
		}
		
		private function _showLoadingView( title:String, data:Object = null, filesToLoad:Array = null ):void
		{
			_loadingRubView = new LoadingRubView( title, data, filesToLoad );
			_loadingRubView.addEventListener( Event.COMPLETE, _loadCompleteHandler, false, 0, true );
			_mainView.setContent( _loadingRubView );
			_loadingRubView.show( _firstLoad ? 0 : .4 );
			
			_firstLoad = false;
		}

		private function _loadCompleteHandler(event : Event) : void 
		{
			_loadingRubView.removeEventListener( Event.COMPLETE, _loadCompleteHandler );
			
			navSiteManager.frozen = false;
			if( _loadingRubView.data != null )
			{
				_mainView.setDiaporama( _loadingRubView.data );
				if( navSiteManager.currentId == NavSiteId.WORKS )
				{
					_mainView.mid.workMenu.show();
				}
			}
			else
			{
				if( navSiteManager.currentId == NavSiteId.ABOUT )
				{
					var about:AboutContent = new AboutContent();
					_mainView.setContent( about );
					about.show();
				}
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
			
		override public function show( delay:Number = 0 ):Number
		{			
			_loadingIcon.expends();
			return super.show(delay);
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}