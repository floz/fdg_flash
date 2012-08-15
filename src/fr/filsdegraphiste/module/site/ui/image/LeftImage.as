/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.image 
{
	import flash.display.BitmapData;
	import fr.filsdegraphiste.config._;

	import flash.display.Graphics;
	public class LeftImage extends BaseImage
	{
		public function LeftImage( bd:BitmapData )
		{
			super( bd );
		}
		
		override protected function _setSize():void
		{
			_w = _.stage.stageWidth * .5;
			_h = _.stage.stageHeight;
		}
		
		override protected function _onDraw() : void 
		{
			var g:Graphics;
			
			g = _top.graphics;
			g.clear();
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.moveTo( 0, 0 );
			g.lineTo( _w, 0 );
			g.lineTo( 0, _h );
			
			g = _bot.graphics;
			g.clear();
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.moveTo( 0, _h );
			g.lineTo( _w, _h );
			g.lineTo( _h, 0 );
			
			_top.x = _w;
			_top.y = -_h;
			
			_bot.x = -_w;
			_bot.y = _h;
		}
	}
}