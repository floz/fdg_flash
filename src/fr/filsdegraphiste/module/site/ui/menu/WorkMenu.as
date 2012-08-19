/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.menu 
{
	import flash.events.Event;
	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;
	public class WorkMenu extends ModulePart
	{
		private var _items:Vector.<WorkMenuItem>;
		
		public function WorkMenu()
		{
			_items = new Vector.<WorkMenuItem>();
			
			var px:int;
			var wmi:WorkMenuItem;
			for( var s:String in _.data.works )
			{
				if( s == "files_to_load" )
					continue;
				
				wmi = new WorkMenuItem( s );
				wmi.x = px;
				addChild( wmi );
				
				px += wmi.width - 29;
			}
			
			this.visible = false;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		private function _onResize() : void 
		{
			var dx:Number = -_.stage.stageWidth * .5;
			var dy:Number = _.stage.stageHeight;
			var a:Number = Math.atan2( dy, dx );
			
			this.x = int( _.stage.stageWidth - this.width + Math.cos( a ) * 50 + 30 );
			this.y = int( Math.sin( a ) * 50 ); 
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			this.visible = true;	
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			this.visible = false;
			return super.hide( delay );
		}
	}
}