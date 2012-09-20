/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site 
{
	import fr.filsdegraphiste.module.site.nav.navProjectManager;
	import swfaddress.SWFAddressEvent;
	import swfaddress.SWFAddress;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.event.StepEvent;
	import fr.filsdegraphiste.module.site.nav.NavSiteId;
	import fr.filsdegraphiste.module.site.nav.NavWorkId;
	import fr.filsdegraphiste.module.site.nav.navSiteManager;
	import fr.filsdegraphiste.module.site.nav.navWorkManager;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.about.AboutContent;
	import fr.filsdegraphiste.module.site.ui.loading.ExpandableLoadingIcon;
	import fr.filsdegraphiste.module.site.ui.loading.LoadingRubView;
	import fr.filsdegraphiste.module.site.ui.viewall.ViewAll;
	import fr.minuit4.core.navigation.modules.Module;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	import fr.minuit4.debug.FPS;

	import flash.events.Event;
	
	public class SiteModule extends Module
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loadingIcon:ExpandableLoadingIcon;
		private var _mainView:MainView;
		private var _viewAll:ViewAll;
		
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
			_viewAll = new ViewAll( _mainView );
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
			
			_mainView.mid.btViewAll.hide();
			
			switch( navSiteManager.currentId )
			{
				case NavSiteId.NEWS: _showLoadingView( "news", _.data.news, _.data.news.files_to_load ); break;
				case NavSiteId.WORKS:
					//navWorkManager.currentId = NavWorkId.WEB;
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
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, _swfAddressChangeHandler );
			navSiteManager.addEventListener( NavEvent.NAV_CHANGE, _navChangeHandler );
		}

		private function _swfAddressChangeHandler( event:SWFAddressEvent ):void
		{
			trace( "!!!!!! SWFADDESS CHANGE" );
			_performReroot( event.pathNames );
		}

		private function _performReroot( pathNames:Array ):void
		{
			trace( "!!! preformReroot " + pathNames );
			
			var n:int = pathNames.length;
			
			var newNavSiteId:String,
				newNavWorkId:String,
				newNavProjectId:String;
			
			var needReroot:Boolean = false;
				
			trace( n );
			if( n > 0 )
			{
				trace( "n > 0" );
				switch( pathNames[ 0 ] )
				{
					case NavSiteId.NEWS:
					case NavSiteId.WORKS:
					case NavSiteId.LAB: 
					case NavSiteId.ABOUT: 
						newNavSiteId = pathNames[ 0 ];
						break;
					default: 
						newNavSiteId = NavSiteId.NEWS;
						needReroot = true; 
						break;
				}
				
				if( n > 1 )
				{
					trace( "n > 1" );
					var isNumber:Boolean = Number( pathNames[ 1 ] ).toString() != "NaN";
					if( isNumber )
					{
						newNavProjectId = pathNames[ 1 ];	
					}
					else
					{
						switch( pathNames[ 1 ] )
						{
							case NavWorkId.ILLUSTRATIONS:
							case NavWorkId.INTERACTIVE_APP:
							case NavWorkId.WEB:
								newNavWorkId = pathNames[ 1 ];
								break;
							default:
								newNavWorkId = NavWorkId.WEB;
								needReroot = true;
								break;
						}
					}
					
					if( n > 2 )
					{
						trace( "n > 2" );
						newNavProjectId = pathNames[ 2 ];
					}
				}
				else
				{
					if( newNavSiteId == NavSiteId.WORKS )
					{
						newNavWorkId = NavWorkId.WEB;
						needReroot = true;
					}
				}
			}
			else
			{
				newNavSiteId = NavSiteId.NEWS;
				needReroot = true;
			}
			
			if( needReroot )
			{
				trace( "reroot" );
				var newPath:String = newNavSiteId;
				if( newNavWorkId != null ) newPath += "/" + newNavWorkId;
				if( newNavProjectId != null ) newPath += "/" + newNavProjectId;
				SWFAddress.setValue( newPath );			
			}
			else
			{
				trace( "apply" );
				navProjectManager.currentId = newNavProjectId;
				navWorkManager.currentId = newNavWorkId;
				navSiteManager.currentId = newNavSiteId;
			}
		}
		
		private function _showLoadingView( title:String, data:Object = null, filesToLoad:Array = null ):void
		{
			_loadingRubView = new LoadingRubView( title, data, filesToLoad );
			_loadingRubView.addEventListener( Event.COMPLETE, _loadCompleteHandler, false, 0, true );
			_mainView.setContent( _loadingRubView );
			_loadingRubView.show( _firstLoad ? 0 : .4 );
			
			_mainView.left.hide();
			_mainView.right.hide();
			
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