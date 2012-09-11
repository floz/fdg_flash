/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import fr.filsdegraphiste.module.site.ui.viewall.events.ViewAllEvent;
	import aze.motion.easing.Back;
	import flash.events.MouseEvent;
	import aze.motion.easing.Cubic;
	import aze.motion.easing.Expo;
	import aze.motion.easing.Quadratic;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ViewAllEntry extends ModulePart
	{
		public static const W:int = 190;
		
		private var _side:int;
		private var _data:Object;
		private var _idx:int;
		private var _cntImage:Sprite;
		private var _imageTop:Shape;
		private var _imageBot:Shape;
		private var _mask:Shape;
		private var _lines:Shape;
		private var _tooltip:ViewAllTooltip;
		
		private var _refP0Start:Point;
		private var _refP0End:Point;
		private var _refP1Start:Point;
		private var _refP1End:Point;
		private var _p0Start:Point;
		private var _p0End:Point;
		private var _p1Start:Point;
		private var _p1End:Point;
		
		private var _left:Boolean;
		private var _speed:Number;
		
		public var prev:ViewAllEntry;
		public var next:ViewAllEntry;		
		
		public function ViewAllEntry( side:int, data:Object, idx:int )
		{
			_side = side;
			_data = data;
			_idx = idx;
			
			addChild( _cntImage = new Sprite() );
			_cntImage.addChild( _imageTop = new Shape() );
			_cntImage.addChild( _imageBot = new Shape() );
			addChild( _mask = new Shape() );
			var g:Graphics;
			if( side == 0 ) // left
			{
				g = _imageTop.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( 0, 0 );
				g.lineTo( W >> 1, W >> 1 );
				g.lineTo( 0, W );
				
				g = _imageBot.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( 0, W );
				g.lineTo( W >> 1, W >> 1 );
				g.lineTo( W, W );
				
				g = _mask.graphics;
				g.beginFill( 0xff00ff, 0 );
				g.moveTo( 0, 0 );
				g.lineTo( W, W );
				g.lineTo( 0, W );
			}
			else
			{
				g = _imageTop.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( 0, 0 );
				g.lineTo( W >> 1, W >> 1 );
				g.lineTo( W, 0 );
				
				g = _imageBot.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( W, 0 );
				g.lineTo( W >> 1, W >> 1 );
				g.lineTo( W, W );	
				
				g = _mask.graphics;
				g.beginFill( 0xff00ff, 0 );
				g.moveTo( 0, 0 );
				g.lineTo( W, W );
				g.lineTo( W, 0 );
			}
			_cntImage.alpha = 0;
			_cntImage.mask = _mask;
			
			addChild( _lines = new Shape() );
			
			this.buttonMode =
			this.useHandCursor = true;
			
			_p0Start = new Point();
			_p0End = new Point();
			_p1Start = new Point();
			_p1End = new Point();

		}

		private function _rollOverHandler( event:MouseEvent ):void
		{
			addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_tooltip.setTitle( _data[ "title" ] );
			_clignote();
		}
		
		private function _clignote():void
		{
			eaze( _cntImage ).apply().colorMatrix( .05, .4, 0, -10 )
							 .to( .15 ).colorMatrix( .15, .6, 0, 30 ).easing( Expo.easeOut )
							 .delay( .1 )
							 .to( .6 ).colorMatrix( .1, .1 );
		}

		private function _rollOutHandler( event:MouseEvent ):void
		{
			removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			eaze( _cntImage ).to( .4 ).colorMatrix().tint();
		}
		
		public function getDist():Number
		{
			var dx:Number = this.mouseX - W / 4 * ( _side == 0 ? 1 : 3 );
			var dy:Number = this.mouseY - W * .5;
			
			return Math.sqrt( dx * dx + dy * dy );
		}
		
		private function _initLineData():void
		{
			if( _side == 0 )
			{
				if( _left )
				{
					_refP0Start = new Point( W, W );
					_refP0End = new Point( 0, W );
					_refP1Start = new Point( 0, W );
					_refP1End = new Point( 0, 0 );	
				}
				else
				{
					_refP0Start = new Point( 0, 0 );
					_refP0End = new Point( 0, W );
					_refP1Start = new Point( 0, W );
					_refP1End = new Point( W, W );
				}
			}
			else
			{
				if( _left )
				{
					_refP0Start = new Point( W, 0 );
					_refP0End = new Point( 0, 0 );
					_refP1Start = new Point( 0, 0 );
					_refP1End = new Point( W, W );
				}
				else
				{
					_refP0Start = new Point( W, W );
					_refP0End = new Point( 0, 0 );
					_refP1Start = new Point( 0, 0 );
					_refP1End = new Point( W, 0 );
				}
			}
		}
		
		private function _initBasePos():void
		{
			var w:Number = W >> 1;
			if( _side == 0 )
			{
				_imageTop.x = w;
				_imageTop.y = -w;
				_imageBot.x = -w;
				_imageBot.y = w;
			}
			else
			{
				_imageTop.x = -w;
				_imageTop.y = w;
				_imageBot.x = w;
				_imageBot.y = -w;
			}
		}
		
		private function _enterFrameHandler(event : Event) : void 
		{
			var g:Graphics = _lines.graphics;
			g.clear();
			g.lineStyle( 2, 0x69e1e2, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER );
			g.moveTo( _p0Start.x, _p0Start.y );
			g.lineTo( _p0End.x, _p0End.y );
			g.moveTo( _p1Start.x, _p1Start.y );
			g.lineTo( _p1End.x, _p1End.y );
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			eaze( _cntImage ).apply().colorMatrix( 0, 0, -1 );
			
			_initBasePos();
			
			delay *= _speed;
			
			_p0Start.x = 
			_p0End.x = _refP0Start.x;
			_p0Start.y = 
			_p0End.y = _refP0Start.y;
			_p1Start.x = 
			_p1End.x = _refP1Start.x;
			_p1Start.y =
			_p1End.y = _refP1Start.y;
			eaze( _p0End ).delay( delay ).to( .3 * _speed, { x: _refP0End.x, y: _refP0End.y } ).easing( Quadratic.easeOut );
			eaze( _p0Start ).delay( delay + .3 * _speed ).to( .3 * _speed, { x: _refP0End.x, y: _refP0End.y } ).easing( Expo.easeOut );
			eaze( _p1End ).delay( delay + .3 * _speed  ).to( .2 * _speed, { x: _refP1End.x, y: _refP1End.y } ).easing( Quadratic.easeOut );
			eaze( _p1Start ).delay( delay + .5 * _speed  ).to( .2 * _speed, { x: _refP1End.x, y: _refP1End.y } ).easing( Expo.easeOut );
			eaze( _imageTop ).delay( delay + .3 * _speed  ).to( .4 * _speed, { x: 0, y: 0 } ).easing( Cubic.easeOut );
			eaze( _imageBot ).delay( delay + .3 * _speed  ).to( .4 * _speed, { x: 0, y: 0 } ).easing( Cubic.easeOut );
			eaze( _cntImage ).delay( delay + .3 * _speed  ).apply( { alpha: .2 } ).to( .3 * _speed, { alpha: 1 } ).easing( Cubic.easeIn );
			eaze( _lines ).delay( delay + .3 ).to( .3 * _speed  ).tint( 0x53cecf );
			
			eaze( this ).delay( delay + .75 ).onComplete( _showComplete );
				
			return super.show( delay );
		}

		private function _showComplete():void
		{
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function activate( tooltip:ViewAllTooltip ):void
		{
			_tooltip = tooltip;
			_cntImage.mask = null;
			eaze( _cntImage ).apply().colorMatrix();
			addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			addEventListener( MouseEvent.CLICK, _clickHandler );
		}

		private function _clickHandler( event:MouseEvent ):void
		{
			dispatchEvent( new ViewAllEvent( ViewAllEvent.PROJECT_SELECTED, _idx, true ) );
		}
		
		public function showLeft( delay:Number = 0, speed:Number = 1 ):Number
		{
			_speed = speed;
			_initLineData();
			_left = true;
			return show( delay );
		}
		
		public function showRight( delay:Number = 0, speed:Number = 1 ):Number
		{
			_speed = speed;
			_initLineData();
			_left = false;
			return show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			removeEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			removeEventListener( MouseEvent.CLICK, _clickHandler );
			_cntImage.mask = _mask;
			
			eaze( _cntImage ).delay( delay ).to( .3, { alpha: 0 } );
			var w:Number = W >> 1;
			if( _side == 0 )
			{
				eaze( _imageTop ).delay( delay ).to( .3, { x: w, y: -w } );
				eaze( _imageBot ).delay( delay ).to( .3, { x: -w, y: w } );
			}
			else
			{
				eaze( _imageTop ).delay( delay ).to( .3, { x: -w, y: w } );
				eaze( _imageBot ).delay( delay ).to( .3, { x: w, y: -w } );
			}			
			
			return super.hide( delay );
		}
	}
}

