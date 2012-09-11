/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import fr.filsdegraphiste.config.fdgDataLoaded;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.events.Event;
	
	public class ViewAllProjects extends ModulePart
	{
		protected var _entries:Vector.<ViewAllEntry>;
		protected var _ref:BitmapData;
		protected var _tooltip:ViewAllTooltip;
		
		public function ViewAllProjects( projects:Object, tooltip:ViewAllTooltip )
		{
			_entries = new Vector.<ViewAllEntry>();
			_tooltip = tooltip;

			var cntRef:Sprite = new Sprite();
			var refItem:Shape;
			var g:Graphics;
			
			var px:int;	
			
			var step:int;
			var id:int;
			var entry:ViewAllEntry;
			for( var s:String in projects )
			{
				addChild( entry = new ViewAllEntry( id % 2, projects[ s ], id ) );
				entry.x = px;
				_entries[ _entries.length ] = entry;
				
				cntRef.addChild( refItem = new Shape() );
				refItem.x = px;
				g = refItem.graphics;
				g.beginBitmapFill( fdgDataLoaded.getImage( projects[ s ][ "preview" ] ) );
				g.moveTo( 0, 0 );
				g.lineTo( ViewAllEntry.W, ViewAllEntry.W );
				if( id % 2 == 0 )
				{
					g.lineTo( 0, ViewAllEntry.W );
				}
				else
				{
					g.lineTo( ViewAllEntry.W, 0 );
				}
				
				if( step % 2 )
					px += entry.width;
					
				step++;				
				id++;
			}
			
			_ref = new BitmapData( cntRef.width, cntRef.height, true, 0x00 );
			_ref.draw( cntRef );
		}
		
		private function _enterFrameHandler( event:Event ):void
		{
			_render();
		}

		protected function _render( time:Number = .25 ):void
		{
			var n:int = _entries.length;
			for( var i:int; i < n; i++ )
			{
				eaze( _entries[ i ] ).to( time ).colorMatrix( 0, 0, - Math.max( 0, Math.min( _entries[ i ].getDist() / 400, 1 ) ) );
			}
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			var d:Number = 0;
			var dRef:Number = .3;
			
			var speed:Number = 1;
			
			var i:int = _entries.length >> 1;
			i += 1;
			while( --i > - 1 )
			{
				_entries[ i ].showLeft( delay + d, speed );
				d += dRef;
				speed -= .05;
			}
			
			dRef = .3;
			speed = 1;
			
			d = .1;
			var n:int = _entries.length;
			for( i = _entries.length * .5 >> 0; i < n; i++ )
			{
				_entries[ i ].showRight( delay + d, speed );
				d += dRef;
				speed -= .05;
			}
			
			_entries[ i - 1 ].addEventListener( Event.COMPLETE, _showComplete );
			return super.show( delay );
		}

		private function _showComplete( event:Event ):void
		{
			EventDispatcher( event.currentTarget ).removeEventListener( Event.COMPLETE, _showComplete );
			_start();
		}

		private function _start() : void 
		{
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			dispatchEvent( new Event( Event.COMPLETE ) );
			_render( 0 );
			
			var n:int = _entries.length;
			for( var i:int; i < n; i++ )
			{
				_entries[ i ].activate( _tooltip );
			}			
			
			addEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
		}

		private function _rollOverHandler( event:MouseEvent ):void
		{
			addEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_tooltip.show();
		}

		private function _rollOutHandler( event:MouseEvent ):void
		{
			removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			_tooltip.hide();
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			removeEventListener( MouseEvent.ROLL_OVER, _rollOverHandler );
			removeEventListener( MouseEvent.ROLL_OUT, _rollOutHandler );
			removeEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			var d:Number = 0;
			
			var i:int = _entries.length >> 1;
			i += 1;
			while( --i > -1 )
			{
				_entries[ i ].hide( d );
				d += .05;
			}
			
			d = 0;
			var n:int = _entries.length;
			for( i = _entries.length >> 1; i < n; i++ )
			{
				_entries[ i ].hide( d );
				d += .05;
			}
			
			return super.hide( delay );
		}
			
		override public function dispose():void
		{
			_ref.dispose();
		}

		public function get ref():BitmapData
		{
			return _ref;
		}
	}
}

