/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.loading 
{
	import fr.filsdegraphiste.module.site.ui.TitleText;
	import aze.motion.easing.Quint;
	import aze.motion.eaze;

	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.event.BatchEvent;
	import fr.digitas.flowearth.net.BatchLoaderItem;
	import fr.filsdegraphiste.config._;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import fr.filsdegraphiste.ui.loading.LoadingIconOK;
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
		private var _titleText:TitleText;
		private var _batcher:Batcher;
		private var _loadingIcon:LoadingIconOK;		
		
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
			_titleText.x = _.stage.stageWidth - _titleText.width >> 1;
			_titleText.y = _.stage.stageHeight - 110 >> 1;	
				
			
			if( _loadingIcon != null )
			{
				_loadingIcon.x = _.stage.stageWidth >> 1;
				_loadingIcon.y = _titleText.y - 100; 					
			}
		}
		
		private function _init():void
		{
			addChild( _titleText = new TitleText( _label, "loading_title" ) );
			if( _filesToLoad != null )
				_initLoader();
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
			
			addChild( _loadingIcon = new LoadingIconOK() );
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
			
			if( _filesToLoad == null )
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
			 
			_titleText.show( delay );
			
			var d:Number = delay + ( _label.length - 1 ) * .07 + .3;
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
			
			_titleText.hide( delay );
			
			if( _loadingIcon )
				_loadingIcon.hide( delay );
			
			eaze( this ).delay( delay + _label.length * .07 + .4 ).onComplete( _onLoadEnd );
						
			return super.hide( delay );
		}

		private function _onLoadEnd() : void 
		{
			_titleText.dispose();
			dispatchEvent(new Event(Event.COMPLETE));			
			_.stage.removeEventListener( Event.RESIZE, _resizeHandler );
			parent.removeChild( this );
		}

		public function get data() : Object 
		{
			return _data;
		}
	}
}