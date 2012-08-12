
/**
 * @author Floz
 */
package fr.minuit4.text.styles 
{
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	// TODO: Ajouter un trace si jamais la propriété mise dans le css n'existe pas
	// TODO: Penser une implémentation des filters, ex: filter: dropShadowFilter(strength=3, blabla=3)
	public class AdvancedStyleSheet
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _css:StyleSheet;
		
		private var _styles:Object;
		private var _extendableIds:/*String*/Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AdvancedStyleSheet() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function parseStyles():void
		{
			_styles = { };
			_extendableIds = [];
			
			var id:String;
			var names:Array = _css.styleNames;
			
			var n:int = names.length;
			for ( var i:int; i < n; ++i )
			{
				id = names[ i ];
				if( id.search( ">" ) == -1 )
					_styles[ stripDot( names[ i ] ) ] = new Style( _css.getStyle( names[ i ] ) );
				else
					_extendableIds[ _extendableIds.length ] = id;
			}
			
			parseExtendables();
		}
		
		private function parseExtendables():void
		{
			var styleProps:Object, tmpProps:Object;
			
			var extendablesLefts:/*String*/Array = _extendableIds;
			var tmp:Array;
			
			var style:Style;
			var id:String, propName:String;
			var ids:/*String*/Array;
			var i:int, n:int = _extendableIds.length;
			
			while ( extendablesLefts.length ) // Ya surement moyen d'optimiser toussa... :)
			{
				tmp = [];
				for ( i = 0; i < n; ++i )
				{
					styleProps = { };
					
					id = _extendableIds[ i ];
					ids = id.split( ">" );
					
					style = _styles[ stripDot( ids[ 0 ] ) ];
					if ( style )
					{
						// On récupère le premier style.
						// Etant donné que le premier style est enregistré dans l'objet "_styles", parce qu'il a précédemment été parsé, on se réfère à
						// cet objet, et non pas à _css.getStyle, puisque les styles "enfant" ne sont pas réellement présent dedans.
						// Ils le sont, en revanche, dans "_styles".
						tmpProps = style.props;
						for ( propName in tmpProps )
							styleProps[ propName ] = tmpProps[ propName ];
						
						// On récupère le style complet dans la css, exemple : ".parent>.enfant"
						tmpProps = _css.getStyle( id );
						for ( propName in tmpProps )
							styleProps[ propName ] = tmpProps[ propName ];
						
						// On enregistre un nouveau style dans la css, pour que, quand on utilisera textManager.setText( tf, content, "enfant" ), "enfant" existe.
						// De base, "enfant" n'existe pas, c'est "parent>.enfant" qui existe... Ce qui ne nous convient pas.
						_css.setStyle( ids[ 1 ], styleProps );
						// Et du coup, on enregistre "enfant".
						_styles[ stripDot( ids[ 1 ] ) ] = new Style( styleProps );
					}
					else tmp[ tmp.length ] = _extendableIds[ i ];
				}
				extendablesLefts = tmp;
			}
		}
		
		private function stripDot( id:String ):String
		{
			if ( id.charAt( 0 ) == "." )
				return id.substr( 1 );
			
			return id.toLowerCase();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function parseCSS( cssContent:String ):void
		{
			_css = new StyleSheet();
			_css.parseCSS( cssContent );
			
			parseStyles();
		}
		
		public function format( tf:TextField, id:String ):void
		{
			id = stripDot( id );
			var style:Style = _styles[ id ];
			if ( style != null )
				style.apply( tf );
			
			tf.styleSheet = _css;
		}
		
		public function hasStyle( id:String ):Boolean
		{
			return( _styles[ stripDot( id ) ] != null );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get styleNames():Array { return _css.styleNames; }
		
		public function get styleSheet():StyleSheet { return _css; }
		
		public function set styleSheet( value:StyleSheet ):void 
		{
			_css = value;
			parseStyles();
		}
		
	}
	
}