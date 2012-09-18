/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.content 
{
	import flash.display.BitmapData;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.DiaporamaElement;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.image.LeftImage;

	public class LeftContent extends BaseContent
	{
		public function LeftContent()
		{
			
		}
		
		override public function setImage(bd : BitmapData, delay:Number = 0 ) : void 
		{
			super.setImage( bd, delay );
			addChild( _currentImage = new LeftImage( bd ) );
			_currentImage.show( delay );
		}
		
		override public function setElement( element:DiaporamaElement, delay:Number = 0 ):void
		{
			super.setElement( element, delay );
			addChild( _currentElement = element );
			element.left( delay );
		}
		
	}
}