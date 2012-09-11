/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui.viewall 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import aze.motion.easing.Expo;
	import aze.motion.eaze;

	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.Graphics;
	import flash.display.Shape;

	public class ViewAllTooltip extends ModulePart
	{
		private var _cnt:Sprite;
		private var _bg:Shape;
		private var _tf:Text;
		
		private var _size:Number = 0;
		
		public function ViewAllTooltip()
		{
			addChild( _cnt = new Sprite() );
			_cnt.addChild( _bg = new Shape() );
			_cnt.addChild( _tf = new Text( "", "view_all_tooltip" ) );
			_tf.x = 15;
			_tf.y = 8;
			
			addEventListener( Event.ENTER_FRAME, _enterFrameHandler );
			
			this.mouseEnabled = 
			this.mouseChildren = false;
			
			_cnt.alpha = 0;
		}

		private function _enterFrameHandler( event:Event ):void
		{
			if( parent == null )
				return;
			
			this.x += ( parent.mouseX - this.x ) * .98 + 50;
			this.y += ( parent.mouseY - this.y ) * .98 - 20;
		}
		
		public function setTitle( title:String ):void
		{
			_tf.text = title;
			eaze( this ).to( .2, { size: _tf.width + 60 } );
		}
		
		private function _draw():void
		{
			var g:Graphics = _bg.graphics;
			g.clear();
			g.beginFill( 0x53cecf );
			g.moveTo( 0, 0 );
			g.lineTo( _size, 0 );
			g.lineTo( _size - 30, 30 );
			g.lineTo( -30, 30 );	
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			eaze( _cnt ).delay( delay ).to( .25, { alpha: 1 } ).easing( Expo.easeOut );
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			eaze( _cnt ).delay( delay ).to( .25, { alpha: 0 } );
			return super.hide( delay );
		}
		
		public function get size():Number { return _size; }
		public function set size( value:Number ):void
		{
			this._size = value;
			_draw();
		}
	}
}