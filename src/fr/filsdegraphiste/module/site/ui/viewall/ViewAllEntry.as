/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import flash.display.Sprite;
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ViewAllEntry extends ModulePart
	{
		private const _W:int = 190;
		private const _POS:Point = new Point();
		
		private var _side:int;
		private var _data:Object;
		private var _cntImage:Sprite;
		private var _imageTop:Shape;
		private var _imageBot:Shape;
		private var _mask:Shape;
		private var _lines:Shape;
		
		private var _refP0Start:Point;
		private var _refP0End:Point;
		private var _refP1Start:Point;
		private var _refP1End:Point;
		private var _refP2Start:Point;
		private var _refP2End:Point;
		private var _p0Start:Point;
		private var _p0End:Point;
		private var _p1Start:Point;
		private var _p1End:Point;
		private var _p2Start:Point;
		private var _p2End:Point;
		
		private var _left:Boolean;
		
		public var prev:ViewAllEntry;
		public var next:ViewAllEntry;
		
		public function ViewAllEntry( side:int, data:Object )
		{
			_side = side;
			_data = data;
			
			addChild( _cntImage = new Sprite() );
			_cntImage.addChild( _imageTop = new Shape() );
			_cntImage.addChild( _imageBot = new Shape() );
			//addChild( _image = new Shape() );
			//var g:Graphics = _image.graphics;
			var g:Graphics;// = _imageTop.graphics;
			if( side == 0 ) // left
			{
				g = _imageTop.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( 0, 0 );
				g.lineTo( _W >> 1, _W >> 1 );
				g.lineTo( 0, _W );
				
				g = _imageBot.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( 0, _W );
				g.lineTo( _W >> 1, _W >> 1 );
				g.lineTo( _W, _W );
			}
			else
			{
				g = _imageTop.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( 0, 0 );
				g.lineTo( _W >> 1, _W >> 1 );
				g.lineTo( _W, 0 );
				
				g = _imageBot.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( data[ "preview" ] ) );
				g.moveTo( _W, 0 );
				g.lineTo( _W >> 1, _W >> 1 );
				g.lineTo( _W, _W );	
			}
			_cntImage.alpha = 0;
			
			addChild( _lines = new Shape() );
			
			this.buttonMode =
			this.useHandCursor = true;
			
			_p0Start = new Point();
			_p0End = new Point();
			_p1Start = new Point();
			_p1End = new Point();
			_p2Start = new Point();
			_p2End = new Point();
			
			if( _side == 0 )
			{
				_refP0Start = new Point( 0, 0 );
				_refP0End = new Point( _W, _W );
				_refP1Start = new Point( _W, _W );
				_refP1End = new Point( 0, _W );
				_refP2Start = new Point( 0, _W );
				_refP2End = new Point( 0, 0 );
			}
			else
			{
				_refP0Start = new Point( 0, 0 );
				_refP0End = new Point( _W, _W );
				_refP1Start = new Point( _W, _W );
				_refP1End = new Point( _W, 0 );
				_refP2Start = new Point( _W, 0 );
				_refP2End = new Point( 0, 0 );
			}
		}
		
		public function getDist():Number
		{
			var dx:Number = this.mouseX - _W / 4 * ( _side == 0 ? 1 : 3 );
			var dy:Number = this.mouseY - _W * .5;
			
			return Math.sqrt( dx * dx + dy * dy );
		}
		
		private function _initLineData():void
		{
			
			if( _side == 0 )
			{
				if( _left )
				{
					_refP0Start = new Point( 0, 0 );
					_refP0End = new Point( 0, _W );
					_refP1Start = new Point( 0, _W );
					_refP1End = new Point( _W, _W );
					_refP2Start = new Point( _W, _W );
					_refP2End = new Point( 0, 0 );
				}
				else
				{
					_refP0Start = new Point( 0, 0 );
					_refP0End = new Point( 0, _W );
					_refP1Start = new Point( 0, _W );
					_refP1End = new Point( _W, _W );
					_refP2Start = new Point( _W, _W );
					_refP2End = new Point( 0, 0 ); 
				}
			}
			else
			{
				if( _left )
				{
					_refP0Start = new Point( _W, _W );
					_refP0End = new Point( 0, 0 );
					_refP1Start = new Point( 0, 0 );
					_refP1End = new Point( _W, 0 );
					_refP2Start = new Point( _W, 0 );
					_refP2End = new Point( _W, _W );
				}
				else
				{
					_refP0Start = new Point( 0, 0 );
					_refP0End = new Point( _W, 0 );
					_refP1Start = new Point( _W, 0 );
					_refP1End = new Point( _W, _W );
					_refP2Start = new Point( _W, _W );
					_refP2End = new Point( 0, 0 );
				}
			}
			
			return;
			
			if( _side == 0 )
			{
				if( _left )
				{
					_refP0Start = new Point( 0, 0 );
					_refP0End = new Point( 0, _W );
					_refP1Start = new Point( _W, _W );
					_refP1End = new Point( 0, _W );
					_refP2Start = new Point( 0, 0 );
					_refP2End = new Point( _W, _W );
				}
				else
				{
					_refP0Start = new Point( 0, 0 );
					_refP0End = new Point( 0, _W );
					_refP1Start = new Point( 0, _W );
					_refP1End = new Point( _W, _W );
					_refP2Start = new Point( 0, 0 );
					_refP2End = new Point( _W, _W ); 
				}
			}
			else
			{
				if( _left )
				{
					_refP0Start = new Point( _W, 0 );
					_refP0End = new Point( _W, _W );
					_refP1Start = new Point( _W, 0 );
					_refP1End = new Point( 0, 0 );
					_refP2Start = new Point( _W, _W );
					_refP2End = new Point( 0, 0 );
				}
				else
				{
					_refP0Start = new Point( _W, _W );
					_refP0End = new Point( _W, 0 );
					_refP1Start = new Point( 0, 0 );
					_refP1End = new Point( _W, 0 );
					_refP2Start = new Point( _W, _W );
					_refP2End = new Point( 0, 0 );
				}
			}
		}
		
		private function _enterFrameHandler(event : Event) : void 
		{
			var g:Graphics = _lines.graphics;
			g.clear();
			g.lineStyle( 2, 0xffffff, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER );
			g.moveTo( _p0Start.x, _p0Start.y );
			g.lineTo( _p0End.x, _p0End.y );
			g.moveTo( _p1Start.x, _p1Start.y );
			g.lineTo( _p1End.x, _p1End.y );
			g.moveTo( _p2Start.x, _p2Start.y );
			g.lineTo( _p2End.x, _p2End.y );
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			//eaze( this ).delay( delay ).to( .3, { alpha: 1 } );
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			_p0Start.x = 
			_p0End.x = _refP0Start.x;
			_p0Start.y = 
			_p0End.y = _refP0Start.y;
			_p1Start.x = 
			_p1End.x = _refP1Start.x;
			_p1Start.y =
			_p1End.y = _refP1Start.y;
			_p2Start.x =
			_p2End.x = _refP2Start.x;
			_p2Start.y = 
			_p2End.y = _refP2Start.y;
			
			/*
			eaze( _p0End ).delay( delay ).to( .3, { x: _refP0End.x, y: _refP0End.y } ).easing( Expo.easeOut );
			eaze( _p0Start ).delay( delay + .25 ).to( .3, { x: _refP0End.x, y: _refP0End.y } ).easing( Expo.easeOut );
			eaze( _p1End ).delay( delay + .3 ).to( .3, { x: _refP1End.x, y: _refP1End.y } ).easing( Expo.easeOut );
			eaze( _p1Start ).delay( delay + .5 ).to( .3, { x: _refP1End.x, y: _refP1End.y } ).easing( Expo.easeOut );
			eaze( _p2End ).delay( delay + .7 ).to( .3, { x: _refP2End.x, y: _refP2End.y } ).easing( Expo.easeOut );
			eaze( _p2Start ).delay( delay + .75 ).to( .3, { x: _refP2End.x, y: _refP2End.y } ).easing( Expo.easeOut );
			  * 
			 */
			
			eaze( _p0End ).delay( delay ).to( .3, { x: _refP0End.x, y: _refP0End.y } ).easing( Expo.easeOut );
			eaze( _p0Start ).delay( delay + .25 ).to( .3, { x: _refP0End.x, y: _refP0End.y } ).easing( Expo.easeOut );
			eaze( _p1End ).delay( delay + .05 ).to( .3, { x: _refP1End.x, y: _refP1End.y } ).easing( Expo.easeOut );
			eaze( _p1Start ).delay( delay + .3 ).to( .3, { x: _refP1End.x, y: _refP1End.y } ).easing( Expo.easeOut );
			eaze( _p2End ).delay( delay + .2 ).to( .3, { x: _refP2End.x, y: _refP2End.y } ).easing( Expo.easeOut );
			eaze( _p2Start ).delay( delay + .45 ).to( .3, { x: _refP2End.x, y: _refP2End.y } ).easing( Expo.easeOut );
			
				
			return super.show( delay );
		}
		
		public function showLeft( delay:Number = 0 ):Number
		{
			_initLineData();
			_left = true;
			return show( delay );
		}
		
		public function showRight( delay:Number = 0 ):Number
		{
			_initLineData();
			_left = false;
			return show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return super.hide( delay );
		}
	}
}

