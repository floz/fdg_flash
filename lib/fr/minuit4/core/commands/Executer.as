
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.core.commands 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import fr.minuit4.core.commands.events.CommandEvent;
	import fr.minuit4.core.commands.interfaces.IProgressableCommand;
	import fr.minuit4.core.interfaces.IDisposable;
	
	// TODO: Remplacer le CommandEvent.COMPLETE et le CommandEvent.PROGRESS par Event.COMPLETE et ProgressEvent.PROGRESS
	public class Executer extends ProgressableCommand implements IDisposable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _commandsById:Dictionary;
		protected var _idsByCommand:Dictionary;
		protected var _commands:/*IProgressableCommand*/Array;
		
		protected var _currentCommand:IProgressableCommand;
		
		protected var _idCount:int;
		protected var _loadIdx:int = -1;
		
		protected var _autoExec:Boolean = true;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Executer() 
		{
			_commandsById = new Dictionary( true );
			_idsByCommand = new Dictionary();
			_commands = [];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function commandProgressHandler(e:CommandEvent):void 
		{
			var currentProgressCount:Number = e.progressCount;
			dispatchEvent( new CommandEvent( CommandEvent.PROGRESS, _progressCount + currentProgressCount, _estimatedCount ) );
		}
		
		private function commandCompleteHandler(e:CommandEvent):void 
		{
			_progressCount += _currentCommand.estimatedCount;
			_currentCommand.removeEventListener( CommandEvent.PROGRESS, commandProgressHandler );
			_currentCommand.removeEventListener( CommandEvent.COMPLETE, commandCompleteHandler );
			dispatchEvent( new CommandEvent( CommandEvent.COMMAND_COMPLETE ) );
			
			if ( _autoExec ) 
				next();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function next():void
		{
			++_loadIdx;
			if ( _loadIdx < _commands.length )
			{
				_currentCommand = _commands[ _loadIdx ];
				_currentCommand.addEventListener( CommandEvent.PROGRESS, commandProgressHandler, false, 0, true );
				_currentCommand.addEventListener( CommandEvent.COMPLETE, commandCompleteHandler, false, 0, true );
				_currentCommand.execute();
			}
			else dispatchEvent( new CommandEvent( CommandEvent.COMPLETE ) );
		}
		
		protected function calculateEstimatedCount():void
		{
			_estimatedCount = 0;
			
			var i:int = _commands.length;
			while ( --i > -1 )
				_estimatedCount += _commands[ i ].estimatedCount;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addCommand( command:IProgressableCommand, id:String = null ):void
		{
			if ( !id )
				id = "default" + _idCount;
			
			_commands[ _commands.length ] = command;
			_commandsById[ id ] = command;
			_idsByCommand[ command ] = id;
			
			++_idCount;
		}		
		
		public function removeCommand( command:IProgressableCommand ):void
		{
			var idx:int = _commands.indexOf( command );
			if ( idx >= 0 )
			{
				_commands.splice( command, 1 );
				
				var id:String = _idsByCommand[ command ];
				_idsByCommand[ command ] = null;
				delete( _idsByCommand[ command ] );
				
				var command:IProgressableCommand = _commandsById[ id ];
				_commandsById[ id ] = null;
				delete( _commandsById[ id ] );
				
				if ( command is IDisposable )
					IDisposable( command ).dispose();
			}
		}
		
		public function removeCommandById( id:String ):void
		{
			removeCommand( _commandsById[ id ] );
		}
		
		public function getCommand( idx:int ):IProgressableCommand
		{
			return _commands[ idx ];
		}
		
		public function getCommandById( id:String ):IProgressableCommand
		{
			return _commandsById[ id ];
		}
		
		override public function execute():void
		{
			calculateEstimatedCount();
			next();
		}
		
		public function start():void
		{
			execute();
		}
		
		public function stop():void
		{
			// TODO
		}
		
		public function dispose():void
		{
			var c:IProgressableCommand;
			for each( c in _commandsById )
				removeCommand( c );
			
			_commandsById = null;
			_idsByCommand = null;
			_commands = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get autoExec():Boolean { return _autoExec; }
		
		public function set autoExec(value:Boolean):void 
		{
			_autoExec = value;
		}
		
		public function get currentCommand():IProgressableCommand { return _currentCommand; }
		
		override public function get estimatedCount():Number 
		{ 
			calculateEstimatedCount();
			return _estimatedCount;
		}
		
		public function get loadedCommands():int { return _loadIdx > 0 ? _loadIdx : 0; }
		
		public function get totalCommands():int { return _commands.length; }
		
		
	}
	
}