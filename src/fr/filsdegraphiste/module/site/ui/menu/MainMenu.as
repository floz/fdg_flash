/**
 * @author Floz
 */
package fr.filsdegraphiste.module.site.ui.menu 
{
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	import fr.filsdegraphiste.module.site.nav.NavSiteId;
	import fr.filsdegraphiste.module.site.nav.navSiteManager;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import assets.icons.AssetAboutIcon;
	import assets.icons.AssetLabIcon;
	import assets.icons.AssetWorksIcon;

	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class MainMenu extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _bgLeft:Sprite;
		private var _bgRight:Sprite;
		private var _bgMid:Sprite;
		private var _matrix:Matrix;
		
		private var _iconWorks:AssetWorksIcon;
		private var _iconLab:AssetLabIcon;
		private var _iconAbout:AssetAboutIcon;
		
		private var _iconsById:Object;
		private var _idsByTarget:Dictionary;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainMenu() 
		{
			addChild( _bgLeft = new Sprite() );
			addChild( _bgRight = new Sprite() );
			addChild( _bgMid = new Sprite() );
			addChild( _iconWorks = new AssetWorksIcon() );
			addChild( _iconLab = new AssetLabIcon() );
			addChild( _iconAbout = new AssetAboutIcon() );
			
			_bgLeft.alpha =
			_bgRight.alpha = 0;
			_bgLeft.rotation = 45;
			_bgRight.rotation = -45;
			
			_bgMid.alpha =
			_iconWorks.alpha =
			_iconLab.alpha =
			_iconAbout.alpha = 0;
			
			_iconAbout.mouseEnabled =
			_iconWorks.mouseEnabled =
			_iconLab.mouseEnabled = false;
			
			_bgLeft.buttonMode =
			_bgRight.buttonMode = 
			_bgMid.buttonMode = true;
			_bgLeft.addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			_bgRight.addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			_bgMid.addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			_bgLeft.addEventListener( MouseEvent.CLICK, _clickHandler );
			_bgRight.addEventListener( MouseEvent.CLICK, _clickHandler );
			_bgMid.addEventListener( MouseEvent.CLICK, _clickHandler );
			
			_matrix = new Matrix();
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
			
			navSiteManager.addEventListener( NavEvent.NAV_CHANGE, _navChangeHandler );
			_onNavChange();
			
			_iconsById = {};
			_iconsById[ NavSiteId.WORKS ] = _iconWorks;
			_iconsById[ NavSiteId.LAB ] = _iconLab;
			_iconsById[ NavSiteId.ABOUT ] = _iconAbout;
			
			_idsByTarget = new Dictionary();
			_idsByTarget[ _bgLeft ] = NavSiteId.WORKS;
			_idsByTarget[ _bgMid ] = NavSiteId.ABOUT;
			_idsByTarget[ _bgRight ] = NavSiteId.LAB;
		}

		private function _navChangeHandler(event : NavEvent) : void 
		{
			_onNavChange();
		}

		private function _onNavChange() : void 
		{
			for( var s:String in _iconsById )
			{
				trace( navSiteManager.currentId, s, navSiteManager.currentId == s );
				MovieClip( _iconsById[ s ] ).gotoAndStop( ( navSiteManager.currentId == s ) ? "over" : "out" );
			}
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function _resizeHandler(e:Event):void 
		{
			_onResize();
		}
		
		private function _rollOverHandler(event : MouseEvent) : void 
		{
			if( _idsByTarget[ event.currentTarget ] == navSiteManager.currentId )
				return;
				
			EventDispatcher( event.currentTarget ).addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );			
			switch( event.currentTarget )
			{
				case _bgLeft: _iconWorks.gotoAndPlay( "over" ); break;
				case _bgRight: _iconLab.gotoAndPlay( "over" ); break;
				case _bgMid: _iconAbout.gotoAndPlay( "over" ); break;
			}
		}

		private function _rollOutHandler(event : MouseEvent) : void 
		{
			EventDispatcher( event.currentTarget ).removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			
			if( _idsByTarget[ event.currentTarget ] == navSiteManager.currentId )
				return;
			
			switch( event.currentTarget )
			{
				case _bgLeft: _iconWorks.gotoAndPlay( "out" ); break;
				case _bgRight: _iconLab.gotoAndPlay( "out" ); break;
				case _bgMid: _iconAbout.gotoAndPlay( "out" ); break;
			}
		}
		
		private function _clickHandler(event : MouseEvent) : void 
		{
			switch( event.currentTarget )
			{
				case _bgLeft: navSiteManager.currentId = NavSiteId.WORKS; break;
				case _bgRight: navSiteManager.currentId = NavSiteId.LAB; break;
				case _bgMid: navSiteManager.currentId = NavSiteId.ABOUT; break;
			}		
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _onResize():void 
		{
			var g:Graphics;
			
			g = _bgLeft.graphics;
			g.clear();
			g.beginFill( 0x53cecf );
			g.drawRect( -_.stage.stageWidth >> 1, 0, _.stage.stageWidth >> 1, 85 );
			
			g = _bgRight.graphics;
			g.clear();
			g.beginFill( 0x53cecf );
			g.drawRect( 0, 0, _.stage.stageWidth >> 1, 85 );
			
			var percent:Number = 85 / _.stage.stageHeight;
			var w:Number = percent * _.stage.stageWidth * .5 >> 0;
			w >>= 1;
			
			_matrix.createGradientBox( w << 1, 85, Math.PI * .5 );
			
			g = _bgMid.graphics;
			g.clear();
			g.beginGradientFill( GradientType.LINEAR, [ 0x48b3b4, 0x53cecf ], [ 1, 1 ], [ 0, 125 ], _matrix );
			g.moveTo( 0, 0 );
			g.lineTo( -w, 85 >> 1 );
			g.lineTo( 0, 85 );
			g.lineTo( w, 85 >> 1 );
			g.endFill();
			
			_bgLeft.x = 
			_bgRight.x = _.stage.stageWidth >> 1;
			
			_bgMid.x = _.stage.stageWidth >> 1;
			
			this.y = _.stage.stageHeight - 85;
			
			_iconWorks.x = _.stage.stageWidth * .5 - w - _iconWorks.width * .5 >> 0;
			_iconWorks.y = 14;
			
			_iconLab.x = _.stage.stageWidth * .5 + w >> 0;
			_iconLab.y = 10;
			
			_iconAbout.x = ( _.stage.stageWidth - _iconAbout.width ) * .5 + 5 >> 0;
			_iconAbout.y = 25;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function show( delay:Number = 0 ):Number
		{
			eaze( _bgLeft ).delay( delay ).to( .25, { rotation: 0, alpha: 1 } ).easing( Expo.easeOut );
			eaze( _bgRight ).delay( delay + .1 ).to( .25, { rotation: 0, alpha: 1 } ).easing( Expo.easeOut );
			eaze( _bgMid ).delay( delay + .2 ).to( .4, { alpha: 1 } );
			
			_iconAbout.y -= 10;
			_iconLab.y += 10;
			_iconWorks.y += 10;
			
			eaze( _iconAbout ).delay( delay + .25 ).to( .4, { alpha: 1, y: _iconAbout.y + 10 } );
			eaze( _iconWorks ).delay( delay + .3 ).to( .4, { alpha: 1, y: _iconWorks.y - 10 } );
			eaze( _iconLab ).delay( delay + .3 ).to( .4, { alpha: 1, y: _iconLab.y - 10 } );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return super.hide( delay );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}