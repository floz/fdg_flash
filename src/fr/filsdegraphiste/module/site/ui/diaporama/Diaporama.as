/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.diaporama 
{
	import fr.filsdegraphiste.module.site.ui.details.DetailsView;
	import flash.events.MouseEvent;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.button.BtClose;
	import fr.filsdegraphiste.module.site.ui.button.BtNext;
	import fr.filsdegraphiste.module.site.ui.button.BtPrev;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.events.Event;
	
	public class Diaporama extends ModulePart
	{
		private var _data:Object;
		private var _mainView:MainView;
		private var _projects:Vector.<Object>;
		
		private var _btClose:BtClose;
		private var _btPrev:BtPrev;
		private var _btNext:BtNext;
		
		private var _currentIdx:int = -1;
		private var _idxProject:int;
		
		private var _zoomed:Boolean;
		
		public function Diaporama( data:Object, mainView:MainView )
		{
			_data = data;
			_mainView = mainView;
			_projects = new Vector.<Object>();
			for( var s:String in _data )
			{
				if( s != "files_to_load" )
					_projects[ _projects.length ] = _data[ s ];
			}
			
			addChild( _btPrev = new BtPrev() );
			addChild( _btNext = new BtNext() );
			
			_btPrev.addEventListener( MouseEvent.CLICK, _clickHandler, false, 0, true );
			_btNext.addEventListener( MouseEvent.CLICK, _clickHandler, false, 0, true );
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}

		private function _clickHandler(event : MouseEvent) : void 
		{
			switch( event.currentTarget )
			{
				case _btPrev: prev(); break;
				case _btNext: next(); break;
			}
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		private function _onResize() : void 
		{
			_btPrev.y = 
			_btNext.y = _.stage.stageHeight >> 1;
			
			_btNext.x = _.stage.stageWidth;
		}
		
		private function _updateButtons( delay:Number = 0 ):void
		{
			if( _currentIdx <= 0 )
				_btPrev.hide( delay );
			else 
				_btPrev.show( delay );
			
			if( _currentIdx >= _projects.length - 1 )
				_btNext.hide( delay );
			else
				_btNext.show( delay );	
		}
		
		public function next():void
		{
			_currentIdx++;
			_showProject();
			_updateButtons();
		}
		
		public function prev():void
		{
			_currentIdx--;
			_showProject();
			_updateButtons();
		}

		private function _showProject() : void 
		{
			var project:Object = _projects[ _currentIdx ];
			_mainView.left.setImage( fdgDataLoaded.getImage( project.images[ project.images.length - 1 ] ) );
			_mainView.right.setImage( fdgDataLoaded.getImage( project.images[ 1 ] ) );
			
			var detailsView:DetailsView = new DetailsView( project );
			_mainView.mid.setContent( detailsView );
		}
		
		public function zoomIn():void
		{
			_zoomed = true;	
		}
		
		public function zoomOut():void
		{
			
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			next();
			_updateButtons( delay );
			
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_mainView.left.hide( delay );
			_mainView.right.hide( delay );
			
			return super.hide( delay );
		}
	}
}