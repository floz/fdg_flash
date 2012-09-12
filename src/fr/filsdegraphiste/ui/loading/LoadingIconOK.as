/**
 * @author Floz
 */
package fr.filsdegraphiste.ui.loading 
{
	import aze.motion.eaze;
	import flash.geom.Point;
	import fr.filsdegraphiste.config._;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class LoadingIconOK extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected const W:Number = 100;
		protected const H:Number = 90;
		private const TIER:Number = 1 / 3;
		
		protected var _mainShape:Shape;
		private var _percent:Number = 0;
		
		private var _p0:Point = new Point( 0, 0 );
		private var _p1:Point = new Point( W, H );
		private var _p2:Point = new Point( 0, H );
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LoadingIconOK() 
		{
			_mainShape = new Shape();
			_mainShape.x = - W >> 1;
			_mainShape.y = - H >> 1;
			addChild( _mainShape );
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}		
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function _resizeHandler(e:Event):void 
		{
			_onResize();
		}
		
		private function _enterFrameHandler(event : Event) : void 
		{
			var g:Graphics = _mainShape.graphics;
			g.clear();
			g.lineStyle( 2, 0x53cecf, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER );
			g.moveTo( _p0.x, _p0.y );
			g.lineTo( W, H );
			g.moveTo( _p1.x, _p1.y );
			g.lineTo( 0, H );
			g.moveTo( _p2.x, _p2.y );
			g.lineTo( 0, 0 );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _onResize():void 
		{
			this.x = _.stage.stageWidth >> 1;
			this.y = _.stage.stageHeight * .5 - 50 >> 0;
		}
		
		private function onPercent():void
		{
			var val:Number;
			
			var g:Graphics = _mainShape.graphics;
			g.clear();
			g.lineStyle( 2, 0x53cecf, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER );
			
			g.moveTo( 0, H );
			if ( _percent < TIER )
			{				
				val = _percent / TIER;
				g.lineTo( 0, H * ( 1 - val ) );
			}
			else 
			{
				g.lineTo( 0, 0 );
				if ( _percent < TIER * 2 )
				{
					val = _percent - TIER;
					val = val / TIER;
					g.lineTo( W * val, H * val );
				}
				else
				{
					g.lineTo( W, H );
					if ( _percent < TIER * 3 )
					{
						val = _percent - TIER * 2;
						val = val / TIER;
						g.lineTo( H * ( 1 - val ), H );
					}
					else g.lineTo( 0, H );
				}
			}
		}
		
		private function _dispose() : void 
		{
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function toto():void
		{
		}
		
		public function hide( delay:Number ):Number
		{
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			eaze( _p0 ).delay( delay ).to( .2, { x: _p1.x, y: _p1.y } );
			eaze( _p1 ).delay( delay + .2 ).to( .2, { x: _p2.x, y: _p2.y } );
			eaze( _p2 ).delay( delay + .4 ).to( .2, { x: 0, y: 0 } ).onComplete( _dispose );
			
			return 0;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get percent():Number { return _percent; }
		
		public function set percent( value:Number ):void
		{
			_percent = value;
			onPercent();
		}
		
	}
	
}
