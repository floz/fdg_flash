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
				_entries[ _entries.length ] = entry;
				
				if( step % 2 )
					px += entry.width;
					
				step++;				
				id++;
			}
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
			
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
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
				eaze( _entries[ i ] ).to( .25 ).colorMatrix( 0, 0, - Math.max( 0, Math.min( _entries[ i ].getDist() / 300, 1 ) ) );
			}
		}
	}
}

