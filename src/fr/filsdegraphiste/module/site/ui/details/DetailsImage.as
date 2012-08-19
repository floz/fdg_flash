/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.details 
{
	import aze.motion.easing.Quadratic;
	import aze.motion.eaze;
	import flash.display.Sprite;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	public class DetailsImage extends ModulePart
	{
		private var _bd:BitmapData;
		private var _matrix:Matrix;
		private var _cnt:Sprite;
		private var _cntTop:Sprite;
		private var _top:Shape;
		private var _cntBot:Sprite;
		private var _bot:Shape;
		private var _mask:Shape;
		
		public function DetailsImage( url:String )
		{
			_bd = fdgDataLoaded.getImage( url );
			
			_matrix = new Matrix();
			_matrix.scale( 210 / _bd.width, 210 / _bd.height );
			
			addChild( _cnt = new Sprite() );
			_cnt.addChild( _cntTop = new Sprite() );
			_cntTop.addChild( _top = new Shape() );
			_cnt.addChild( _cntBot = new Sprite() );
			_cntBot.addChild( _bot = new Shape() );
			
			var g:Graphics = _top.graphics;
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.moveTo( 0, 0 );
			g.lineTo( 105, 105 );
			g.lineTo( 0, 210 );
			_top.x = -105;
			_top.y = -105;
			_cntTop.x = 105;
			_cntTop.y = 105;
			_cntTop.alpha = 0;
			
			g = _bot.graphics;
			g.beginBitmapFill( _bd, _matrix, false, true );
			g.moveTo( 0, 210 );
			g.lineTo( 105, 105 );
			g.lineTo( 210, 210 );
			_bot.x = -105;
			_bot.y = -105;
			_cntBot.x = 105;
			_cntBot.y = 105;
			_cntBot.alpha = 0;
			
			addChild( _mask = new Shape() );
			g = _mask.graphics;
			g.beginFill( 0xff00ff );
			g.moveTo( 0, 0 );
			g.lineTo( 210, 210 );
			g.lineTo( 0, 210 );
			
			_cnt.mask = _mask;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_cntTop.x = 50;
			_cntTop.y = 155;
			
			_cntBot.x = 155;
			_cntBot.y = 50;
			
			eaze( _cntTop ).delay( delay ).to( .4, { x: 105, y: 105, alpha: 1 } );
			eaze( _cntBot ).delay( delay ).to( .4, { x: 105, y: 105, alpha: 1 } );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			eaze( _cntTop ).delay( delay ).to( .4, { x: 50, y: 155, alpha: 0 } ).easing( Quadratic.easeIn );
			eaze( _cntBot ).delay( delay ).to( .4, { x: 155, y: 50, alpha: 0 } ).easing( Quadratic.easeIn );
			
			return super.hide( delay );
		}
	}
}