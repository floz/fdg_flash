
/**
 * @author Floz
 */
package fr.minuit4.debug.objects
{
	import flash.display.Graphics;
	import flash.display.Sprite;

	public class ColorSquare extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ColorSquare( color:uint, size:Number = 1000 ) 
		{
			var g:Graphics = this.graphics;
			g.beginFill( color );
			g.drawRect( -size * .5, -size * .5, size, size );
			g.endFill();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}