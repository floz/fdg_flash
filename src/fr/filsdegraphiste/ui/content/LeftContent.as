/**
 * @author Floz
 */
package fr.filsdegraphiste.ui.content 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import fr.minuit4.core.navigation.modules.ModulePart;
	
	public class LeftContent extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LeftContent() 
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0x0000ff );
			g.drawRect( 0, 0, 100, 100 );
			addChild( s );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}