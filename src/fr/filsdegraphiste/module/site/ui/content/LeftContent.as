/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.content 
{
	import fr.filsdegraphiste.module.site.ui.image.LeftImage;

	import flash.display.BitmapData;
	public class LeftContent extends BaseContent
	{
		public function LeftContent()
		{
			
		}
		
		override public function setImage(bd : BitmapData) : void 
		{
			addChild( _currentImage = new LeftImage( bd ) );
			_currentImage.show();
		}
	}
}