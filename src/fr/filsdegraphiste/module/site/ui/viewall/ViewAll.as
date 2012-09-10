/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.nav.NavSiteId;
	import fr.filsdegraphiste.module.site.nav.navSiteManager;
	import fr.filsdegraphiste.module.site.nav.navWorkManager;
	import fr.filsdegraphiste.module.site.ui.MainView;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class ViewAll extends ModulePart
	{
		private const _P:Point = new Point();
		private const _BF:BlurFilter = new BlurFilter( 10, 10, 2 );
		
		private var _mainView:MainView;
		
		private var _projects:Object;
		private var _capture:Bitmap;
		private var _captureBd:BitmapData;
		private var _halo:Shape;
		private var _entriesBg:Bitmap;
		private var _entriesRed:ViewAllProjectColor;
		private var _entriesNormal:ViewAllProjects;
		private var _entriesBlue:ViewAllProjectColor;
		
		private var _activated:Boolean;		
		
		public function ViewAll( mainView:MainView)
		{
			_mainView = mainView;
			_mainView.mid.btViewAll.addEventListener( MouseEvent.CLICK, _clickHandler );
			
			var m:Matrix = new Matrix();
			m.createGradientBox( 1000, 1000 );
			
			addChild( _halo = new Shape() );
			var g:Graphics = _halo.graphics;
			g.clear();
			g.beginGradientFill( GradientType.RADIAL, [ 0x000000, 0x000000 ], [ .2, .5 ], [ 75, 255 ], m );
			g.drawRect( 0, 0, 1000, 1000 );
			_halo.alpha = 0;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
		}

		private function _resizeHandler( event:Event ):void
		{
			if( _activated )
				_onResize();
		}
		
		private function _onResize():void
		{
			_halo.width = _.stage.stageWidth;
			_halo.height = _.stage.stageHeight;
			
			if( _captureBd != null )
				_captureBd.dispose();
			
			_captureBd = new BitmapData( _.stage.stageWidth, _.stage.stageHeight );
			_capture.bitmapData = _captureBd;
			_captureBd.draw( _mainView );
			_captureBd.applyFilter( _captureBd, _captureBd.rect, _P, _BF );
			
			_entriesBg.x = _.stage.stageWidth - _entriesBg.width >> 1;
			_entriesBg.y = _.stage.stageHeight - _entriesBg.height >> 1;
		}

		private function _clickHandler( event:MouseEvent ):void
		{
			_mainView.parent.addChildAt( this, 1 );
			
			addChildAt( _capture = new Bitmap( _captureBd ), 0 );
			_capture.alpha = 0;
			
			_activated = true;
			
			_performTransition();
			_showProjects();
			
			_onResize();
			
			show();
		}

		private function _performTransition():void
		{
			eaze( _halo ).to( .4, { alpha: 1 } );
			eaze( _capture ).delay( .2 ).to( .4, { alpha: 1 } );
		}
		
		private function _showProjects():void
		{
			_projects = _.data.projects[ navSiteManager.currentId ];
			if( navSiteManager.currentId == NavSiteId.WORKS )
				_projects = _projects[ navWorkManager.currentId ];
			
			addChild( _entriesBg = new Bitmap() );
			addChild( _entriesRed = new ViewAllProjectColor( 0xff0000, new Point( 6, -3 ) ) );
			addChild( _entriesNormal = new ViewAllProjects( _projects ) );
			addChild( _entriesBlue = new ViewAllProjectsBlue() );
			_entriesBlue.blendMode = BlendMode.OVERLAY;
			//_entriesNormal.alpha = .7;
			removeChild( _entriesBg );
			removeChild( _entriesRed );
			removeChild( _entriesBlue );
			_entriesRed.alpha = .7;
			
			var bd:BitmapData = new BitmapData( _entriesNormal.width, _entriesNormal.height, true, 0x00 );
			bd.draw( _entriesNormal );
			
			_entriesBg.bitmapData = bd;
			_entriesRed.setImage( bd );
			_entriesBlue.setImage( bd );					
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_entriesNormal.show( delay );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return super.hide( delay );
		}		
		
	}
}