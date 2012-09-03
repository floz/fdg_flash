/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.diaporama 
{
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.button.BtClose;
	import fr.filsdegraphiste.module.site.ui.loading.LoadingRubView;

	import flash.events.Event;
	public class DiaporamaProject extends BaseDiaporama
	{
		private var _project:Object;
		private var _loadingView:LoadingRubView;
		private var _btClose:BtClose;
		
		private var _first:Boolean = true;
		
		public function DiaporamaProject( project:Object, mainView:MainView )
		{
			_project = project;
			_projects = _project[ "images" ];
			
			addChild( _btClose = new BtClose() );
			_btClose.x = _.stage.stageWidth >> 1;
			
			super( mainView );
						
			_loadingView = new LoadingRubView( project[ "title" ], project, _projects );
			_loadingView.addEventListener( Event.COMPLETE, _loadCompleteHandler, false, 0, true );
			_mainView.setContent( _loadingView, false );
			_loadingView.show( .4 );			
		}

		private function _loadCompleteHandler(event : Event) : void 
		{
			_loadingView.removeEventListener( Event.COMPLETE, _loadCompleteHandler );
			
			_mainView.setDiaporamaProject( this );
		}

		override protected function _showProject() : void 
		{
			_mainView.mid.setImage( fdgDataLoaded.getImage( _projects[ _correctIndex( _currentIdx ) ] ) );
			if( !_first )
			{
				_mainView.left.setImage( fdgDataLoaded.getImage( _projects[ _correctIndex( _currentIdx - 1 ) ] ) );
				_mainView.right.setImage( fdgDataLoaded.getImage( _projects[ _correctIndex( _currentIdx + 1 ) ] ) );
			} 
			_first = false;
		}
		
		private function _correctIndex( idx:int ):int
		{
			var l:int = _projects.length; 
			if( idx < 0 )
				idx = l - 1;
			else if ( idx > l - 1 )
				idx = 0;
			
			return idx;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_btClose.show( delay );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return super.hide( delay );
		}

	}
}