/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import fr.minuit4.display.ui.misc.Dummy;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ViewAllEntry extends ModulePart
	{
		private const _W:int = 190;
		private const _POS:Point = new Point();
		
		private var _side:int;
		private var _data:Object;
		private var _image:Shape;
		
		public var prev:ViewAllEntry;
		public var next:ViewAllEntry;
		
		public function ViewAllEntry( side:int, data:Object )
		{
			_side = side;
			_data = data;
			
			addChild( _image = new Shape() );
			var g:Graphics = _image.graphics;
			g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
			g.moveTo( 0, 0 );
			g.lineTo( _W, _W );
			if( side == 0 )
			{
				g.lineTo( 0, _W );
			}
			else
			{
				g.lineTo( _W, 0 );
			}
		}
		
		public function getDist():Number
		{
			var dx:Number = this.mouseX - _W / 4 * ( _side == 0 ? 1 : 3 );
			var dy:Number = this.mouseY - _W * .5;
			
			return Math.sqrt( dx * dx + dy * dy );
		}
	}
}

