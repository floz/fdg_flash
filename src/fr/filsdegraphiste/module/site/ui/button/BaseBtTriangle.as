/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.button 
{
	import aze.motion.easing.Quint;
	import aze.motion.eaze;

	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BaseBtTriangle extends ModulePart
	{
		private var _cnt:Sprite;
		private var _cntOut:Sprite;
		private var _outTop:Shape;
		private var _outBot:Shape;
		private var _cntOver:Sprite;
		private var _overTop:Shape;
		private var _overBot:Shape;
		private var _zone:Sprite;
		
		private var _shown:Boolean;
		
		public function BaseBtTriangle()
		{
			addChild( _cnt = new Sprite() );
			_cnt.addChild( _cntOver = new Sprite() );
			_cnt.addChild( _cntOut = new Sprite() );
			
			_cnt.mouseChildren = false;
			_cnt.mouseEnabled = false;
			
			_cntOut.x = -100;
			_cntOver.x = -100;
			
			
			_init();
			
			addChild( _zone = new Sprite() );
			var g:Graphics = _zone.graphics;
			g.beginFill( 0xff00ff, 0 );
			g.drawRect( -2, -50, 52, 100 );
			g.endFill();
		}
		
		private function _activate():void
		{
			addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			_zone.buttonMode = 
			_zone.useHandCursor = true;
			this.mouseEnabled = true;	
		}
		
		private function _deactivate():void
		{
			removeEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_zone.buttonMode = 
			_zone.useHandCursor = false;
			this.mouseEnabled = false;
		}
		
		private function _init():void
		{
			_cntOut.addChild( _outTop = new Shape() );
			_drawTriangleTop( _outTop.graphics, 0xffffff );
			_drawIconTop( _outTop.graphics, 0x000000 );
			
			_cntOut.addChild( _outBot = new Shape() );
			_drawTriangleBot( _outBot.graphics, 0xffffff );
			_drawIconBot( _outBot.graphics, 0x000000 );
			
			_cntOver.addChild( _overTop = new Shape() );
			_drawTriangleTop( _overTop.graphics, 0x53cecf );
			_drawIconTop( _overTop.graphics, 0xffffff );
			
			_cntOver.addChild( _overBot = new Shape() );
			_drawTriangleBot( _overBot.graphics, 0x53cecf );
			_drawIconBot( _overBot.graphics, 0xffffff );
		}
		
		private function _drawTriangleTop( g:Graphics, color:uint ):void
		{
			g.clear();
			g.beginFill( color );
			g.moveTo( 0, 0 );
			g.lineTo( 0, -52 );
			g.lineTo( 52, 0 );
			g.endFill();
		}
		
		private function _drawTriangleBot( g:Graphics, color:uint ):void
		{
			g.clear();
			g.beginFill( color );
			g.moveTo( 0, 0 );
			g.lineTo( 0, 52 );
			g.lineTo( 52, 0 );
			g.endFill();
		}
		
		protected function _drawIconTop( g:Graphics, color:uint ):void
		{
			// ABSTRACT
		}
		
		protected function _drawIconBot( g:Graphics, color:uint ):void
		{
			// ABSTRACT	
		}
		
		private function _rollOverHandler( e:MouseEvent ):void
		{
			addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_over();	
		}
		
		private function _rollOutHandler( e:MouseEvent ):void
		{
			removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_out();	
		}
		
		private function _over():void
		{
			_showOver();
			_hideOut();
		}
		
		private function _out():void
		{
			_showOut();
			_hideOver();
		}
		
		private function _showOver( delay:Number = 0 ):void
		{
			_showPart( _cntOver, _overTop, _overBot, delay );	
		}
		
		private function _showOut( delay:Number = 0 ):void
		{
			_showPart( _cntOut, _outTop, _outBot, delay );
		}
		
		private function _showPart( cnt:DisplayObjectContainer, top:DisplayObject, bot:DisplayObject, delay:Number = 0 ):void
		{
			eaze( cnt ).delay( delay )
					   .to( .4, { x: 0 } ).easing( Quint.easeOut );

			eaze( top ).delay( delay )
					   .to( .4, { rotation: 0 } ).easing( Quint.easeOut );
							
			eaze( bot ).delay( delay )
				       .to( .4, { rotation: 0 } ).easing( Quint.easeOut );
		}
		
		private function _hideOver( delay:Number = 0 ):void
		{
			_hidePart( _cntOver, _overTop, _overBot, delay );
		}
		
		private function _hideOut( delay:Number = 0 ):void
		{
			_hidePart( _cntOut, _outTop, _outBot, delay );	
		}
		
		private function _hidePart( cnt:DisplayObjectContainer, top:DisplayObject, bot:DisplayObject, delay:Number = 0 ):void
		{
			eaze( top ).delay( delay )
							.to( .4, { rotation: -90 } ).easing( Quint.easeOut );
							
			eaze( bot ).delay( delay )
							.to( .4, { rotation: 90 } ).onComplete( _replacePart, cnt, top, bot ).easing( Quint.easeOut );
		}
		
		private function _replacePart( cnt:DisplayObjectContainer, top:DisplayObject, bot:DisplayObject ):void
		{
			cnt.x = -100;
			top.rotation = 0;
			bot.rotation = 0;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			if( _shown )
				return 0;
			
			_shown = true;
			_showOut( delay );
			
			_activate();	
			
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			if( !_shown )
				return 0;
			
			_shown = false;
			_hideOut( delay );
			_hideOver( delay );
			
			_deactivate();
			
			return super.hide( delay );
		}
	}
}