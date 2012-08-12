
/**
 * @author Floz
 */
package fr.minuit4.text.styles 
{
	import flash.text.TextField;
	import fr.minuit4.text.styles.properties.SpecialProp;
	import fr.minuit4.text.styles.properties.SpecialPropSolver;

	public class Style
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _specialProps:/*SpecialProp*/Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var props:Object;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Style( props:Object ) 
		{
			this.props = props;
			parseProps();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function parseProps():void
		{
			_specialProps = [];
			
			var solver:SpecialPropSolver;
			
			var s:String;
			for ( s in props )
			{
				solver = SpecialPropSolver.getSolver( s );
				if ( solver )
					_specialProps[ _specialProps.length ] = new SpecialProp( s, solver );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Applique le style à un TextField.
		 * @param	tf	TextField	L'objet qui va être stylisé.
		 */
		public function apply( tf:TextField ):void
		{
			var specialProp:SpecialProp;
			var i:int = _specialProps.length;
			while ( --i > -1 )
			{
				specialProp = _specialProps[ i ];
				tf[ specialProp.name ] = specialProp.solve( props[ specialProp.name ] );
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}