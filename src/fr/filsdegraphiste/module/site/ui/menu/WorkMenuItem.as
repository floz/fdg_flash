/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.menu 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	public class WorkMenuItem extends ModulePart 
	{
		private var _bg:Shape;
		private var _tf:Text;
		
		public function WorkMenuItem( label:String )
		{
			addChild( _bg = new Shape() );
			addChild( _tf = new Text( label, "work_menu_item" ) );
			
			_init();
			
			_tf.x = 10;
			_tf.y = ( _bg.height - _tf.height ) * .5 + 1 >> 0;
			
			this.buttonMode = 
			this.useHandCursor = true;
			
			this.mouseChildren = false;
			
			this.addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
		}
		
		private function _init():void
		{
			var dx:Number = -_.stage.stageWidth * .5;
			var dy:Number = _.stage.stageHeight;
			var a:Number = Math.atan2( dy, dx );
			
			var w:Number = Math.cos( a ) * 40;
			var h:Number = Math.sin( a ) * 40;
			
			var g:Graphics = _bg.graphics;
			g.beginFill( 0xf7f7f7 );
			g.moveTo( 0, 0 );
			g.lineTo( _tf.width + 45, 0 );
			g.lineTo( _tf.width + 45 + w, h );
			g.lineTo( w, h );
		}
		
		private function _rollOverHandler(event : MouseEvent) : void 
		{
			this.addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			eaze( _bg ).to( .4 ).tint( 0x53cecf ).easing( Expo.easeOut );
			eaze( _tf ).to( .4 ).tint( 0xffffff ).easing( Expo.easeOut );
		}

		private function _rollOutHandler(event : MouseEvent) : void 
		{
			this.removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			eaze( _bg ).to( .4 ).tint().easing( Expo.easeOut );
			eaze( _tf ).to( .4 ).tint().easing( Expo.easeOut );
		}
	}
}