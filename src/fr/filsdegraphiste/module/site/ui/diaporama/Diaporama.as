/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.diaporama 
{
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.details.DetailsView;
	
	public class Diaporama extends BaseDiaporama
	{
		private var _data:Object;
		private var _detailsView:DetailsView;
		private var _diaporamaProject:DiaporamaProject;
		
		private var _idxProject:int;		
		
		private var _zoomed:Boolean;
		
		public function Diaporama( data:Object, mainView:MainView )
		{
			_data = data;
			_projects = [];
			
			super( mainView );
			
			for( var s:String in _data )
			{
				if( s != "files_to_load" )
					_projects[ _projects.length ] = _data[ s ];
			}
		}

		override protected function _showProject() : void 
		{
			var project:Object = _projects[ _currentIdx ];
			
			var d:Number = 0;
			if( _detailsView != null )
			{
				_detailsView.hide();
				d = .2;
			}
			
			_mainView.left.setImage( fdgDataLoaded.getImage( project.images[ project.images.length - 1 ] ), d );
			_mainView.right.setImage( fdgDataLoaded.getImage( project.images[ 1 ] ), d );
			
			_detailsView = new DetailsView( project, this );
			_mainView.mid.setContent( _detailsView );
			_detailsView.show( d );
		}
		
		public function zoomIn():void
		{			
			_zoomed = true;
			
			//_mainView.left.hide();
			_mainView.mid.hide();
			//_mainView.right.hide();
			_btNext.hide();
			_btPrev.hide();
			
			_mainView.mid.workMenu.hide();
			
			_diaporamaProject = new DiaporamaProject( _projects[ _currentIdx ], _mainView );
			//_diaporamaProject.show();			
		}
		
		public function zoomOut():void
		{
			_diaporamaProject.hide();
			_zoomed = false;
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

	}
}