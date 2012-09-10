/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;

	import flash.events.Event;
	
	public class ViewAllProjects extends ModulePart
	{
		protected var _entries:Vector.<ViewAllEntry>;
		
		public function ViewAllProjects( projects:Object )
		{
			_entries = new Vector.<ViewAllEntry>();
			
			var px:int;	
			
			var step:int;
			var id:int;
			var entry:ViewAllEntry;
			for( var s:String in projects )
			{
				addChild( entry = new ViewAllEntry( id % 2, projects[ s ] ) );
				entry.x = px;
				//eaze( entry ).apply().colorMatrix( 0, 0, -1 );
				_entries[ _entries.length ] = entry;
				
				if( step % 2 )
					px += entry.width;
					
				step++;				
				id++;
			}
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}

		private function _resizeHandler( event:Event ):void
		{
			_onResize();
		}

		protected function _onResize():void
		{
			this.x = _.stage.stageWidth - this.width >> 1;
			this.y = _.stage.stageHeight - this.height >> 1;
		}
		
		private function _enterFrameHandler( event:Event ):void
		{
			_render();
		}

		protected function _render():void
		{
			var n:int = _entries.length;
			for( var i:int; i < n; i++ )
			{
				eaze( _entries[ i ] ).to( .25 ).colorMatrix( 0, 0, - Math.max( 0, Math.min( _entries[ i ].getDist() / 400, 1 ) ) );
			}
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			var d:Number = 0;
			var dRef:Number = .3;
			
			var i:int = _entries.length >> 1;
			i += 1;
			while( --i > - 1 )
			{
				_entries[ i ].show( delay + d );
				d += dRef;
				dRef -= .025;
			}
			
			dRef = .3;
			
			d = .1;
			var n:int = _entries.length;
			for( i = _entries.length * .5 >> 0; i < n; i++ )
			{
				_entries[ i ].show( delay + d );
				d += dRef;
				dRef -= .025;
			}
			
			eaze( this ).delay( delay + d + .3 ).onComplete( _start );
			return super.show( delay );
		}

		private function _start() : void 
		{
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			return super.hide( delay );
		}
	}
}

