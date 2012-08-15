/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.content 
{
	import fr.filsdegraphiste.module.site.ui.image.RightImage;
	import flash.display.BitmapData;
	public class RightContent extends BaseContent
	{		
		public function RightContent()
		{
			
		}

		override public function setImage(bd : BitmapData) : void 
		{
			addChild( _currentImage = new RightImage( bd ) );
			_currentImage.show();
		}

	}
}