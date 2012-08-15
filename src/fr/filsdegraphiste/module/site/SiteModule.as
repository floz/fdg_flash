/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site 
{
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
			addChildAt( _mainView = new MainView(), 0 );
			_mainView.show();
		}

		private function _step2CompleteHandler(event : StepEvent) : void 
		{
			removeChild( _loadingIcon );
			_start();
		}
		
		private function _navChangeHandler(event : NavEvent) : void 
		{
			navSiteManager.frozen = true;
			switch( navSiteManager.currentId )
			{
				case NavSiteId.NEWS: _showLoadingView( "news", _.data.news ); break;
				case NavSiteId.WORKS: _showLoadingView( "works", _.data.works ); break;
				case NavSiteId.LAB: _showLoadingView( "lab", _.data.lab ); break;
				case NavSiteId.ABOUT: _showLoadingView( "fdg" ); break;
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _start():void
		{
			navSiteManager.addEventListener( NavEvent.NAV_CHANGE, _navChangeHandler );
			navSiteManager.currentId = NavSiteId.NEWS;
		}
		
		private function _showLoadingView( title:String, data:Object = null ):void
		{
			_loadingRubView = new LoadingRubView( title, data );
			_loadingRubView.addEventListener( Event.COMPLETE, _loadCompleteHandler );
			_mainView.setContent( _loadingRubView );
			_loadingRubView.show();		
		}

		private function _loadCompleteHandler(event : Event) : void 
		{
			if( _loadingRubView.data != null )
			{
				_mainView.setDiaporama( _loadingRubView.data );
				navSiteManager.frozen = false;
			}
			else
			{
				if( navSiteManager.currentId == NavSiteId.ABOUT )
					trace( "about" );
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