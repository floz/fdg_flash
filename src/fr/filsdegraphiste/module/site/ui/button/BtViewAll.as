/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.button 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	public class BtViewAll extends ModulePart 
	{
		private var _label:String;
		private var _bg:Shape;
		private var _bgLinesActivated:Shape;
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
		
		private var _isActivated:Boolean;
		private var _isOver:Boolean;
		private var _shown:Boolean;
		
		private var _w:Number;
		private var _h:Number;
		
		public function BtViewAll( label:String )
		{
			_label = label;
			
			addChild( _bg = new Shape() );
			addChild( _tf = new Text( label, "work_menu_item" ) );
			addChild( _bgLinesActivated = new Shape() );
			
			_init();
			
			_tf.x = 10;
			_tf.y = ( _bg.height - _tf.height ) * .5 + 1 >> 0;
			
			this.buttonMode = 
			this.useHandCursor = true;
			
			this.mouseChildren = false;
			
			alpha = 0;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}

		private function _resizeHandler( event:Event ):void
		{
			_onResize();
		}

		private function _onResize():void
		{
			var dx:Number = -_.stage.stageWidth * .5;
			var dy:Number = _.stage.stageHeight;
			var a:Number = Math.atan2( dy, dx );
			
			this.x = int( _.stage.stageWidth - this.width + Math.cos( a ) * 150 + 30 );
			this.y = int( Math.sin( a ) * 150 ); 
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
			if( _shown )
				return 0;
			_shown = true;
			
			addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );			
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			var px:int = this.x;
			this.x += 50;
			eaze( this ).delay( delay ).to( .3, { alpha: 1, x: px } );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			if( !_shown )
				return 0;
			_shown = false;
			
			removeEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );			
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			eaze( this ).delay( delay ).to( .3, { alpha: 0 } );
			return super.hide( delay );
		}

		override public function get width() : Number 
		{
			return _bg.width;
		}

	}
}