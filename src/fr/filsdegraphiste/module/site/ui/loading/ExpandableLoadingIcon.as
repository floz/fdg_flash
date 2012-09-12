/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.loading 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.event.StepEvent;
	import fr.filsdegraphiste.ui.loading.LoadingIcon2;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ExpandableLoadingIcon extends LoadingIcon2
	{
		protected var _endPoints:Vector.<Point>;		
		protected var _expendBridge:ExpendBridge;
		protected var _expendPhase2:Boolean;
	
		public function ExpandableLoadingIcon()
		{
			
		}
		
		public function expends():void
		{
			var p0:Point = new Point( -( _.stage.stageWidth - W ) >> 1, -( _.stage.stageHeight - H ) * .5 + 48 );
			_endPoints = Vector.<Point>( [ new Point( p0.x + _.stage.stageWidth * .5 >> 0, p0.y + _.stage.stageHeight ), 
										   p0,
										   new Point( p0.x + _.stage.stageWidth, p0.y ) ] );
			
			_expendBridge = new ExpendBridge( new Point( 0, H ), new Point( 0, 0 ), new Point( W, H ) );
			eaze( _expendBridge.p0 ).to( .4, { x: _endPoints[ 0 ].x, y: _endPoints[ 0 ].y } ).easing( Expo.easeOut );
			eaze( _expendBridge.p1 ).delay( .075 ).to( .4, { x: _endPoints[ 1 ].x, y: _endPoints[ 1 ].y } ).easing( Expo.easeOut );
			eaze( _expendBridge.p2 ).delay( .15 ).to( .4, { x: _endPoints[ 2 ].x, y: _endPoints[ 2 ].y } ).easing( Expo.easeOut );
			
			eaze( this ).delay( .3 ).onComplete( _setExpendPhase2 );
			
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
		}

		private function _setExpendPhase2():void 
		{
			dispatchEvent( new StepEvent( StepEvent.STEP1_COMPLETE ) );
			dispatchEvent( new StepEvent( StepEvent.STEP2_START ) );
			
			eaze( _expendBridge.p0 ).to( .4, { x: _endPoints[ 0 ].x, y: _endPoints[ 0 ].y } ).easing( Expo.easeOut );
			eaze( _expendBridge.p1 ).delay( .1 ).to( .4, { x: _endPoints[ 0 ].x, y: _endPoints[ 0 ].y } ).easing( Expo.easeOut );
			eaze( _expendBridge.p2 ).delay( .2 ).to( .4, { x: _endPoints[ 0 ].x, y: _endPoints[ 0 ].y } ).easing( Expo.easeOut )
									.onComplete( _setEndExpend );
									
			eaze( this ).delay( .5 ).onComplete( dispatchEvent, new StepEvent( StepEvent.STEP2_COMPLETE ) );
			_expendPhase2 = true;
		}

		private function _setEndExpend() : void 
		{			
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
		}
		
		private function _enterFrameHandler( e:Event ):void
		{
			var g:Graphics = _mainShape.graphics;
			g.clear();
			g.lineStyle( 2, 0x53cecf, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER );
			if( !_expendPhase2 )
			{
				g.moveTo( _expendBridge.p0.x, _expendBridge.p0.y );
				g.lineTo( _expendBridge.p1.x, _expendBridge.p1.y );
				g.lineTo( _expendBridge.p2.x, _expendBridge.p2.y );
				g.lineTo( _expendBridge.p0.x, _expendBridge.p0.y );
			}
			else
			{
				g.moveTo( _expendBridge.p0.x, _expendBridge.p0.y );
				g.lineTo( _expendBridge.p1.x, _expendBridge.p1.y );
				g.moveTo( _expendBridge.p2.x, _expendBridge.p2.y );
				g.lineTo( _expendBridge.p0.x, _expendBridge.p0.y );
			}
		}
	}
}
import flash.geom.Point;

final class ExpendBridge
{
	public var p0:Point;
	public var p1:Point;
	public var p2:Point;
	
	public function ExpendBridge( p0:Point, p1:Point, p2:Point )
	{
		this.p0 = p0;
		this.p1 = p1;
		this.p2 = p2;
	}
}