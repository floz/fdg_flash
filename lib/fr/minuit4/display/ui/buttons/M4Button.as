
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.display.ui.buttons 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import fr.minuit4.text.Text;
	
	public class M4Button extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const MARGIN:int = 5;
		
		private var _label:String;
		
		private var _shape:Shape;
		private var _text:Text;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4Button( label:String ) 
		{
			_label = label;
			init();
			
			this.mouseChildren = false;
			this.buttonMode = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			initShape();
			initLabel();
			
			refresh();
		}
		
		private function initShape():void
		{
			_shape = new Shape();
			addChild( _shape );
		}
		
		private function initLabel():void
		{
			_text = new Text();
			addChild( _text );
		}
		
		private function refresh():void
		{
			refreshText();
			refreshShape();
		}
		
		private function refreshText():void
		{
			_text.text = _label;
			_text.x = MARGIN << 1;
			_text.y = MARGIN;
			_text.textColor = 0xffffff;
		}
		
		private function refreshShape():void
		{
			var g:Graphics = _shape.graphics;
			g.beginFill( 0x333333 );
			g.drawRect( 0, 0, _text.width + ( MARGIN << 2 ), _text.height + ( MARGIN << 1 ) );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get label():String { return _label; }
		
		public function set label(value:String):void 
		{
			_label = value;
			refresh();
		}
		
	}
	
}