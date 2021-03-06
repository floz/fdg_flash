/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site.ui 
{
	import fr.filsdegraphiste.module.site.ui.diaporama.DiaporamaProject;
	import fr.filsdegraphiste.module.site.ui.diaporama.BaseDiaporama;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.nav.NavSiteId;
	import fr.filsdegraphiste.module.site.nav.navSiteManager;
	import fr.filsdegraphiste.module.site.nav.navWorkManager;
	import fr.filsdegraphiste.module.site.ui.content.LeftContent;
	import fr.filsdegraphiste.module.site.ui.content.MidContent;
	import fr.filsdegraphiste.module.site.ui.content.RightContent;
	import fr.filsdegraphiste.module.site.ui.diaporama.Diaporama;
	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.core.navigation.nav.events.NavEvent;

	import flash.events.Event;
	
	public class MainView extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _left:LeftContent;
		private var _right:RightContent;
		private var _shadow:GradientShadow;
		private var _mid:MidContent;
		
		private var _diaporama:Diaporama;
		private var _diaporamaProject:DiaporamaProject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainView() 
		{
			addChild( _left = new LeftContent() );
			addChild( _right = new RightContent() );
			addChild( _shadow = new GradientShadow() );
			addChild( _mid = new MidContent() );
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		private function _onResize() : void 
		{
			_right.x = _.stage.stageWidth >> 1;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		public function setDiaporama( data:Object ):void
		{
			clear();	
					
			addChild( _diaporama = new Diaporama( data, this ) );
			_diaporama.show();
			
			if( navSiteManager.currentId == NavSiteId.WORKS )
			{
				navWorkManager.addEventListener( NavEvent.NAV_CHANGE, _navWorkHandler );
			}
		}
		
		public function setDiaporamaProject( diaporamaProject:DiaporamaProject ):void
		{
			//clear();
			
			addChild( _diaporamaProject = diaporamaProject );
			_diaporamaProject.show();
		}

		private function _navWorkHandler(event : NavEvent) : void 
		{
			_diaporama.hide();
			addChild( _diaporama = new Diaporama( _.data.works[ navWorkManager.currentId ], this ) );
			_diaporama.show( .25 );
		}
		
		public function setContent( content:ModulePart, andClear:Boolean = true ):void
		{
			if( andClear )
				clear();
			
			_mid.setContent( content );
		}
		
		public function clear():void
		{
			navWorkManager.removeEventListener( NavEvent.NAV_CHANGE, _navWorkHandler );
			
			if( _diaporama )
			{
				_diaporama.hide();
				_diaporama = null;
			}
			else
			{
				_mid.clearContent();
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
			
		override public function show(delay : Number = 0) : Number 
		{
			_shadow.show( delay + .2 );
			_mid.show( delay + .2 );
			return super.show(delay);
		}
			
		override public function hide(delay : Number = 0) : Number 
		{
			return super.hide(delay);
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get mid() : MidContent { return _mid; }

		public function get right() : RightContent { return _right; }

		public function get left():LeftContent
		{
			return _left;
		}

		public function get diaporama():Diaporama
		{
			return _diaporama;
		}
		
	}
	
}