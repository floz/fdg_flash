/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.diaporama 
{
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.filsdegraphiste.module.site.ui.button.BtNext;
	import fr.filsdegraphiste.module.site.ui.button.BtPrev;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BaseDiaporama extends ModulePart
	{
		protected var _mainView:MainView;
		
		protected var _projects:Array;
		protected var _projectsCount:int;
		
		protected var _btPrev:BtPrev;
		protected var _btNext:BtNext;
		
		protected var _currentIdx:int = -1;
		
		public function BaseDiaporama( mainView:MainView )
		{
			_mainView = mainView;
			
			addChild( _btPrev = new BtPrev() );
			addChild( _btNext = new BtNext() );	
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}
		
		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		protected function _onResize() : void 
		{
			_btPrev.y = 
			_btNext.y = _.stage.stageHeight >> 1;
			
			_btNext.x = _.stage.stageWidth;
		}
		
		protected function _updateButtons( delay:Number = 0 ):void
		{
			if( _currentIdx <= 0 )
			{
				_btPrev.hide( delay );
				_btPrev.removeEventListener( MouseEvent.CLICK, _clickHandler );
			}
			else 
			{
				_btPrev.show( delay );
				_btPrev.addEventListener( MouseEvent.CLICK, _clickHandler, false, 0, true );
			}
			
			if( _currentIdx >= _projectsCount - 1 )
			{
				_btNext.hide( delay );
				_btNext.removeEventListener( MouseEvent.CLICK, _clickHandler );
			}
			else
			{
				_btNext.show( delay );
				_btNext.addEventListener( MouseEvent.CLICK, _clickHandler, false, 0, true );	
			}
		}
		
		private function _clickHandler(event : MouseEvent) : void 
		{
			switch( event.currentTarget )
			{
				case _btPrev: prev(); break;
				case _btNext: next(); break;
			}
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
		
		protected function _showProject( fromProject:Boolean = false ):void
		{
			
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			eaze( this ).delay( delay ).onComplete( next );
			
			return .5;
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_mainView.mid.hide( delay );
			_mainView.left.hide( delay );
			_mainView.right.hide( delay );
			
			_btPrev.hide( delay );
			_btNext.hide( delay );
			
			eaze( this ).delay( .5 ).onComplete( dispose );
				
			return super.hide( delay );
		}
		
		override public function dispose():void
		{
			_btPrev.removeEventListener( MouseEvent.CLICK, _clickHandler );
			_btNext.removeEventListener( MouseEvent.CLICK, _clickHandler );
			if( parent )
				parent.removeChild( this );
		}

		public function get currentIdx():int
		{
			return _currentIdx;
		}
		
	}
}