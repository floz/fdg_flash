/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import flash.display.GradientType;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	public class ViewAllProjectsBlue extends ViewAllProjectColor
	{
		public function ViewAllProjectsBlue()
		{
			super( 0x31dbff, new Point( -24, 12 ) );
		}

		override public function setImage( bd:BitmapData ):void
		{
			super.setImage( bd );
			
			var msk:Shape = new Shape();
			_cnt.addChild( msk );
			
			var m:Matrix = new Matrix();
			m.createGradientBox( _image.width, _image.height, -Math.PI * .5 );
			var g:Graphics = msk.graphics;					
			g.beginGradientFill( GradientType.LINEAR, [ 0xff00ff, 0xff00ff ], [ 1, 0 ], [ 0, 175 ], m );
			g.drawRect( 0, 0, _image.width, _image.height );
			
			_image.cacheAsBitmap = 
			msk.cacheAsBitmap = true;
			_image.mask = msk;
		}

	}
}

