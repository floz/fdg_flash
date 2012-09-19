/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.diaporama.element.video 
{
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class F4VPlayer extends Sprite
	{
		private var _url:String;
		private var _netConnection:NetConnection;
		private var _netStream:NetStream;
		private var _video:Video;
		private var _left:Bitmap;
		private var _mskLeft:Shape;
		private var _right:Bitmap;
		private var _mskRight:Shape;
		private var _bd:BitmapData;
		
		public function F4VPlayer()
		{
			_netConnection = new NetConnection();
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS, _statusHandler );
			_netConnection.connect( null );
			
			addChild( _left = new Bitmap( null, "auto", true ) );
			addChild( _mskLeft = new Shape() );
			addChild( _right = new Bitmap( null, "auto", true ) );
			addChild( _mskRight = new Shape() );
			
			var g:Graphics = _mskLeft.graphics;
			g.beginFill( 0xff0000 );
			g.moveTo( 0, 0 );
			g.lineTo( 600, 0 );
			g.lineTo( 0, 400 );
			
			g = _mskRight.graphics;
			g.beginFill( 0x00ff00 );
			g.moveTo( 600, 0 );
			g.lineTo( 600, 400 );
			g.lineTo( 0, 400 );
			
			_left.mask = _mskLeft;
			_right.mask = _mskRight;			
			
			_bd = new BitmapData( 600, 400 );
			
			this.alpha = 0;	
		}

		private function _statusHandler( event:NetStatusEvent ):void
		{
			switch( event.info.code )
			{
				case "NetConnection.Connect.Success": _initStreamAndVideo(); break;
				case "NetStream.Play.StreamNotFound": trace( "url problem : " + _url ); break;
			}
		}

		private function _initStreamAndVideo():void
		{
			_netStream = new NetStream( _netConnection );
			_netStream.addEventListener( NetStatusEvent.NET_STATUS, _statusHandler );
			_netStream.client = this;
			
			_video = new Video( 600, 400 );
			_video.attachNetStream( _netStream );
		}
		
		public function onMetaData( info:Object ):void 
		{
	        trace( "metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate );
			_show();
			//dispatchEvent( new Event( Event.ACTIVATE ) );
	    }
	    public function onCuePoint( info:Object ):void 
		{
	        trace( "cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type );
	    }
		
		public function onXMPData( info:Object ):void
		{
			
		}
		
		public function onPlayStatus( info:Object ):void
		{
			trace( "/-- onPlayStatus" );
			for( var s:String in info )
			{
				trace( s + " : " + info[ s ] ); 
			}
			trace( "--/" );
			
			if( info.code == "NetStream.Play.Complete" )
			{
				dispatchEvent( new Event( Event.COMPLETE) );
			}
		}
		
		public function play( url:String = null ):void
		{
			trace( "PLAY ?? " + url );
			if( url == null )
			{
				if( _url == null )	
					return;
			}	
			_url = url;	
			trace( "PLAY !! " + _url );
			
			_netStream.play( _url );			
		}

		private function _show():void
		{
			_left.x = -600;
			_left.y = 400;
			
			_right.x = 600;
			_right.y = -600;
			
			eaze( _left ).to( .4, { x: 0, y: 0 } ).easing( Expo.easeOut );
			eaze( _right ).to( .4, { x: 0, y: 0 } ).easing( Expo.easeOut );
			eaze( this ).to( .4, { alpha: 1 } );
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			_enterFrameHandler( null );
		}
		
		public function pause():void
		{
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			_netStream.pause();
			_hide();
		}

		private function _enterFrameHandler( event:Event ):void
		{
			_bd.draw( _video );
			_left.bitmapData = _bd;
			_right.bitmapData = _bd;
		}

		private function _hide():void
		{
			eaze( _left ).to( .4, { x: -600, y: 400 } );
			eaze( _right ).to( .4, { x: 600, y: -400 } );
			eaze( this ).to( .4, { alpha: 0 } );
		}
		
		public function dispose():void
		{
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			_video.clear();
			
			_netConnection.removeEventListener( NetStatusEvent.NET_STATUS, _statusHandler );
			_netStream.removeEventListener( NetStatusEvent.NET_STATUS, _statusHandler );
			_netConnection.close();
			_netStream.close();		
			
			_bd.dispose();	
		}
	}
}