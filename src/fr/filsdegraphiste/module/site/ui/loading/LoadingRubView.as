/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.loading 
{
	import aze.motion.easing.Quint;
	import aze.motion.eaze;

	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.event.BatchEvent;
	import fr.digitas.flowearth.net.BatchLoaderItem;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.ui.loading.LoadingIcon;
	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class LoadingRubView extends ModulePart
	{
		private var _label:String;
		private var _data:Object;
		private var _filesToLoad:Array;
		private var _cntTitle:Sprite;
		private var _cntLetters:Sprite;
		private var _mask:Shape;
		private var _line:Line;
		private var _letters:Vector.<Text>;		
		private var _batcher:Batcher;
		private var _loadingIcon:LoadingIcon;		
		
		private var _idxLoaded:int;
		
		private var _showAnimationComplete:Boolean;
		private var _loadComplete:Boolean;		
		
		private var _shown:Boolean;
		
		public function LoadingRubView( label:String, data:Object = null, filesToLoad:Array = null )
		{
			_label = label;
			_data = data;
			_filesToLoad = filesToLoad;
			
			_init();
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}
		
		private function _onResize():void
		{
			_cntTitle.x = _.stage.stageWidth - _cntTitle.width >> 1;
			_cntTitle.y = _.stage.stageHeight - 110 >> 1;	
			
			_line.x = _cntTitle.x + _cntTitle.width - 35 >> 0;
			_line.y = _cntTitle.y + 39;	
			
			if( _loadingIcon != null )
			{
				_loadingIcon.x = _.stage.stageWidth >> 1;
				_loadingIcon.y = _cntTitle.y - 100; 					
			}
		}
		
		private function _init():void
		{
			_initLetters();
			_initLine();
			if( _data != null )
				_initLoader();
		}
		
		private function _initLetters():void
		{
			addChild( _cntTitle = new Sprite() );
			_cntTitle.addChild( _cntLetters = new Sprite() );
			_cntTitle.addChild( _mask = new Shape() );
			_letters = new Vector.<Text>();
			
			var letter:Text;
			
			var px:int = 0;
			
			var n:int = _label.length;
			for( var i:int; i < n; i++ )
			{
				letter = new Text( _label.charAt( i ), "loading_title" );
				letter.x = px;
				letter.y = -120;
				_letters[ i ] = letter;
				_cntLetters.addChild( letter );
				
				px += letter.width;
			}
			
			var g:Graphics = _mask.graphics;
			g.beginFill( 0xff00ff, .5 );
			g.drawRect( 0, -10, _cntLetters.width, 120 );
			_cntLetters.mask = _mask;
			_mask.y = 20;
		}
		
		private function _initLine():void
		{
			addChild( _line = new Line() );
		}
		
		private function _initLoader():void
		{			
			_idxLoaded = 0;
			
			_batcher = new Batcher();
			_batcher.addEventListener( ProgressEvent.PROGRESS, _progressHandler );
			_batcher.addEventListener( BatchEvent.ITEM_COMPLETE, _itemCompleteHandler );
			_batcher.addEventListener( Event.COMPLETE, _loadCompleteHandler );
			
			var n:int = _filesToLoad.length;
			for( var i:int; i < n; i++ )
			{
				_batcher.addItem( new BatchLoaderItem( new URLRequest( _filesToLoad[ i ] ) ) );
			}
			
			addChild( _loadingIcon = new LoadingIcon() );
		}

		private function _progressHandler(event : ProgressEvent) : void 
		{
			_loadingIcon.percent = event.bytesLoaded / event.bytesTotal;			
		}
		
		private function _itemCompleteHandler(event : BatchEvent) : void 
		{
			var b:BatchLoaderItem = _batcher.getCurrentItem() as BatchLoaderItem;
			fdgDataLoaded.add( _filesToLoad[ _idxLoaded ], Bitmap( b.loader.content ).bitmapData );
			_idxLoaded++;
		}

		private function _loadCompleteHandler(event : Event) : void 
		{
			_loadComplete = true;
			if( !_showAnimationComplete )
				return;
			
			hide();
		}
		
		private function _onAnimationShowComplete():void
		{
			_showAnimationComplete = true;
			
			if( _data == null )
			{
				hide();
				return;
			}
			
			if( !_loadComplete )
				return;
			
			hide();
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			if( _shown )
				return 0;
			_shown = true;
			
			var n:int = _letters.length;
			for( var i:int; i < n; i++ )
			{
				eaze( _letters[ i ] ).delay( delay + i * .07 )
									 .to( .3, { y: 0 } ).easing( Quint.easeOut );
			}
			_line.show( delay );
			
			var d:Number = delay + ( n - 1 ) * .07 + .3;
			eaze( this ).delay( d ).onComplete( _onAnimationShowComplete );
			if( _batcher != null )
				eaze( this ).delay( d, false ).onComplete( _batcher.execute );
		
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			if( !_shown	)
				return 0;
			_shown = false;			
			
			var j:int, 
				i:int = _letters.length;
			
			while( --i > -1 )
			{
				eaze( _letters[ i ] ).delay( delay + j * .07 )
									 .to( .3, { y: -120 } ).easing( Quint.easeIn );
				j++;
			}
			_line.hide( delay + .2 );
			
			if( _loadingIcon )
				eaze( _loadingIcon ).delay( delay ).to( .4, { alpha: 0 } );
			
			eaze( this ).delay( delay + .4 ).onComplete( _onLoadEnd );
						
			return super.hide( delay );
		}

		private function _onLoadEnd() : void 
		{
			dispatchEvent(new Event(Event.COMPLETE));			
			_.stage.removeEventListener( Event.RESIZE, _resizeHandler );
			parent.removeChild( this );
		}

		public function get data() : Object {
			return _data;
		}
	}
}
import aze.motion.easing.Expo;
import aze.motion.eaze;

