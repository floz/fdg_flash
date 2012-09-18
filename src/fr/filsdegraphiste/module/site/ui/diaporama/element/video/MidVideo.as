/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.diaporama.element.video 
{
	import flash.display.Graphics;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Shape;

	public class MidVideo extends ModulePart
	{
		private var _url:String;
		
		public function MidVideo( url:String )
		{
			_url = url;
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, 1000, 1000 );
			addChild( s );
		}
	}
}