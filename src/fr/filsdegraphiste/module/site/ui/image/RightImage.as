/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.image 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	public class RightImage extends BaseImage
	{
		public function RightImage( bd:BitmapData )
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
			g.lineTo( _w, _h );
			
			g = _bot.graphics;
			g.clear();
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.moveTo( 0, 0 );
			g.lineTo( _w, _h );
			g.lineTo( 0, _h );
		}
			
		override public function show(delay : Number = 0) : Number 
		{
			_top.x = -_w;
			_top.y = -_h;
			
			_bot.x = _w;
			_bot.y = _h;
			
			return super.show(delay);
		}
		
	}
}