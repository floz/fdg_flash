/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site.ui.content 
{
	import fr.filsdegraphiste.module.site.ui.menu.WorkMenu;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.ui.menu.MainMenu;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MidContent extends BaseContent
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cnt:Sprite;
		private var _bg:Shape;
		private var _cntContent:Sprite;
		private var _menu:MainMenu;
		private var _workMenu:WorkMenu;
		private var _mask:Shape;
		
		private var _currentContent:ModulePart;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MidContent() 
		{
			addChild( _cnt = new Sprite() );
			_cnt.addChild( _bg = new Shape() );
			_cnt.addChild( _cntContent = new Sprite() );
			_cnt.addChild( _menu = new MainMenu() );
			_cnt.addChild( _workMenu = new WorkMenu() );
			addChild( _mask = new Shape() );
			
			_cnt.mask = _mask;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}		
		
		// - EVENTS HANDLERS -------------------------------------------------------------

		private function _resizeHandler(e:Event):void 
		{
			_onResize();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _onResize():void
		{
			var g:Graphics;
			
			g = _bg.graphics;
			g.clear();
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, _.stage.stageWidth, _.stage.stageHeight );
			
			g = _mask.graphics;
			g.clear();
			g.beginFill( 0xff00ff );
			g.moveTo( 0, 0 );
			g.lineTo( _.stage.stageWidth, 0 );
			g.lineTo( _.stage.stageWidth >> 1, _.stage.stageHeight );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setContent( content:ModulePart ):void
		{
			_currentContent = content;
			_cntContent.addChild( content );			
		}
		
		public function clearContent():void
		{
			if( _currentContent != null )
				_currentContent.hide();
			//while( _cntContent.numChildren )
				//_cntContent.removeChildAt( 0 );
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_menu.show( delay );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return _currentContent.hide( delay );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}