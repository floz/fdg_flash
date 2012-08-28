/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.details 
{
	import flash.display.Graphics;
	import fr.filsdegraphiste.module.site.ui.MaskedText;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Shape;
	
	public class DetailsViewMore extends ModulePart
	{
		private var _viewMore:MaskedText;
		private var _zone:Shape;
		
		public function DetailsViewMore()
		{
			addChild( _viewMore = new MaskedText( "+ VIEW MORE", "details_view_more" ) );
			addChild( _zone = new Shape() );
			
			var g:Graphics = _zone.graphics;
			g.beginFill( 0xff00ff, 0 );
			g.drawRect( -10, -5, _viewMore.width + 20, _viewMore.height + 10 );
			
			this.buttonMode =
			this.useHandCursor = true;
			this.mouseChildren = false;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_viewMore.show( delay );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_viewMore.hide( delay );
			return super.hide( delay );
		}
	}
}