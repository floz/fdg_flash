/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui 
{
	import aze.motion.easing.Quadratic;
	import aze.motion.eaze;

	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class MaskedText extends ModulePart
	{
		private var _texts:Vector.<Text>;
		
		public function MaskedText( label:String, styleId:String, forcedWidth:int = -1 )
		{
			_texts = new Vector.<Text>();
			
			var cnt:Sprite;
			var t:Text;
			var m:Shape;
			var g:Graphics;
			
			var py:int = 0;
			var newLine:Boolean = true;
			var forceNewLine:Boolean = false;
			
			var words:Array = label.split( " " );
			var n:int = words.length;
			for( var i:int; i < n; i++ )
			{
				if( newLine == true )
				{
					addChild( cnt = new Sprite() );
					cnt.y = py;
					
					cnt.addChild( t = new Text( "", styleId ) );
					cnt.addChild( m = new Shape() );
					t.alpha = 0;
					t.mask = m;
					
					i--;
					_texts[ _texts.length ] = t;
					
					newLine = false;
				}
				else
				{
					if( words[ i ] != "%%" )
					{
						t.text += words[ i ] + " ";						
					}
					else
					{
						forceNewLine = true;
						py += 4;
					}
					
					if( forceNewLine || ( forcedWidth != -1 && t.width > forcedWidth ) )
					{						
						g = m.graphics;
						g.clear();
						g.beginFill( 0x0000ff * Math.random(), .1 );
						g.drawRect( 0, 0, t.width, t.height );
						
						py += t.height;
						newLine = true;
						forceNewLine = false;
					}
				}				
			}
			
			g = m.graphics;
			g.clear();
			g.beginFill( 0xff00ff, .1 );
			g.drawRect( 0, 0, t.width, t.height );
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			var d:Number = 0;
			
			var t:Text;
			var n:int = _texts.length;
			for( var i:int; i < n; i++ )
			{
				t = _texts[ i ];
				t.y += t.height;
				eaze( t ).delay( delay + d ).to( .4, { y: 0, alpha: 1 } );
				
				d += .1;				
			}
			
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			var d:Number = 0;
			
			var t:Text;
			var n:int = _texts.length;
			for( var i:int; i < n; i++ )
			{
				t = _texts[ i ];
				eaze( t ).delay( delay + d ).to( .4, { y: t.height, alpha: 0 } ).easing( Quadratic.easeIn );
				
				d += .1;				
			}
			
			return d + .3;
		}
	}
}