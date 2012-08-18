/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.details 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.Bitmap;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.BitmapData;
	public class DetailsImage extends ModulePart
	{
		private var _bd:BitmapData;
		private var _matrix:Matrix;
		private var _top:Shape;
		private var _bot:Shape;
		
		public function DetailsImage( url:String )
		{
			_bd = fdgDataLoaded.getImage( url );
			
			_matrix = new Matrix();
			_matrix.scale( 210 / _bd.width, 210 / _bd.height );
			
			addChild( _top = new Shape() );
			addChild( _bot = new Shape() );
			
			var g:Graphics = _top.graphics;
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.moveTo( 0, 0 );
			g.lineTo( 105, 105 );
			g.lineTo( 0, 210 );
			
			g = _bot.graphics;
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.moveTo( 0, 210 );
			g.lineTo( 105, 105 );
			g.lineTo( 210, 210 );
		}
	}
}