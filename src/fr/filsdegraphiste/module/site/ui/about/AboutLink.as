/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.about 
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import aze.motion.eaze;

	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class AboutLink extends ModulePart
	{
		private var _tf:Text;
		private var _zone:Sprite;
		private var _url:String;
		
		public function AboutLink( label:String, url:String )
		{
			addChild( _tf = new Text( label, "about_link" ) );
			addChild( _zone = new Sprite() );
			_url = url;
			
			var g:Graphics = _zone.graphics;
			g.beginFill( 0xff00ff, 0 );
			g.drawRect( 0, 0, _tf.width, 14 );
			
			_zone.buttonMode =
			_zone.useHandCursor = true;
			
			addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler, false, 0, true );
			addEventListener( MouseEvent.CLICK, _clickHandler, false, 0, true );			
		}

		private function _rollOverHandler(event : MouseEvent) : void 
		{
			addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler, false, 0, true );
			eaze( _tf ).to( .25 ).tint( 0x53cecf );
		}
 			
		private function _rollOutHandler(event : MouseEvent) : void 
		{
			removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			eaze( _tf ).to( .25 ).tint();
		}
		
		private function _clickHandler( event:MouseEvent ):void
		{
			navigateToURL( new URLRequest( ( _url.indexOf( "@" ) != -1 ? "mailto:" : "" ) + _url ), "_blank" );
		}
	}
}