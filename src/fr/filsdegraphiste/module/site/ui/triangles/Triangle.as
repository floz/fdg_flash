/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site.ui.triangles 
{
	import fr.filsdegraphiste.config._;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Triangle extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var background:Shape;
		protected var container:Sprite;
		protected var msk:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Triangle() 
		{
			addChild( background = new Shape() );
			addChild( container = new Sprite() );
			addChild( msk = new Shape() );
			
			container.mask = msk;
			
			_.stage.addEventListener( Event.RESIZE, resizeHandler );
			onResize();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function resizeHandler( e:Event ):void
		{
			onResize();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function onResize():void
		{
			updateBackground();
			updateMask();
		}
		
		protected function updateBackground():void
		{
			
		}
		
		protected function updateMask():void
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}