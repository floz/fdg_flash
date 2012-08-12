/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site.ui 
{
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class GradientShadow extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const colors:Array = [ 0xffffff, 0x000000 ];
		private const alphas:Array = [ 1, 1 ];
		private const ratios:Array = [ 125, 255 ];
		
		private var _bg:Shape;
		private var _matrix:Matrix;
		
		private var _alpha0:Number;
		private var _alpha1:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GradientShadow() 
		{
			addChild( _bg = new Shape() );
			
			_alpha0 = 0;
			_alpha1 = 0;
			
			_matrix = new Matrix();
			
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
			_draw();
		}
		
		private function _startDrawing():void
		{
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
		}

		private function _enterFrameHandler(event : Event) : void 
		{
			_draw();
		}

		private function _draw() : void 
		{
			alphas[ 0 ] = _alpha0;
			alphas[ 1 ] = _alpha1;
			
			_matrix.createGradientBox( _.stage.stageWidth, _.stage.stageHeight, -Math.PI * .5 );
			
			var g:Graphics = _bg.graphics;
			g.clear();
			g.beginGradientFill( GradientType.RADIAL, colors, alphas, ratios, _matrix );
			g.drawRect( 0, 0, _.stage.stageWidth, _.stage.stageHeight );
			g.endFill();
		}
		
		private function _stopDrawing():void
		{
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			_draw();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
			
		override public function show( delay:Number = 0 ):Number
		{
			_startDrawing();
			
			eaze( this ).delay( delay )
						.to( 1, { alpha1: .1 } )
						.onComplete( _stopDrawing );
			
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return super.hide( delay );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get alpha0():Number { return _alpha0; }
		public function set alpha0( value:Number ):void
		{
			_alpha0 = value;
		}
		
		public function get alpha1():Number { return _alpha1; }
		public function set alpha1( value:Number ):void
		{
			_alpha1 = value;
		}
	}
	
}