/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.details 
{
	import flash.events.MouseEvent;
	import fr.filsdegraphiste.module.site.ui.MaskedText;
	import fr.filsdegraphiste.module.site.ui.diaporama.Diaporama;
	import fr.filsdegraphiste.utils.UText;
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
		private var _diaporama:Diaporama;
		private var _image:DetailsImage;
		private var _title:DetailsTitle;
		private var _separator:Shape;
		private var _text:DetailsText;
		private var _viewMore:DetailsViewMore;
		
		public function DetailsView( project:Object, diaporama:Diaporama )
		{
			_project = project;
			_diaporama = diaporama;
			
			addChild( _image = new DetailsImage( project[ "preview" ] ) );
			addChild( _title = new DetailsTitle( UText.htmlEntityDecode( project[ "title" ] ), UText.htmlEntityDecode( project[ "subtitle" ] ) ) );
			addChild( _separator = new Shape() );
			addChild( _text = new DetailsText( UText.htmlEntityDecode( project[ "description" ] ) ) );
			addChild( _viewMore = new DetailsViewMore() );
			
			_init();
			
			_image.x = 35;
			_title.y = _image.y + _image.height + 30 >> 0;
			_separator.y = _title.y + _title.height + 10 >> 0;
			_separator.alpha = 0;
			_text.y = _separator.y + _separator.height + 10 >> 0;
			_viewMore.y = _text.y + _text.height + 25 >> 0;
			
			_viewMore.addEventListener( MouseEvent.CLICK, _clickHandler );
			
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
		
		private function _clickHandler(event : MouseEvent) : void 
		{
			_diaporama.zoomIn();
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		private function _onResize() : void 
		{
			this.x = _.stage.stageWidth - 280 >> 1;
			this.y = ( _.stage.stageHeight - this.height ) * .5 - 200 >> 0;
			if( this.y < 40 ) this.y = 40;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_image.show( delay );
			_title.show( delay + .1 );
			eaze( _separator ).delay( delay + .2 ).to( .4, { alpha: 1, scaleX: 1 } );
			_text.show( delay + .3 );
			_viewMore.show( delay + .4 );
			
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_image.hide( delay );
			_title.hide( delay + .1 );
			eaze( _separator ).delay( delay + .2 ).to( .4, { alpha: 0, scaleX: .6 } );
			eaze( this ).delay( _text.hide( delay + .3 ) ).onComplete( _clear );
			_viewMore.hide( delay + .4 );
			
			return super.hide( delay );
		}

		private function _clear() : void 
		{
			if( parent == null )
				return;
			
			parent.removeChild( this );
		}
	}
}