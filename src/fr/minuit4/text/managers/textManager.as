
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.text.managers
{
	
	/**
	 * Un singleton permettant de gérer le texte au sein du projet.
	 * Le textManager offre plusieurs méthodes permettant de formater les TextField, de gérer les TextFormat ainsi
	 * que les StyleSheet.
	 * Les StyleSheet utiliser par le textManager sont des styleSheet avancées, qui permet de modifier toutes les propriétés 
	 * d'un TextField via CSS.
	 */
	public var textManager:TextManager = TextManager.getInstance();
	
}

import flash.text.AntiAliasType;
import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import fr.minuit4.text.styles.AdvancedStyleSheet;

final class TextManager
{
	
	// - PRIVATE VARIABLES -----------------------------------------------------------
	
	private static var _allowInstanciation:Boolean = false;
	private static var _instance:TextManager;
	
	private const DEFAULT_FORMAT:TextFormat = new TextFormat( "_sans", 10, 0x000000 );
	
	private var _formats:Object;
	private var _css:AdvancedStyleSheet;
	
	// - PUBLIC VARIABLES ------------------------------------------------------------
	
	// - CONSTRUCTOR -----------------------------------------------------------------
	
	public function TextManager() 
	{
		if( _allowInstanciation )
		{
			_formats = { };
		}
		else throw new Error( "This class is a Singleton and cannot be instanciated. Please, use the 'getInstance' method instead" );
	}
	
	// - EVENTS HANDLERS -------------------------------------------------------------
	
	// - PRIVATE METHODS -------------------------------------------------------------
	
	private function preformatText( tf:TextField, sharpness:int, thickness:int ):void
	{
		tf.embedFonts = true;
		tf.antiAliasType = AntiAliasType.ADVANCED;
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.selectable = false;
		tf.thickness = thickness;
		tf.sharpness = sharpness;
	}
	
	// - PUBLIC METHODS --------------------------------------------------------------
	
	internal static function getInstance():TextManager
	{
		if( !_instance )
		{
			_allowInstanciation = true; {
				_instance = new TextManager();
			} _allowInstanciation = false;
		}
		return _instance;
	}
	
	/**
	 * Enregistre un TextFormat à la liste de ceux disponibles.
	 * Ce TextFormat pourra par la suite être utilisé via la méthode setText en lui passant son id en paramètre.
	 * @param	id	String	L'identifiant du TextFormat.
	 * @param	format	TextFormat	Le TextFormat à enregistrer.
	 */
	public function registerFormat( id:String, format:TextFormat ):void
	{
		_formats[ id ] = format;
	}
	
	/**
	 * Renvoie un TextFormat précédemment enregistré.
	 * @param	id	String	L'identifiant du TextFormat.
	 * @return	TextFormat
	 */
	public function getFormat( id:String ):TextFormat
	{
		return _formats[ id ];
	}
	
	/**
	 * Indique si oui ou non un TextFormat a été enregistré.
	 * @param	id	String	L'identifiant du TextFormat
	 * @return	Boolean
	 */
	public function hasFormat( id:String ):Boolean
	{
		return ( _formats[ id ] != null );
	}
	
	/**
	 * Parse une CSS et l'utilise dans le textManager.
	 * Il ne peut n'y avoir qu'une seule CSS par projet.
	 * @param	cssContent	String	Le contenu de la CSS à parser.
	 */
	public function parseCSS( cssContent:String ):void
	{
		_css = new AdvancedStyleSheet();
		_css.parseCSS( cssContent );
	}
	
	/**
	 * Enregistre un objet StyleSheet dans le textManager.
	 * Il ne peut n'y avoir qu'une seule CSS par projet.
	 * @param	css	StyleSheet	La StyleSheet à enregistrer.
	 */
	public function registerCSS( css:StyleSheet ):void
	{
		_css = new AdvancedStyleSheet();
		_css.styleSheet = css;
	}
	
	/**
	 * Applique un style à un TextField, afin de la formater de manière plus simple, et plus efficacement.
	 * Les styles attendu sont contenus soit dans la feuille de style préalablement enregistrée, soit via des TextFormat eux aussi préalablement 
	 * enregistrés.
	 * Si jamais l'identifiant de style n'existe pas, un TextFormat par défaut est appliqué, avec comme police "_sans".
	 * L'objet textManager regarde d'abord si le style existe dans la css enregistrée (si css il y a), puis dans les TextFormat enregistrés.
	 * @param	tf	TextField	Le champs texte à formater.
	 * @param	content	String	Le contenu à mettre dans le champs texte.
	 * @param	id	String	L'identifiant du style à appliquer.
	 * @param	sharpness	String	La finesse des lettres.
	 * @param	thickness	String	L'épaisseur des lettres.
	 * @return	Boolean
	 */
	public function setText( tf:TextField, content:String, id:String = null, sharpness:int = -100, thickness:int = -100 ):Boolean
	{
		if ( id )
		{
			if ( _css )
			{
				if ( _css.hasStyle( id ) )
				{
					preformatText( tf, sharpness, thickness );
					_css.format( tf, id );
					tf.htmlText = "<span class='" + id + "'>" + content + "</span>";
					return true;
				}
			}
			
			if ( hasFormat( id ) )
			{
				var format:TextFormat = _formats[ id ];
				preformatText( tf, sharpness, thickness );
				tf.defaultTextFormat = format;
				tf.htmlText = content;
				return true;
			}
		}
		
		tf.selectable = false;
		tf.sharpness = sharpness;
		tf.thickness = thickness;
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.defaultTextFormat = DEFAULT_FORMAT;
		tf.htmlText = content;
		
		return false;
	}
	
	// - GETTERS & SETTERS -----------------------------------------------------------
	
}