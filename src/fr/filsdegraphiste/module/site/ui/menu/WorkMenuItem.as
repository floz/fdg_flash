/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.menu 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.nav.navWorkManager;
	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	import fr.minuit4.text.Text;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	public class WorkMenuItem extends ModulePart 
	{
		private var _label:String;
		private var _bg:Shape;
		private var _bgLinesActivated:Shape;
		private var _cntActivatedTop:Sprite;
		private var _bgActivatedTop:Shape;
		private var _tfActivatedTop:Text;
		private var _cntActivatedBot:Sprite;
		private var _bgActivatedBot:Shape;
		private var _tfActivatedBot:Text;
		private var _mskPartLeft:Shape;
		private var _mskPartRight:Shape;
		private var _tf:Text;
		
		private var _geom:Vector.<Point>;
		private var _lineLeftBase:Point = new Point();
		private var _lineLeft:Point = new Point();
		private var _lineTopBase:Point = new Point();
		private var _lineTop:Point = new Point();
		private var _lineRightBase:Point = new Point();
		private var _lineRight:Point = new Point();		
		private var _lineBotBase:Point = new Point();
		private var _lineBot:Point = new Point();
		private var _percents:Point = new Point();
		
		private var _isActivated:Boolean;
		private var _isOver:Boolean;
		
		private var _w:Number;
		private var _h:Number;
		
		public function WorkMenuItem( label:String )
		{
			_label = label;
			
			addChild( _bg = new Shape() );
			addChild( _tf = new Text( label, "work_menu_item" ) );
			addChild( _bgLinesActivated = new Shape() );
			addChild( _cntActivatedTop = new Sprite() );
			_cntActivatedTop.addChild( _bgActivatedTop = new Shape() );
			_cntActivatedTop.addChild( _tfActivatedTop = new Text( label, "work_menu_item_activated" ) );
			addChild( _cntActivatedBot = new Sprite() );
			_cntActivatedBot.addChild( _bgActivatedBot = new Shape() );
			_cntActivatedBot.addChild( _tfActivatedBot = new Text( label, "work_menu_item_activated" ) );
			addChild( _mskPartLeft = new Shape() );
			addChild( _mskPartRight = new Shape() );
			
			_init();
			
			_tf.x = 10;
			_tf.y = ( _bg.height - _tf.height ) * .5 + 1 >> 0;
			_tfActivatedTop.x = 
			_tfActivatedBot.x = _tf.x;
			_tfActivatedTop.y = 
			_tfActivatedBot.y = _tf.y;
			
			this.buttonMode = 
			this.useHandCursor = true;
			
			this.mouseChildren = false;
			
			addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			addEventListener( MouseEvent.CLICK, _clickHandler );
			
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			navWorkManager.addEventListener( NavEvent.NAV_CHANGE, _navChangeHandler );
			_onActivate();
			
			alpha = 0;
		}

		private function _clickHandler(event : MouseEvent) : void 
		{
			navWorkManager.currentId = _label;
		}

		private function _navChangeHandler(event : NavEvent) : void 
		{				
			_onActivate();		
		}

		private function _onActivate() : void 
		{
			var activatedStatus:Boolean = navWorkManager.currentId == _label;
			trace( activatedStatus );
			if( activatedStatus == _isActivated )
				return;	
			
			_isActivated = activatedStatus;
			
			if( _isActivated )
			{
				_activate();
			}
			else
			{
				_deactivate();
			}			
		}

		private function _activate() : void 
		{
			_mskPartLeft.rotation = 45;
			_mskPartRight.rotation = -45;
			
			_mskPartLeft.alpha = 0;
			_mskPartRight.alpha = 0;
			
			eaze( _mskPartLeft ).to( .25, { rotation: 0, alpha: 1 } ).easing( Expo.easeOut );
			eaze( _mskPartRight ).delay( .1 ).to( .25, { rotation: 0, alpha: 1 } ).easing( Expo.easeOut );
		}

		private function _deactivate() : void 
		{
			eaze( _mskPartLeft ).to( .25, { rotation: -45, alpha: 0 } ).easing( Expo.easeIn );
			eaze( _mskPartRight ).delay( .1 ).to( .25, { rotation: 45, alpha: 0 } ).easing( Expo.easeIn );
		}

		private function _enterFrameHandler(event : Event) : void 
		{
			var g:Graphics = _bgLinesActivated.graphics;
			g.clear();
			g.lineStyle( 1, 0x53cecf, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.BEVEL );
			
			g.moveTo( _lineTopBase.x, _lineTopBase.y );
			g.lineTo( _lineTop.x, _lineTop.y );
			
			g.moveTo( _lineBotBase.x, _lineBotBase.y );
			g.lineTo( _lineBot.x, _lineBot.y );
			
			g.moveTo( _lineLeftBase.x, _lineLeftBase.y );
			g.lineTo( _lineLeft.x, _lineLeft.y );
			
			g.lineStyle( 1.5, 0x53cecf, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.BEVEL );
			g.moveTo( _lineRightBase.x, _lineRightBase.y );
			g.lineTo( _lineRight.x, _lineRight.y );	
		}
		
		private function _over():void
		{			
			_isOver = true;
						
			_lineLeftBase.x =
			_lineLeft.x = _geom[ 3 ].x;
			_lineLeftBase.y =  
			_lineLeft.y = _geom[ 3 ].y;
			eaze( _lineLeft ).to( .2, { x: _geom[ 0 ].x, y: _geom[ 0 ].y } ).easing( Expo.easeOut );
			eaze( _lineLeftBase ).delay( .15 ).to( .2, { x: _geom[ 0 ].x, y: _geom[ 0 ].y } ).easing( Expo.easeOut );
			
			_lineTopBase.x =
			_lineTop.x = _geom[ 0 ].x;
			_lineTopBase.y =  
			_lineTop.y = _geom[ 0 ].y;
			eaze( _lineTop ).delay( .2 ).to( .2, { x: _geom[ 1 ].x, y: _geom[ 1 ].y } ).easing( Expo.easeOut );
			eaze( _lineTopBase ).delay( .35 ).to( .2, { x: _geom[ 1 ].x, y: _geom[ 1 ].y } ).easing( Expo.easeOut );
			
			//
			
			_lineRightBase.x =
			_lineRight.x = _geom[ 1 ].x;
			_lineRightBase.y =  
			_lineRight.y = _geom[ 1 ].y;
			eaze( _lineRight ).delay( .05 ).to( .2, { x: _geom[ 2 ].x, y: _geom[ 2 ].y } ).easing( Expo.easeOut );
			eaze( _lineRightBase ).delay( .2 ).to( .2, { x: _geom[ 2 ].x, y: _geom[ 2 ].y } ).easing( Expo.easeOut );
			
			_lineBotBase.x = 
			_lineBot.x = _geom[ 2 ].x;
			_lineBotBase.y =  
			_lineBot.y = _geom[ 2 ].y;
			eaze( _lineBot ).delay( .25 ).to( .2, { x: _geom[ 3 ].x, y: _geom[ 3 ].y } ).easing( Expo.easeOut );
			eaze( _lineBotBase ).delay( .4 ).to( .2, { x: _geom[ 3 ].x, y: _geom[ 3 ].y } ).easing( Expo.easeOut );
		}
		
		private function _out():void
		{
			_isOver = false;
		}
		
		private function _init():void
		{
			var dx:Number = -_.stage.stageWidth * .5;
			var dy:Number = _.stage.stageHeight;
			var a:Number = Math.atan2( dy, dx );
			
			_w = Math.cos( a ) * 40 >> 0;
			_h = Math.sin( a ) * 40 >> 0;
			
			_geom = Vector.<Point>( [ new Point( 0, 0 ), new Point( _tf.width + 45 >> 0, 0 ),
									  new Point( _tf.width + 45 + _w >> 0, _h ), new Point( _w, _h ) ] );
			
			var g:Graphics = _bg.graphics;
			g.beginFill( 0xf7f7f7 );
			g.moveTo( _geom[ 0 ].x, _geom[ 0 ].y );
			g.lineTo( _geom[ 1 ].x, _geom[ 1 ].y );
			g.lineTo( _geom[ 2 ].x, _geom[ 2 ].y );
			g.lineTo( _geom[ 3 ].x, _geom[ 3 ].y );
			
			g = _bgActivatedTop.graphics;
			g.beginFill( 0x53cecf );
			g.moveTo( _geom[ 0 ].x, _geom[ 0 ].y );
			g.lineTo( _geom[ 1 ].x, _geom[ 1 ].y );
			g.lineTo( _geom[ 2 ].x, _geom[ 2 ].y );
			g.lineTo( _geom[ 3 ].x, _geom[ 3 ].y );
			
			g = _bgActivatedBot.graphics;
			g.beginFill( 0x53cecf );
			g.moveTo( _geom[ 0 ].x, _geom[ 0 ].y );
			g.lineTo( _geom[ 1 ].x, _geom[ 1 ].y );
			g.lineTo( _geom[ 2 ].x, _geom[ 2 ].y );
			g.lineTo( _geom[ 3 ].x, _geom[ 3 ].y );
			
			_generateMasks();
			_cntActivatedTop.cacheAsBitmap = 
			_mskPartLeft.cacheAsBitmap = true;
			_cntActivatedTop.mask = _mskPartLeft;
			
			_cntActivatedBot.cacheAsBitmap = 
			_mskPartRight.cacheAsBitmap = true;
			_cntActivatedBot.mask = _mskPartRight;
		}

		private function _generateMasks() : void 
		{
			var g:Graphics = _mskPartLeft.graphics;
			g.clear();
			g.beginFill( 0x00ff00 );
			g.moveTo( 0, 0 );
			g.lineTo( -_bg.width + 1, 0 );
			g.lineTo( -_bg.width + 1, _bg.height + 1 );			
			
			g = _mskPartRight.graphics;
			g.clear();
			g.beginFill( 0x0000ff );
			g.moveTo( 0, 0 );
			g.lineTo( _bg.width + 1, 0 );
			g.lineTo( _bg.width + 1, -_bg.height - 1 );
			
			_mskPartLeft.x = _bg.width + _w;				
			_mskPartRight.x =  _w;
			_mskPartRight.y = _bg.height;
			
			_mskPartLeft.rotation = 45;
			_mskPartRight.rotation = 45;
			
			_mskPartLeft.alpha = 0;
			_mskPartRight.alpha = 0;	
		}
		
		private function _rollOverHandler(event : MouseEvent) : void 
		{
			if( _isActivated )
				return;
				
			this.addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_over();
		}

		private function _rollOutHandler(event : MouseEvent) : void 
		{
			this.removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			
			if( _isActivated )
				return;
			
			_out();
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			var px:int = this.x;
			this.x += 50;
			eaze( this ).delay( delay ).to( .3, { alpha: 1, x: px } );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			eaze( this ).delay( delay ).to( .3, { alpha: 0 } );
			return super.hide( delay );
		}

		override public function get width() : Number 
		{
			return _bg.width;
		}

	}
}