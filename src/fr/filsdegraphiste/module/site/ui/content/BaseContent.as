/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.content 
{
	import aze.motion.eaze;
	import flash.display.BitmapData;
	import flash.events.Event;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.DiaporamaElement;
	import fr.filsdegraphiste.module.site.ui.diaporama.element.image.BaseImage;
	import fr.minuit4.core.navigation.modules.ModulePart;


	
	public class BaseContent extends ModulePart
	{
		protected var _currentImage:BaseImage;
		protected var _currentElement:DiaporamaElement;
		
		public function BaseContent()
		{			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();			
		}

		private function _resizeHandler(event : Event) : void 
		{
		}

		private function _onResize() : void 
		{
		}
		
		public function setImage( bd:BitmapData, delay:Number = 0 ):void
		{
			_clear( delay );				
		}
		
		public function setElement( element:DiaporamaElement, delay:Number = 0 ):void
		{
			_clear( delay );
		}

		private function _clear( delay ):void
		{
			if( _currentImage )
			{
				eaze( _currentImage ).delay( delay + .4 ).onComplete( _currentImage.parent.removeChild, _currentImage );
				_currentImage = null;
			}
			
			if( _currentElement )
			{
				eaze( _currentElement ).delay( delay + .4 ).onComplete( _currentElement.parent.removeChild, _currentElement );
				_currentElement = null;
			}
		}	
		
		override public function hide( delay:Number = 0 ):Number
		{
			if( _currentImage == null )
				return 0;
			
			_currentImage.hide( delay );
			return super.hide( delay );
		}
		
	}
}