/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.image 
{
	import flash.display.Sprite;
	import fr.filsdegraphiste.config._;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	public class MidImage extends BaseImage
	{
		private var _cntRight:Sprite;
		
		public function MidImage( bd:BitmapData )
		{
			addChild( _cntRight = new Sprite() );
			super( bd );		
			_cntRight.addChild( _top );
		}

		override protected function _setSize() : void 
		{
			_w = _.stage.stageWidth;
			_h = _.stage.stageHeight;
			
			//_cntRight.x = _w;
		}
			
		override protected function _onDraw() : void 
		{
			var g:Graphics;
			
			g = _top.graphics;
			g.clear();
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.drawRect( 0, 0, _w >> 1, _h );
			
			g = _bot.graphics;
			g.clear();
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.drawRect( _w >> 1, 0, _w >> 1, _h );			
		}

		override public function show(delay : Number = 0) : Number 
		{
			trace( "show" );
			_top.x = 0;
			_top.y = -_h;
			
			_bot.x = 0;
			_bot.y = _h;			
			
			return super.show(delay);
		}


	}
}