import fr.minuit4.core.navigation.modules.ModulePart;

import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.events.Event;

final class Line extends ModulePart
{
	private var _bg:Shape;
	private var _s:Shape;
	private var _percent:Number = 0;
	
	private var _show:Boolean;
	
	public function Line()
	{
		addChild( _bg = new Shape() );
		addChild( _s = new Shape() );
	}
	
	override public function show( delay:Number = 0 ):Number
	{
		_show = true;
		addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
		eaze( this ).delay( delay ).to( .5, { percent: 1 } ).easing( Expo.easeOut );	
		return super.show( delay );
	}
	
	private function _enterFrameHandler( e:Event ):void
	{
		var g:Graphics;
		
		var p:Number = 70 * percent;
		
		if( _show )
		{			
			g = _s.graphics;
			g.clear();
			g.lineStyle( 0, 0x53cecf, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER );
			g.moveTo( 70, 0 );
			g.lineTo( 70 - p, p );
			
			
			p *= 2;
			g = _bg.graphics;
			g.clear();
			g.beginFill( 0xffffff );
			g.moveTo( 70, 0 );
			g.lineTo( 70, p );
			g.lineTo( 70 - p, p );
		}
		else
		{
			g = _s.graphics;
			g.clear();
			g.lineStyle( 0, 0x53cecf, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER );
			g.moveTo( 0, 70 );
			g.lineTo( p, 70 - p );
			
			p *= 2;
			g = _bg.graphics;
			g.clear();
			g.beginFill( 0xffffff );
			g.moveTo( -70, 140 );
			g.lineTo( -70 + p, 140 - p );
			g.lineTo( -70 + p, 140 );		
		}
	}
	
	override public function hide( delay:Number = 0 ):Number
	{
		_show = false;
		eaze( this ).delay( delay ).to( .5, { percent: 0 } ).easing( Expo.easeOut )
					.onComplete( _dispose );
		return super.hide(delay);
	}

	private function _dispose():void
	{
		removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
	}

	public function get percent() : Number 
	{
		return _percent;
	}
	
	public function set percent(percent : Number) : void 
	{
		_percent = percent;
	}
}