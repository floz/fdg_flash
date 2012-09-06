/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.image 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	public class BaseImage extends ModulePart
	{
		protected var _w:Number;
		protected var _h:Number;
		protected var _top:Shape;
		protected var _bot:Shape;
		
		protected var _bd:BitmapData;
		protected var _matrix:Matrix;
		
		public function BaseImage( bd:BitmapData )
		{			
			addChild( _top = new Shape() );
			addChild( _bot = new Shape() );
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
						
			setImage( bd );
			
			this.alpha = 0;
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		private function _onResize() : void 
		{
			_setSize();
			_draw();
		}
		
		public function setImage( bd:BitmapData ):void
		{
			_bd = bd;
			_draw();
		}
		
		protected function _setSize():void
		{
			// abstract	
		}

		protected function _draw() : void 
		{
			if( _bd == null )
				return;
				
			_setMatrix();
			_onDraw();
		}
		
		protected function _setMatrix():void
		{
			_matrix = new Matrix();
			
			var rw:Number = _w / _bd.width;
			var rh:Number = _h / _bd.height;
			var s:Number = rw > rh ? rw : rh;
			var nw:Number = _bd.width * s;
			var nh:Number = _bd.height * s;
			
			var tx:Number = ( _w - nw ) * .5;
			var ty:Number = ( _h - nh ) * .5;
			
			_matrix.scale( s, s );
			_matrix.tx = tx;
			_matrix.ty = ty;
		}
		
		protected function _onDraw():void
		{
			// abstract
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			eaze( _top ).delay( delay ).to( .4, { x: 0, y: 0 } ).easing( Expo.easeOut );
			eaze( _bot ).delay( delay ).to( .4, { x: 0, y: 0 } ).easing( Expo.easeOut );
			eaze( this ).delay( delay ).to( .4, { alpha: 1 } );
			return .5;
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			eaze( this ).delay( delay ).to( .4, { alpha: 0 } );
			
			return super.hide( delay );
		}
	}
}