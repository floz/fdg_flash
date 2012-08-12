
/**
 * @author Floz
 */
package fr.minuit4.text.styles.properties 
{

	public class SpecialPropSolver
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const PROPS:Object = { };
		
		public static const ALPHA:SpecialPropSolver = new SpecialPropSolver( "alpha", numberSolver );
		public static const ALWAYS_SHOW_SELECTION:SpecialPropSolver = new SpecialPropSolver( "alwaysShowSelection", booleanSolver );
		public static const ANTI_ALIAS_TYPE:SpecialPropSolver = new SpecialPropSolver( "antiAliasType", stringSolver );
		public static const AUTO_SIZE:SpecialPropSolver = new SpecialPropSolver( "autoSize", stringSolver );
		public static const BACKGROUND:SpecialPropSolver = new SpecialPropSolver( "background", booleanSolver );
		public static const BACKGROUND_COLOR:SpecialPropSolver = new SpecialPropSolver( "backgroundColor", uintSolver );
		public static const BLEND_MODE:SpecialPropSolver = new SpecialPropSolver( "blendMode", stringSolver );
		public static const BORDER:SpecialPropSolver = new SpecialPropSolver( "border", booleanSolver );
		public static const BORDER_COLOR:SpecialPropSolver = new SpecialPropSolver( "borderColor", uintSolver );
		public static const CACHE_AS_BITMAP:SpecialPropSolver = new SpecialPropSolver( "cacheAsBitmap", booleanSolver );
		public static const CONDENSE_WHITE:SpecialPropSolver = new SpecialPropSolver( "condenseWhite", booleanSolver );
		public static const DISPLAY_AS_PASSWORD:SpecialPropSolver = new SpecialPropSolver( "displayAsPassword", booleanSolver );
		public static const EMBED_FONTS:SpecialPropSolver = new SpecialPropSolver( "embedFonts", booleanSolver );
		public static const HEIGHT:SpecialPropSolver = new SpecialPropSolver( "height", numberSolver );
		public static const LENGTH:SpecialPropSolver = new SpecialPropSolver( "length", intSolver );
		public static const MAX_CHARS:SpecialPropSolver = new SpecialPropSolver( "maxChars", intSolver );
		public static const MAX_SCROLL_H:SpecialPropSolver = new SpecialPropSolver( "maxScrollH", intSolver );
		public static const MAX_SCROLL_V:SpecialPropSolver = new SpecialPropSolver( "maxScrollV", intSolver );
		public static const MULTILINE:SpecialPropSolver = new SpecialPropSolver( "multiline", booleanSolver );
		public static const NUM_LINES:SpecialPropSolver = new SpecialPropSolver( "numLines", booleanSolver );
		public static const RESTRICT:SpecialPropSolver = new SpecialPropSolver( "restrict", stringSolver );
		public static const ROTATION:SpecialPropSolver = new SpecialPropSolver( "rotation", numberSolver );
		public static const ROTATION_X:SpecialPropSolver = new SpecialPropSolver( "rotationX", numberSolver );
		public static const ROTATION_Y:SpecialPropSolver = new SpecialPropSolver( "rotationY", numberSolver );
		public static const ROTATION_Z:SpecialPropSolver = new SpecialPropSolver( "rotationZ", numberSolver );
		public static const SCALE:SpecialPropSolver = new SpecialPropSolver( "scale", numberSolver );
		public static const SCALE_X:SpecialPropSolver = new SpecialPropSolver( "scaleX", numberSolver );
		public static const SCALE_Y:SpecialPropSolver = new SpecialPropSolver( "scaleY", numberSolver );
		public static const SCALE_Z:SpecialPropSolver = new SpecialPropSolver( "scaleZ", numberSolver );
		public static const SCROLL_H:SpecialPropSolver = new SpecialPropSolver( "scrollH", intSolver );
		public static const SCROLL_V:SpecialPropSolver = new SpecialPropSolver( "scrollV", intSolver );
		public static const SELECTABLE:SpecialPropSolver = new SpecialPropSolver( "selectable", booleanSolver );
		public static const SHARPNESS:SpecialPropSolver = new SpecialPropSolver( "sharpness", numberSolver );
		public static const TEXT_HEIGHT:SpecialPropSolver = new SpecialPropSolver( "textHeight", numberSolver );
		public static const TEXT_WIDTH:SpecialPropSolver = new SpecialPropSolver( "textWidth", numberSolver );
		public static const THICKNESS:SpecialPropSolver = new SpecialPropSolver( "thickness", numberSolver );
		public static const TYPE:SpecialPropSolver = new SpecialPropSolver( "type", stringSolver );
		public static const VISIBLE:SpecialPropSolver = new SpecialPropSolver( "visible", booleanSolver );
		public static const WIDTH:SpecialPropSolver = new SpecialPropSolver( "width", numberSolver );
		public static const WORD_WRAP:SpecialPropSolver = new SpecialPropSolver( "wordWrap", booleanSolver );
		public static const X:SpecialPropSolver = new SpecialPropSolver( "x", numberSolver );
		public static const Y:SpecialPropSolver = new SpecialPropSolver( "y", numberSolver );
		public static const Z:SpecialPropSolver = new SpecialPropSolver( "z", numberSolver );
		
		public var name:String;
		public var solver:Function;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SpecialPropSolver( name:String, solver:Function ) 
		{
			this.name = name;
			this.solver = solver;
			
			PROPS[ name ] = this;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function intSolver( value:String ):int
		{
			if ( value.charAt( 0 ) == "#" )
				value = "0x" + value.substr( 1 );
			
			return parseInt( value );
		}
		
		private static function uintSolver( value:String ):uint
		{
			if ( value.charAt( 0 ) == "#" )
				value = "0x" + value.substr( 1 );
			
			return parseInt( value );
		}
		
		private static function numberSolver( value:String ):Number
		{
			return parseFloat( value );
		}
		
		private static function booleanSolver( value:String ):Boolean
		{
			return ( value == "true" || value == "1" );
		}
		
		private static function stringSolver( value:String ):String
		{
			return value;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getSolver( propName:String ):SpecialPropSolver { return PROPS[ propName ]; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}