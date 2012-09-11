/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.events.MouseEvent;

	public class ViewAll extends ModulePart
	{
		private var _mainView:MainView;
		
		public function ViewAll( mainView:MainView)
		{
			_mainView = mainView;
			_mainView.mid.btViewAll.addEventListener( MouseEvent.CLICK, _clickHandler );
		}

		private function _clickHandler( event:MouseEvent ):void
		{
			var view:ViewAllView = new ViewAllView( _mainView );	
			_mainView.parent.addChildAt( view, 1 );
			view.show( .22 );
		}	
		
	}
}