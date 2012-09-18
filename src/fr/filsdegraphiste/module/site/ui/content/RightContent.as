/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.content 
{
	import flash.display.BitmapData;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.DiaporamaElement;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.image.RightImage;
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

		override public function setElement( element:DiaporamaElement, delay:Number = 0 ):void
		{
			super.setElement( element, delay );
			addChild( _currentElement = element );
			element.right( delay );
		}


	}
}