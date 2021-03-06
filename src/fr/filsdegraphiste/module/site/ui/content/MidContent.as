/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site.ui.content 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.ui.button.BtViewAll;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.DiaporamaElement;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.image.MidImage;
	import fr.filsdegraphiste.module.site.ui.menu.MainMenu;
	import fr.filsdegraphiste.module.site.ui.menu.WorkMenu;
	import fr.minuit4.core.navigation.modules.ModulePart;

	
	public class MidContent extends BaseContent
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cnt:Sprite;
		private var _bg:Shape;
		private var _cntContent:Sprite;
		private var _menu:MainMenu;
		private var _workMenu:WorkMenu;
		private var _btViewAll:BtViewAll;
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
			_cnt.addChild( _btViewAll = new BtViewAll( "View all" ) );
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
		
		override public function setImage(bd : BitmapData, delay:Number = 0 ) : void 
		{
			super.setImage( bd, delay );
			_cntContent.addChild( _currentImage = new MidImage( bd ) );
			_currentImage.show( delay );
		}
		
		override public function setElement( element:DiaporamaElement, delay:Number = 0 ):void
		{
			super.setElement( element, delay );
			_cntContent.addChild( _currentElement = element );
			element.mid( delay );
		}
		
		public function clearContent():void
		{
			if( _currentContent != null )
				_currentContent.hide();
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_menu.show( delay );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			if( _currentImage )
				_currentImage.hide( delay );
			
			if( _currentElement )
				_currentElement.hide( delay );
			
			return _currentContent.hide(delay);
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get workMenu() : WorkMenu 
		{
			return _workMenu;
		}

		public function get btViewAll():BtViewAll
		{
			return _btViewAll;
		}
		
	}
	
}