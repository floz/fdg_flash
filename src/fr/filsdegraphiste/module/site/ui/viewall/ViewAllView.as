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
	import fr.filsdegraphiste.module.site.ui.button.BtClose;
	import fr.filsdegraphiste.module.site.ui.viewall.events.ViewAllEvent;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class ViewAllView extends ModulePart
	{
		private const _P:Point = new Point();
		private const _BF:BlurFilter = new BlurFilter( 10, 10, 2 );
		
		private var _mainView:MainView;
		
		private var _projects:Object;
		private var _capture:Bitmap;
		private var _captureBd:BitmapData;
		private var _halo:Shape;
		private var _cntEntries:Sprite;
		private var _entriesBg:Bitmap;
		private var _entriesRed:ViewAllProjectColor;
		private var _entriesNormal:ViewAllProjects;
		private var _entriesBlue:ViewAllProjectColor;
		private var _btClose:BtClose;
		
		private var _activated:Boolean;		
		private var _tooltip : ViewAllTooltip;
		
		private var _selectedIdx:int = -1;
		
		public function ViewAllView( mainView:MainView )
		{			
			_mainView = mainView;
			
			var m:Matrix = new Matrix();
			m.createGradientBox( 1000, 1000 );
			
			addChild( _halo = new Shape() );
			var g:Graphics = _halo.graphics;
			g.clear();
			g.beginGradientFill( GradientType.RADIAL, [ 0x000000, 0x000000 ], [ .4, .5 ], [ 75, 255 ], m );
			g.drawRect( 0, 0, 1000, 1000 );
			_halo.alpha = 0;
			
			addChild( _btClose = new BtClose() );
			_btClose.addEventListener( MouseEvent.CLICK, _closeClickHandler );
			
			addChildAt( _capture = new Bitmap( _captureBd ), 0 );
			_capture.alpha = 0;
			
			_activated = true;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
		}

		private function _closeClickHandler( event:MouseEvent ):void
		{
			hide();
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
			
			_btClose.x = _.stage.stageWidth >> 1;
			
			if( _captureBd != null )
				_captureBd.dispose();
			
			_captureBd = new BitmapData( _.stage.stageWidth, _.stage.stageHeight );
			_capture.bitmapData = _captureBd;
			_captureBd.draw( _mainView );
			_captureBd.applyFilter( _captureBd, _captureBd.rect, _P, _BF );
			
			_cntEntries.x = _.stage.stageWidth - _entriesBg.width >> 1;
			_cntEntries.y = _.stage.stageHeight - _entriesBg.height >> 1;
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
			{
				_projects = _projects[ navWorkManager.currentId ];
			}
			else
			{
				var projects:Object = {};
				for( var s:String in _projects )
				{
					if( s != "files_to_load" )
						projects[ s ] = _projects[ s ];
				}
				_projects = projects;
			}
			
			addChild( _cntEntries = new Sprite() );
			_tooltip = new ViewAllTooltip();
			_cntEntries.addChild( _entriesBg = new Bitmap() );
			_cntEntries.addChild( _entriesRed = new ViewAllProjectColor( 0xff0000, new Point( 6, -3 ) ) );
			_cntEntries.addChild( _entriesNormal = new ViewAllProjects( _projects, _tooltip ) );
			_cntEntries.addChild( _entriesBlue = new ViewAllProjectsBlue() );
			_cntEntries.addChild( _tooltip );
			_entriesBlue.blendMode = BlendMode.OVERLAY;
			_entriesRed.blendMode = BlendMode.OVERLAY;
			_entriesBg.alpha = 0;
			
			_entriesBg.bitmapData = _entriesNormal.ref;
			_entriesRed.setImage( _entriesNormal.ref );
			_entriesBlue.setImage( _entriesNormal.ref );
			
			_entriesNormal.addEventListener( Event.COMPLETE, _entriesShowCompleteHandler );
			_entriesNormal.addEventListener( ViewAllEvent.PROJECT_SELECTED, _projectSelectedHandler );
			_onResize();					
		}

		private function _entriesShowCompleteHandler( event:Event ):void
		{
			_entriesNormal.removeEventListener( Event.COMPLETE, _entriesShowCompleteHandler );
			 
			_entriesNormal.alpha = .7;
			_entriesRed.show();
			_entriesBlue.show();
			eaze( _entriesBg ).apply( { alpha: 1 } ).colorMatrix( 0, 0, -1 );
		}
		
		private function _projectSelectedHandler( event:ViewAllEvent ):void
		{
			_selectedIdx = event.idx;
			hide();
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_performTransition();
			_showProjects();
			
			_entriesNormal.show( delay );
			_btClose.show( delay + 1 );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			_entriesNormal.removeEventListener( ViewAllEvent.PROJECT_SELECTED, _projectSelectedHandler );
			
			_tooltip.hide();
			
			_btClose.removeEventListener( MouseEvent.CLICK, _closeClickHandler );			
			_btClose.hide( delay );
			
			eaze( _entriesBg ).delay( delay ).to( .2, { alpha: 0 } );
			_entriesNormal.hide( delay + .1 );
			_entriesRed.hide( delay + .25 );
			_entriesBlue.hide( delay + .25 );
			
			eaze( _halo ).delay( delay + .3 ).to( .3, { alpha: 0 } );
			eaze( _capture ).delay( delay + .3 ).to( .3, { alpha: 0 } ).onComplete( dispose );
			
			if( _selectedIdx != -1 )
			{
				eaze( this ).delay( delay + .3 ).onComplete( _selectNewProject );
			}
			
			return super.hide( delay );
		}

		private function _selectNewProject():void
		{
			_mainView.diaporama.zoomIn( _selectedIdx );
		}
		
		override public function dispose():void
		{
			parent.removeChild( this );
			_entriesNormal.dispose();
		}

	}
}