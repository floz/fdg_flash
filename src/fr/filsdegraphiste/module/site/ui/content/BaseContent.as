/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.content 
{
	import fr.filsdegraphiste.module.site.ui.image.BaseImage;
	import flash.display.BitmapData;
	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

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
		
		public function setImage( bd:BitmapData ):void
		{
				
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_currentImage.hide( delay );
			return super.hide( delay );
		}
		
	}
}