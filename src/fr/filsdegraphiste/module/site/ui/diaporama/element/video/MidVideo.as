/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.diaporama.element.video 
{
	import flash.events.MouseEvent;
	import assets.AssetVideoScreenEmpty;

	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.module.site.ui.TitleText;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	public class MidVideo extends ModulePart
	{
		private static const _BD:BitmapData = new AssetVideoScreenEmpty();
		
		private var _url:String;
		private var _cnt:Sprite;
		private var _left:Shape;
		private var _right:Shape;
		private var _player:F4VPlayer;
		private var _tfPlay:TitleText;
		private var _tfPause:TitleText;
		private var _zoneClick:Sprite;
		
		private var _playing:Boolean;
		
		public function MidVideo( url:String )
		{
			_url = url;
			
			addChild( _cnt = new Sprite() );
			
			_cnt.addChild( _left = new Shape() );
			var g:Graphics = _left.graphics;
			g.beginBitmapFill( _BD, null, false, true );
			g.drawRect( 0, 0, _BD.width >> 1, _BD.height );
			
			_cnt.addChild( _right = new Shape() );
			g = _right.graphics;
			g.beginBitmapFill( _BD, null, false, true );
			g.drawRect( _BD.width >> 1, 0, _BD.width >> 1, _BD.height );
			
			_cnt.addChild( _player = new F4VPlayer() );
			_player.addEventListener( Event.COMPLETE, _videoCompleteHandler );
			_player.x = _cnt.width - _player.width >> 1;
			_player.y = _cnt.height - _player.height >> 1;
			_player.y -= 3;
			
			_cnt.addChild( _tfPlay = new TitleText( "PLAY", "player", false, 0xf7f7f7 ) );
			_tfPlay.x = _cnt.width - _tfPlay.width >> 1;
			_tfPlay.y = _cnt.height - _tfPlay.height >> 1;
			
			_cnt.addChild( _tfPause = new TitleText( "PAUSE", "player", false, 0xf7f7f7 ) );
			_tfPause.x = _cnt.width - _tfPause.width >> 1;
			_tfPause.y = _cnt.height - _tfPause.height >> 1;
						
			_cnt.addChild( _zoneClick = new Sprite() );
			g = _zoneClick.graphics;
			g.beginFill( 0xff00ff, 0 );
			g.drawRect( 0, 0, 600, 400 );
			_zoneClick.x = _cnt.width - _zoneClick.width >> 1;
			_zoneClick.y = _cnt.height - _zoneClick.height >> 1;
			_zoneClick.buttonMode =
			_zoneClick.useHandCursor = true;
			_zoneClick.addEventListener( MouseEvent.CLICK, _clickHandler );
			
			this.alpha = 0;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
			
			addEventListener( Event.REMOVED_FROM_STAGE, _removedFromStageHandler );
		}

		private function _removedFromStageHandler( event:Event ):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, _removedFromStageHandler );
			dispose();
		}

		private function _videoCompleteHandler( event:Event ):void
		{
			_stopPlaying();
		}

		private function _clickHandler( event:MouseEvent ):void
		{
			if( _playing )
			{
				_stopPlaying();				
			}
			else
			{
				_startPlaying();				
			}
		}

		private function _stopPlaying():void
		{
			_tfPlay.show( .4 );
			_tfPause.hide();
			_zoneClick.removeEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			_zoneClick.removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_pause();
		}

		private function _startPlaying():void
		{
			_tfPlay.hide();
			_tfPause.show( .4 );
			_zoneClick.addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			_zoneClick.addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_play();
		}

		private function _play():void
		{
			_playing = true;
			_player.play( _url );
		}

		private function _pause():void
		{
			_playing = false;
			_player.pause();
		}

		private function _rollOverHandler( event:MouseEvent ):void
		{
			_over();
		}

		private function _over():void
		{
			_tfPause.show();//eaze( _tfPause ).to( 1, { alpha: 1 } );
		}
		
		private function _rollOutHandler( event:MouseEvent ):void
		{
			_out();
		}

		private function _out():void
		{
			_tfPause.hide();//eaze( _tfPause ).to( 1, { alpha: 0 } );
		}

		private function _resizeHandler( event:Event ):void
		{
			_onResize();
		}

		private function _onResize():void
		{
			_cnt.x = _.stage.stageWidth - _cnt.width >> 1;
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			_left.y = -_BD.height;
			_right.y = _BD.height;
			
			eaze( _left ).delay( delay ).to( .4, { y: 0 } ).easing( Expo.easeOut );
			eaze( _right ).delay( delay ).to( .4, { y: 0 } ).easing( Expo.easeOut );
			eaze( this ).delay( delay ).to( .4, { alpha: 1 } );
			
			_tfPlay.show( delay + .4 );
			
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			eaze( this ).delay( delay ).to( .4, { alpha: 0 } ).onComplete( dispose );
			
			return super.hide( delay );
		}
			
		override public function dispose():void
		{
			_player.removeEventListener( Event.COMPLETE, _videoCompleteHandler );
			_player.dispose();
			
			_zoneClick.removeEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			_zoneClick.removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			
			super.dispose();
		}
	}
}