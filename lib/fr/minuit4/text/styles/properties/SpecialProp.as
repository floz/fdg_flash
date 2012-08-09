
/**
 * @author Floz
 */
package fr.minuit4.text.styles.properties 
{

	public class SpecialProp
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var name:String;
		public var solver:SpecialPropSolver;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SpecialProp( name:String, solver:SpecialPropSolver ) 
		{
			this.name = name;
			this.solver = solver;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function solve( value:String ):* 
		{
			return solver.solver.apply( null, [ value ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}