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
		
		private var _shown:Boolean;
		
		public function WorkMenu()
		{
			_items = new Vector.<WorkMenuItem>();
			
			var px:int;
			var wmi:WorkMenuItem;
			var list:XMLList = _.data.works.rub;
			var n:int = list.length();
			for( var i:int; i < n; i++ )
			{
				wmi = new WorkMenuItem( list[ i ].@id.toString() );
				wmi.x = px;
				addChild( wmi );
				
				px += wmi.width - 28;
			}
			
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
			if( _shown )
				return 0;
			_shown = true;
			
			_onResize();
			
			var d:Number = 0;
			var i:int = numChildren;
			while( --i > -1 )
			{
				WorkMenuItem( getChildAt( i ) ).show( d );
				d += .1;	
			}
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			if( !_shown )
				return 0;
			_shown = false;
			
			var d:Number = 0;
			var n:int = numChildren;
			for( var i:int; i < n; i++ )
			{
				WorkMenuItem( getChildAt( i ) ).hide( d );
				d += .1;	
			}
			return super.hide( delay );
		}
	}
}