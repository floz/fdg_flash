/**
 * @author Floz
 */
package fr.filsdegraphiste.views.displays 
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;
	
	public class GradientShadow extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const colors:Array = [ 0xffffff, 0xdcdcdc ];
		private const alphas:Array = [ 1, 1 ];
		private const ratios:Array = [ 125, 255 ];
		
		private var _bg:Shape;
		private var _matrix:Matrix;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GradientShadow() 
		{
			addChild( _bg = new Shape() );
			
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
			_matrix.createGradientBox( _.stage.stageWidth, _.stage.stageHeight, -Math.PI * .5 );
			
			var g:Graphics = _bg.graphics;
			g.clear();
			g.beginGradientFill( GradientType.RADIAL, colors, alphas, ratios, _matrix );
			g.drawRect( 0, 0, _.stage.stageWidth, _.stage.stageHeight );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}