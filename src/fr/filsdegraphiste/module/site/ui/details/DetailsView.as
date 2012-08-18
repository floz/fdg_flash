/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.details 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	
	public class DetailsView extends ModulePart
	{
		private var _project:Object;
		private var _image:DetailsImage;
		private var _title:DetailsTitle;
		private var _separator:Shape;
		private var _text:DetailsText;
		
		public function DetailsView( project:Object )
		{
			_project = project;
			
			addChild( _image = new DetailsImage( project[ "preview" ] ) );
			addChild( _title = new DetailsTitle( project[ "title" ], project[ "subtitle" ] ) );
			addChild( _separator = new Shape() );
			addChild( _text = new DetailsText( project[ "description" ] ) );
			
			_init();
			
			_title.y = _image.y + _image.height + 10 >> 0;
			_separator.y = _title.y + _title.height + 10 >> 0;
			_text.y = _separator.y + _separator.height + 10 >> 0;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}
		
		private function _init():void
		{
			var g:Graphics = _separator.graphics;
			g.lineStyle( 0, 0x5f5f5f, .2 );
			g.moveTo( 0, 0 );
			g.lineTo( 280, 0 );
			
			_separator.scaleX = .4;
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		private function _onResize() : void 
		{
			this.x = _.stage.stageWidth - 280 >> 1;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			eaze( _separator ).delay( delay ).to( .4, { scaleX: 1 } ).easing( Expo.easeOut );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return super.hide( delay );
		}
	}
}