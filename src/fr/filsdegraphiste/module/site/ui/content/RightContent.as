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

		override public function setImage(bd : BitmapData, delay:Number = 0 ) : void 
		{
			super.setImage( bd, delay );
			addChild( _currentImage = new RightImage( bd ) );
			_currentImage.show( delay );
		}

	}
}