
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.utils 
{
	
	public class UText
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static const LOREM_IPSUM:String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function UText() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getLoremIpsum( repeatCount:int = 10, wrap:int = 5 ):String
		{
			var s:String = "";
			for ( var i:int; i < repeatCount; ++i )
			{
				s += LOREM_IPSUM;
				if ( i % wrap == 0 && i != 0 ) 
					s += "\n";
			}
			
			return s;
		}
		
		public static function getFileExtension( fileName:String ):String
		{
			var a:Array = fileName.split( "." );
			return String( a[ int( a.length - 1 ) ] );
		}
		
		/**
		 * Remplace les caractères accentués les plus couramment utilisés par des caractères non accentués.
		 * @param	t	String	Texte à analyser.
		 * @return
		 */
		public static function replace( t:String ):String
		{
			var i:int = t.search( /[àâèéêëêÉÈËÂÁ]/g );
			if ( i >= 0 )
			{
				t = t.replace( /[èéëê]/g, "e").replace( /[ÉÈËÊ]/g, "E" );
				t = t.replace( /[àâ]/g, "a").replace( /[ÂÁ]/g, "A" );
			}
			i = 0;
			
			i = t.search( /[ôöîïùüÖÔÏÎÛÙ]/g );
			if ( i >= 0 )
			{
				t = t.replace( /[ôö]/g, "o").replace( /[ÖÔ]/g, "O" );
				t = t.replace( /[îï]/g, "i").replace( /[ÏÎ]/g, "I" );
				t = t.replace( /[ùü]/g, "u").replace( /[ÛÙ]/g, "U" );
			}
			
			return t;
		}
		
		public static function isMailValid( mail:String ):Boolean
		{
			var regexp:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return regexp.test( mail );
		}
		
		public static function isTextNumber( value:String ):Boolean
		{
			var regexp:RegExp = /^[0-9]*$/i;
			return regexp.test( value );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}