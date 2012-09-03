/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.button 
{
	import flash.display.Graphics;
	public class BtClose extends BaseBtTriangle 
	{
		public function BtClose()
		{
			this.rotation = 90;
		}

		override protected function _drawIconTop(g : Graphics, color : uint) : void 
		{
			g.lineStyle( 0, color );
			g.moveTo( 11, -9 );
			g.lineTo( 20, 0 );
			g.lineTo( 29, -9 );			
		}

		override protected function _drawIconBot(g : Graphics, color : uint) : void 
		{
			g.lineStyle( 0, color );
			g.moveTo( 11, 9 );
			g.lineTo( 20, 0 );
			g.lineTo( 29, 9 );			
		}


	}
}