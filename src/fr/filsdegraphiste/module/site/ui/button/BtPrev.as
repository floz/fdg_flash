/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.button 
{
	import flash.display.Graphics;
	public class BtPrev extends BaseBtTriangle
	{
		public function BtPrev()
		{
			
		}
		
		override protected function _drawIconTop( g:Graphics, color:uint ) : void 
		{
			g.lineStyle( 0, color );
			g.moveTo( 10, 0 );
			g.lineTo( 22, -15 );
			g.endFill();
			
		}
		
		override protected function _drawIconBot( g:Graphics, color:uint ) : void 
		{
			g.lineStyle( 0, color );
			g.moveTo( 10, 0 );
			g.lineTo( 22, 15 );
			g.endFill();
		}
	}
}