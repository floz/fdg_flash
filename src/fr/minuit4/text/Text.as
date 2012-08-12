
/**
 * @author Floz
 */
package fr.minuit4.text 
{
	import fr.minuit4.bouboup;
	import fr.minuit4.text.managers.textManager;

	import flash.text.TextField;
	import flash.text.TextFormat;
	
	use namespace bouboup;
	
	public class Text extends TextField
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _firstValue:String;
		private var _styleId:String;
		private var _sharpness:int;
		private var _thickness:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Objet TextField simplifié, et avancé.
		 * L'objet Text est directement lié au textManager
		 * @param	value	String	Le contenu texte
		 * @param	styleId	String	Le nom du style à appliquer (TextFormat précédemment enregistré ou style au sein d'une feuille de style enregistrée)
		 * @param	sharpness	int	Affinage
		 * @param	thickness	int Epaisseur
		 */
		public function Text( value:String = "", styleId:String = null, sharpness:int = 0, thickness:int = 0 ) 
		{
			_firstValue = value;
			_styleId = styleId;
			_sharpness = sharpness;
			_thickness = thickness;
			
			text = value;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function applyTextFormatProperty( propName:String, value:* ):void
		{
			var format:TextFormat = getTextFormat();
			format[ propName ] = value;
			defaultTextFormat = format;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/** L'espacement entre les lignes */
		public function get leading():int { return int( getTextFormat().leading ); };
		public function set leading( value:int ):void
		{
			applyTextFormatProperty( "leading", value );
		}
		
		/** L'espacement entre les lettres */
		public function get letterSpacing():Number { return Number( getTextFormat().letterSpacing ); }
		public function set letterSpacing( value:Number ):void
		{
			applyTextFormatProperty( "letterSpacing", value );
		}
		
		/**
		 * Réassigne le contenu du texte en appliquant tous ses paramètres de style.
		 * @param	content	String	Le contenu à mettre dans le TextField.	
		 */
		override public function get text():String { return super.text; }		
		override public function set text(value:String):void 
		{
			textManager.setText( this, value, _styleId, _sharpness, _thickness );
		}
		
	}

}