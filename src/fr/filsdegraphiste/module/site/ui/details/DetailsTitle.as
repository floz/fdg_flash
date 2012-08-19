/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.details 
{
	import fr.filsdegraphiste.module.site.ui.MaskedText;
	import fr.minuit4.core.navigation.modules.ModulePart;
	public class DetailsTitle extends ModulePart
	{
		private var _title:MaskedText;
		private var _subtitle:MaskedText;
		
		public function DetailsTitle( title:String, subtitle:String )
		{
			addChild( _title = new MaskedText( title, "details_title" ) );
			addChild( _subtitle = new MaskedText( subtitle, "details_subtitle" ) );
			
			_subtitle.y = _title.y + _title.height >> 0;	
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_title.show( delay );
			_subtitle.show( delay + .1 );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_title.hide( delay );
			_subtitle.hide( delay + .1 );
			return super.hide( delay );
		}

	}
}