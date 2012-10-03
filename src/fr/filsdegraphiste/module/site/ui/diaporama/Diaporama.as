/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.diaporama 
{
	import aze.motion.eaze;
	import fr.filsdegraphiste.module.site.nav.navWorkManager;
	import swfaddress.SWFAddress;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	import fr.filsdegraphiste.module.site.nav.navProjectManager;
	import fr.filsdegraphiste.module.site.nav.NavSiteId;
	import fr.filsdegraphiste.module.site.nav.navSiteManager;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.details.DetailsView;

	import flash.events.Event;
	
	public class Diaporama extends BaseDiaporama
	{
		private var _data:XML;
		private var _detailsView:DetailsView;
		private var _diaporamaProject:DiaporamaProject;
		
		private var _idxProject:int;		
		
		private var _zoomed:Boolean;
		
		public function Diaporama( data:XML, mainView:MainView )
		{
			_data = data;
			_projectsCount = _data.project.length();
			_projects = [];
			
			super( mainView );
			
			navProjectManager.addEventListener( NavEvent.NAV_CHANGE, _navChangeHandler );
		}

		private function _navChangeHandler( event:NavEvent ):void
		{
			_onNavChange();
		}

		private function _onNavChange() : void 
		{
			trace( "NAVCHANGEHANDLER ", navSiteManager.currentId, navProjectManager.currentId );
			if( navProjectManager.currentId != null )
				zoomIn( Number( navProjectManager.currentId ) );
			else
				_onDiaporamaProjectClosed();
		}

		override protected function _showProject( fromProject:Boolean = false ) : void 
		{
			var project:XML = _data.project[ _currentIdx ];
			
			var d:Number = 0;
			if( _detailsView != null )
			{
				_detailsView.hide();
				d = .2;
			}
			
			trace( fromProject, _diaporamaProject != null ? _diaporamaProject.currentIdx : -1 );
			if( !fromProject || ( fromProject && _diaporamaProject.currentIdx != 0 ) )
			{
				var images:XMLList = project.elements.element.( @type == "image" );
				_mainView.left.setImage( fdgDataLoaded.getImage( images[ images.length() - 1 ] ), d );
				
				//var sameSize:Boolean = project.images.length == project.elements.length;
				_mainView.right.setImage( fdgDataLoaded.getImage( images[ 1 ] ), d );
			}
			
			_detailsView = new DetailsView( project, this );
			_mainView.mid.setContent( _detailsView );
			_detailsView.show( d );
		}
		
		public function zoomIn( idx:int = -1 ):void
		{			
			if( idx <= -1 || idx > _projectsCount - 1 )
			{
				trace( "ZOOM IN, " + _currentIdx ); 
				var path:String = navSiteManager.currentId;
				if( navSiteManager.currentId == NavSiteId.WORKS )
					path += "/" + navWorkManager.currentId;
				if ( idx < _projectsCount - 1 ) 
					path += "/" + _currentIdx;
				trace( path );
				SWFAddress.setValue( path );
				return;
			}
			
			_zoomed = true;
			
			_mainView.mid.hide();
			_btNext.hide();
			_btPrev.hide();
			_mainView.mid.btViewAll.hide();
			_mainView.mid.workMenu.hide();
			
			if( idx != -1 && _currentIdx != idx )
			{
				_mainView.left.hide();
				_mainView.right.hide();
			}
			
			_diaporamaProject = new DiaporamaProject( _data.project[ idx == -1 ? _currentIdx : idx ], _mainView, idx == -1 || _currentIdx == idx );
			if( idx != -1 ) 
				_currentIdx = idx;
		}
		
		private function _onDiaporamaProjectClosed():void
		{
			if( !_diaporamaProject )
				return;
			
			_diaporamaProject.hide();
			
			if( navSiteManager.currentId == NavSiteId.WORKS )
				_mainView.mid.workMenu.show();
			
			_showProject( true );
			_updateButtons();
			
			_mainView.mid.btViewAll.show();
			
			_zoomed = false;
		}
		
		public function zoomOut():void
		{
			_diaporamaProject.hide();
			_zoomed = false;
		}	
		
		override public function show( delay:Number = 0 ):Number
		{
			if( navProjectManager.currentId != null )
			{
				if( Number( navProjectManager.currentId ) < _projectsCount )
				{
					eaze( this ).delay( delay ).onComplete( zoomIn, Number( navProjectManager.currentId ) );
					return delay;
				}
				else
				{
					trace( "SHOW !!! " + navProjectManager.currentId, _projectsCount );
					var path:String = navSiteManager.currentId;
					if( navSiteManager.currentId == NavSiteId.WORKS )
						path += "/" + navWorkManager.currentId;
					SWFAddress.setValue( path );
					
					_mainView.mid.btViewAll.show( delay + .1 );
					return super.show( delay );
				}
			}			
			else
			{
				_mainView.mid.btViewAll.show( delay + .1 );
				return super.show( delay );
			}
			return 0;
		}

		override public function hide(delay : Number = 0) : Number 
		{
			if( _zoomed )
			{
				zoomOut();
				return 0;
			}
			else return super.hide( delay );
		}
			
		override public function dispose():void
		{			
			trace( "DIAPORAMA DISPOSE" );
			navProjectManager.removeEventListener( NavEvent.NAV_CHANGE, _navChangeHandler );
			super.dispose();
		}

	}
}