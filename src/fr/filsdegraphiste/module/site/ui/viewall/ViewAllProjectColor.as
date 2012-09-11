/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class ViewAllProjectColor extends ModulePart
	{
		protected var _color:uint;
		protected var _decalage:Point;
		protected var _cnt:Sprite;
		protected var _image:Bitmap;
		protected var _msk:Shape;
		
		public function ViewAllProjectColor( color:uint, decalage:Point )
		{
			_color = color;
			_decalage = decalage;
			
			addChild( _cnt = new Sprite() );
			_cnt.alpha = 0;
			_cnt.addChild( _image = new Bitmap() );
			addChild( _msk = new Shape() );
			
			var m:Matrix = new Matrix();
			m.createGradientBox( 600, 600, 0, -300, -300 );
			
			var g:Graphics = _msk.graphics;
			g.beginGradientFill( GradientType.RADIAL, [ 0xff00ff, 0xff00ff ], [ 1, 0 ], [ 0, 255 ], m );
			g.drawCircle( 0, 0, 600 );
			
			_cnt.cacheAsBitmap =
			_msk.cacheAsBitmap = true;
			_cnt.mask = _msk;
			
			this.x = _decalage.x;
			this.y = _decalage.y;
			
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			this.mouseChildren =
			this.mouseEnabled = false;
		}

		private function _enterFrameHandler( event:Event ):void
		{
			_msk.x = this.mouseX + _decalage.x;
			_msk.y = this.mouseY + _decalage.y;
		}
		
		public function setImage( bd:BitmapData ):void
		{
			_image.bitmapData = bd;
			eaze( _image ).apply().tint( _color, .75 );
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			eaze( _cnt ).delay( delay ).to( .4, { alpha: 1 } );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler )
			eaze( _cnt ).delay( delay ).to( .4, { alpha: 0 } );
			return super.hide( delay );
		}
	}
}

