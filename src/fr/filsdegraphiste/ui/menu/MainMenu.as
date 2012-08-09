/**
 * @author Floz
 */
package fr.filsdegraphiste.ui.menu 
{
	import assets.icons.AssetAboutIcon;
	import assets.icons.AssetLabIcon;
	import assets.icons.AssetWorksIcon;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;
	
	public class MainMenu extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _bg:Shape;
		private var _midBg:Shape;
		private var _matrix:Matrix;
		
		private var _iconWorks:AssetWorksIcon;
		private var _iconLab:AssetLabIcon;
		private var _iconAbout:AssetAboutIcon;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainMenu() 
		{
			addChild( _bg = new Shape() );
			addChild( _midBg = new Shape() );
			addChild( _iconWorks = new AssetWorksIcon() );
			addChild( _iconLab = new AssetLabIcon() );
			addChild( _iconAbout = new AssetAboutIcon() );
			
			_matrix = new Matrix();
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function _resizeHandler(e:Event):void 
		{
			_onResize();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function _onResize():void 
		{
			var g:Graphics;
			
			g = _bg.graphics;
			g.beginFill( 0x53cecf );
			g.drawRect( 0, 0, _.stage.stageWidth, 85 );
			
			var percent:Number = 85 / _.stage.stageHeight;
			var w:Number = percent * _.stage.stageWidth * .5 >> 0;
			w >>= 1;
			
			_matrix.createGradientBox( w << 1, 85, Math.PI * .5 );
			
			g = _midBg.graphics;
			g.beginGradientFill( GradientType.LINEAR, [ 0x48b3b4, 0x53cecf ], [ 1, 1 ], [ 0, 125 ], _matrix );
			g.moveTo( 0, 0 );
			g.lineTo( -w, 85 >> 1 );
			g.lineTo( 0, 85 );
			g.lineTo( w, 85 >> 1 );
			g.endFill();
			
			_midBg.x = _.stage.stageWidth >> 1;
			
			this.y = _.stage.stageHeight - 85;
			
			_iconWorks.x = _.stage.stageWidth * .5 - w - _iconWorks.width * .5 >> 0;
			_iconWorks.y = 14;
			
			_iconLab.x = _.stage.stageWidth * .5 + w >> 0;
			_iconLab.y = 10;
			
			_iconAbout.x = ( _.stage.stageWidth - _iconAbout.width ) * .5 + 5 >> 0;
			_iconAbout.y = 25;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}