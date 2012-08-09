
/**
 * @author Floz
 * 
 * Version log :
 * 
 * 24/08/10		0.1		- Première version, commentée.
 */
package fr.minuit4.text.managers
{
	/**
	 * Un singleton permettant de gérer les fonts au sein des projets.
	 */
	public var fontManager:FontManager = FontManager.getInstance();
	
}
import flash.text.Font;

final class FontManager
{
	// - PRIVATE VARIABLES -----------------------------------------------------------
	
	private static var _allowInstanciation:Boolean = false;
	private static var _instance:FontManager;
	
	private var _fonts:Object;
	
	// - PUBLIC VARIABLES ------------------------------------------------------------
	
	// - CONSTRUCTOR -----------------------------------------------------------------
	
	public function FontManager() 
	{
		if( _allowInstanciation )
		{
			_fonts = { };
			update();
		}
		else throw new Error( "This is a Singleton, please use getInstance method instead" );
	}
	
	// - EVENTS HANDLERS -------------------------------------------------------------
	
	// - PRIVATE METHODS -------------------------------------------------------------
	
	private function update():void
	{
		var fonts:/*Font*/Array = Font.enumerateFonts();
		var i:int = fonts.length;
		while ( --i > -1 )
			_fonts[ fonts[ i ].fontName ] = fonts[ i ];
	}
	
	// - PUBLIC METHODS --------------------------------------------------------------
	
	internal static function getInstance():FontManager
	{
		if( !_instance )
		{
			_allowInstanciation = true; {
				_instance = new FontManager();
			} _allowInstanciation = false;
		}
		return _instance;
	}
	
	/**
	 * Enregistre une font à la liste de disponible.
	 * @param	font	Class	La Classe de la Font à enregistrer.
	 */
	public function registerFont( font:Class ):void
	{
		Font.registerFont( font );
		update();
	}
	
	/**
	 * Permet de savoir si une font a été enregistrée ou non.
	 * @param	name	String	Le nom de la Font.
	 * @return	Boolean
	 */
	public function hasFont( name:String ):Boolean
	{
		return _fonts[ name ] != null;
	}
	
	/**
	 * Une fonction permettant de tracer toutes les fonts enregistrées.
	 * Cette fonction n'a qu'une utilité de DEBUG.
	 */
	public function traceFonts():void
	{
		trace( "0: fontManager.traceFonts >> BEGINNING" );
		var f:Font;
		var fonts:/*Font*/Array = Font.enumerateFonts();
		var i:int = fonts.length;
		while ( --i > -1 )
		{
			f = fonts[ i ];
			trace( "0: - fontName : " + f.fontName + ", fontStyle : " + f.fontStyle + ", fontType : " + f.fontType );
		}
		trace( "0: fontManager.traceFonts >> END" );
	}
	
	// - GETTERS & SETTERS -----------------------------------------------------------
	
}