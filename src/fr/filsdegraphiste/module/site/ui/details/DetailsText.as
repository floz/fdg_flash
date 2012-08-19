/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.details 
{
	import fr.filsdegraphiste.module.site.ui.MaskedText;
	import fr.minuit4.core.navigation.modules.ModulePart;
	
	public class DetailsText extends ModulePart
	{
		private var _text:MaskedText;
		
		public function DetailsText( description:String )
		{
			addChild( _text = new MaskedText( description, "details_description", 280 ) );			
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_text.show( delay );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return _text.hide( delay );
		}
	}
}