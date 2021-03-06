/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.diaporama 
{
	import fr.filsdegraphiste.module.site.ui.diaporama.element.DiaporamaElement;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.button.BtClose;
	import fr.filsdegraphiste.module.site.ui.loading.LoadingRubView;

	import flash.events.Event;
	import flash.events.MouseEvent;
	public class DiaporamaProject extends BaseDiaporama
	{
		private var _project:Object;
		private var _loadingView:LoadingRubView;
		private var _sameProject:Boolean;
		private var _btClose:BtClose;
		
		private var _first:Boolean = true;
		
		public function DiaporamaProject( project:Object, mainView:MainView, sameProject:Boolean )
		{
			_project = project;
			_projects = _project[ "elements" ];
			
			_sameProject = sameProject;
			
			addChild( _btClose = new BtClose() );
			_btClose.addEventListener( MouseEvent.CLICK, _clickHandler );			
			
			super( mainView );
						
			_loadingView = new LoadingRubView( project[ "title" ], project, _project[ "images" ] );
			_loadingView.addEventListener( Event.COMPLETE, _loadCompleteHandler, false, 0, true );
			_mainView.setContent( _loadingView, false );
			_loadingView.show( .4 );			
		}
		
		private function _clickHandler( e:MouseEvent ):void
		{
			_btClose.removeEventListener( MouseEvent.CLICK, _clickHandler );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
			
		override protected function _onResize():void
		{
			_btClose.x = _.stage.stageWidth >> 1;
			super._onResize();
		}

		private function _loadCompleteHandler(event : Event) : void 
		{
			_loadingView.removeEventListener( Event.COMPLETE, _loadCompleteHandler );
			
			_mainView.setDiaporamaProject( this );
		}

		override protected function _showProject( fromProject:Boolean = false ) : void 
		{			
			trace( "///////")
			for( var i:int; i < _projects.length; i++ )
				trace( i + " : " + _projects[ i ] );
			_mainView.mid.setElement( new DiaporamaElement( _projects[ _correctIndex( _currentIdx ) ] ) );
			if( !_first || !_sameProject )
			{
				_mainView.left.setElement( new DiaporamaElement( _projects[ _correctIndex( _currentIdx - 1 ) ] ) );
				_mainView.right.setElement( new DiaporamaElement( _projects[ _correctIndex( _currentIdx + 1 ) ] ) );
			} 
			_first = false;
			
			/*_mainView.mid.setImage( fdgDataLoaded.getImage( _projects[ _correctIndex( _currentIdx ) ] ) );
			if( !_first || !_sameProject )
			{
				_mainView.left.setImage( fdgDataLoaded.getImage( _projects[ _correctIndex( _currentIdx - 1 ) ] ) );
				_mainView.right.setImage( fdgDataLoaded.getImage( _projects[ _correctIndex( _currentIdx + 1 ) ] ) );
			} 
			_first = false;
			 * */
		}
		
		private function _correctIndex( idx:int ):int
		{
			var l:int = _projects.length;
			trace( "==" ); 
			trace( idx, l );
			if( idx < 0 )
				idx = l - 1;
			else if ( idx > l - 1 )
				idx = 0;
			trace( idx, l );
			return idx;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_btClose.show( delay );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_mainView.mid.hide( delay );
			//_mainView.left.hide( delay );
			//_mainView.right.hide( delay );
			
			_btPrev.hide( delay );
			_btNext.hide( delay );
			_btClose.hide( delay );
			
			eaze( this ).delay( .5 ).onComplete( dispose );
			
			return .5;
		}

		override public function dispose():void
		{
			_btClose.removeEventListener( MouseEvent.CLICK, _clickHandler );
			super.dispose();
		}


	}
}