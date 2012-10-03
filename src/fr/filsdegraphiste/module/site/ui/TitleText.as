/**
 * @author floz
 */
package fr.filsdegraphiste.module.site.ui 
{
	import aze.motion.easing.Quint;
	import aze.motion.eaze;

	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class TitleText extends ModulePart
	{
		private var _label:String;
		private var _styleId:String;
		private var _hasLine:Boolean;
		private var _bgMaskColor:uint;
		
		private var _cntTitle:Sprite;
		private var _cntLetters:Sprite;
		private var _mask:Shape;
		private var _line:Line;
		private var _letters:Vector.<Text>;
		
		private var _shown:Boolean;
		
		public function TitleText( label:String, styleId:String, hasLine:Boolean = true, bgMaskColor:uint = 0xffffff )
		{
			_label = label;
			_styleId = styleId;
			_hasLine = hasLine;
			_bgMaskColor = bgMaskColor;
			
			_initLetters();
			if( _hasLine )
				_initLine();
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
				letter = new Text( _label.charAt( i ).toLowerCase(), _styleId );
				letter.x = px;
				letter.y = -130;
				letter.cacheAsBitmap = true;
				_letters[ i ] = letter;
				_cntLetters.addChild( letter );
				
				px += letter.width;
			}
			
			var g:Graphics = _mask.graphics;
			g.beginFill( 0xff00ff, 1 );
			g.drawRect( 0, -10, _cntLetters.width, 140 );
			_cntLetters.mask = _mask;
			_mask.y = 20;
		}
		
		private function _initLine():void
		{
			addChild( _line = new Line( _bgMaskColor ) );
			_line.x = _cntTitle.x + _cntTitle.width - 35 >> 0;
			_line.y = _cntTitle.y + 39;
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
									 .to( .3, { y: 5 } ).easing( Quint.easeOut );
			}
			if( _line != null )
				_line.show( delay );
		
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
									 .to( .3, { y: -130 } ).easing( Quint.easeIn );
				j++;
			}
			if( _line != null )
				_line.hide( delay + .2 );
						
			return super.hide( delay );
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
	private var _bgMaskColor:uint;
	private var _bg:Shape;
	private var _s:Shape;
	private var _percent:Number = 0;
	
	private var _show:Boolean;
	
	public function Line( bgMaskColor:uint )
	{
		_bgMaskColor = bgMaskColor;
		
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
			g.beginFill( _bgMaskColor );
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
			g.beginFill( _bgMaskColor );
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