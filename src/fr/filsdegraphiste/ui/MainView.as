/**
 * @author Floz
 */
package fr.filsdegraphiste.views.displays 
{
	import fr.filsdegraphiste.views.displays.content.LeftContent;
	import fr.filsdegraphiste.views.displays.content.MidContent;
	import fr.filsdegraphiste.views.displays.content.RightContent;
	import fr.minuit4.core.navigation.modules.ModulePart;
	
	public class MainView extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _left:LeftContent;
		private var _right:RightContent;
		private var _shadow:GradientShadow;
		private var _mid:MidContent;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainView() 
		{
			addChild( _left = new LeftContent() );
			addChild( _right = new RightContent() );
			addChild( _shadow = new GradientShadow() );
			addChild( _mid = new MidContent() );
			trace( "here" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}