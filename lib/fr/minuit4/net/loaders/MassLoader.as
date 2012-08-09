
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.net.loaders 
{
	import fr.minuit4.core.commands.Executer;
	import fr.minuit4.core.commands.interfaces.IProgressableCommand;
	import fr.minuit4.utils.UText;
	
	public class MassLoader extends Executer
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MassLoader() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addItem( commandUrl:String, id:String = null ):Boolean
		{
			if ( commandUrl == "" || commandUrl == null )
				return false;
			
			var command:IProgressableCommand;
			var fileExt:String = UText.getFileExtension( commandUrl );
			switch( fileExt )
			{
				case "jpg":
				case "jpeg":
				case "png":
				case "gif":
				case "swf": command = new AssetLoader( commandUrl ); break;
				
				case "xml":
				case "txt":
				case "css": command = new DataLoader( commandUrl ); break;
				
				default: trace( "2:Alerte -> Format de fichier '" + fileExt + "' pas pris en charge par 'createCommand' : " + commandUrl ); break;
			}
			
			if ( command )
			{
				addCommand( command, id );
				return true;
			}
			return false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}