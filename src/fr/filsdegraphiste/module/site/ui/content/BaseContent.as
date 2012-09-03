/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.content 
{
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.ui.image.BaseImage;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.BitmapData;
	import flash.events.Event;
	
	public class BaseContent extends ModulePart
	{
		protected var _currentImage:BaseImage;
		
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
			if( _currentImage )
			{
				eaze( _currentImage ).delay( .4 ).onComplete( _currentImage.parent.removeChild, _currentImage );
			}	
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_currentImage.hide( delay );
			return super.hide( delay );
		}
		
	}
}