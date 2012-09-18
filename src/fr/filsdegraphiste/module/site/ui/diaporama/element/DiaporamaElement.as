/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.diaporama.element 
{
	import fr.filsdegraphiste.module.site.ui.diaporama.element.video.MidVideo;
	import assets.AssetVideoScreen;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.image.LeftImage;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.image.MidImage;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.image.RightImage;
	import fr.minuit4.core.navigation.modules.ModulePart;


	public class DiaporamaElement extends ModulePart
	{
		public static const IMAGE:String = "image";
		public static const VIDEO:String = "video";
		
		private var _url:String;
		private var _type:String;
		
		private var _current:ModulePart;
		
		public function DiaporamaElement( url:String )
		{
			_url = url;	
			trace( ">> " + _url );
			_getType();
		}

		private function _getType():void
		{
			var a:Array = _url.split( "." );
			switch( a[ 2 ] )
			{
				case "jpg": _type = IMAGE; break;
				case "flv": _type = VIDEO; break;
			}
		}
		
		public function left( delay:Number = 0 ):void
		{
			_current = new LeftImage( _type == IMAGE ? fdgDataLoaded.getImage( _url ) : new AssetVideoScreen( 0, 0 ) );
			_show( delay );			
		}
		
		public function right( delay:Number = 0 ):void
		{
			_current = new RightImage( _type == IMAGE ? fdgDataLoaded.getImage( _url ) : new AssetVideoScreen( 0, 0 ) );
			_show( delay );
		}
		
		public function mid( delay:Number = 0 ):void
		{
			if( _type == IMAGE )
			{
				_current = new MidImage( fdgDataLoaded.getImage( _url ) );
			}
			else
			{
				_current = new MidVideo( _url );
			}
			_show( delay );
		}
		
		private function _show( delay:Number ):void
		{
			addChild( _current );
			_current.show( delay );
		}
			
		override public function hide( delay:Number = 0 ):Number
		{
			_current.hide( delay );
			return super.hide( delay );
		}
	}
}