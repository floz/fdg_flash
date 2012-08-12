
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 * 
 * TODO: Laisser la possibilité d'ajouter des éléments à la liste des objets à charger
 */
package fr.minuit4.core.configuration 
{
	
	public const conf:Conf = Conf.getInstance();
	
}
import fr.minuit4.core.commands.events.CommandEvent;
import fr.minuit4.core.commands.interfaces.IProgressableCommand;
import fr.minuit4.net.loaders.AbstractLoader;
import fr.minuit4.net.loaders.AssetLoader;
import fr.minuit4.net.loaders.DataLoader;
import fr.minuit4.net.loaders.MassLoader;
import fr.minuit4.text.managers.fontManager;
import fr.minuit4.text.managers.textManager;
import fr.minuit4.utils.UText;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.system.ApplicationDomain;

final class Conf extends EventDispatcher
{
	
	// - PRIVATE VARIABLES -----------------------------------------------------------
	
	private static var _allowInstanciation:Boolean;
	private static var _instance:Conf;
	
	private var _dataLoader:DataLoader;
	
	private var _confXML:XML;
	private var _preloader:MassLoader;
	
	// - PUBLIC VARIABLES ------------------------------------------------------------
	
	public var pathXML:String = "";
	public var pathSWF:String = "";
	public var pathIMG:String = "";
	public var pathCSS:String = "";
	
	// - CONSTRUCTOR -----------------------------------------------------------------
	
	public function Conf() 
	{
		if ( !_allowInstanciation ) throw new Error( "This is a singleton, use getInstance method instead" );
		_preloader = new MassLoader();
	}
	
	// - EVENTS HANDLERS -------------------------------------------------------------
	
	private function completeHandler(e:Event):void 
	{
		_confXML = XML( _dataLoader.content );
		_dataLoader.removeEventListener( Event.COMPLETE, completeHandler );
		_dataLoader.dispose();
		
		fillPaths();
		fillPreloader();
		executePreloader();
	}
	
	private function preloaderProgressHandler(e:CommandEvent):void 
	{
		dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, e.progressCount, e.totalCount ) );
	}
	
	private function preloaderCompleteHandler(e:CommandEvent):void 
	{
		_preloader.removeEventListener( ProgressEvent.PROGRESS, dispatchEvent );
		_preloader.removeEventListener( Event.COMPLETE, preloaderCompleteHandler );
		
		if ( _preloader.getCommandById( "stylesheet" ) ) textManager.parseCSS( DataLoader( _preloader.getCommandById( "stylesheet" ) ).content );
		registerFonts();
		
		dispatchEvent( new Event( Event.COMPLETE ) );
	}
	
	// - PRIVATE METHODS -------------------------------------------------------------
	
	private function fillPaths():void
	{
		if ( !_confXML.paths[ 0 ] )
			return;
		
		if ( _confXML.paths.xml[ 0 ] ) pathXML = _confXML.paths.xml[ 0 ].toString();
		if ( _confXML.paths.swf[ 0 ] ) pathSWF = _confXML.paths.swf[ 0 ].toString();
		if ( _confXML.paths.img[ 0 ] ) pathIMG = _confXML.paths.img[ 0 ].toString();
		if ( _confXML.paths.css[ 0 ] ) pathCSS = _confXML.paths.css[ 0 ].toString();
	}
	
	private function fillPreloader():void
	{
		var x:XML;
		for each( x in _confXML.preload.item )
			_preloader.addItem( addPath( x.toString() ), x.@id.toString() );
		
		for each( x in _confXML.fonts.item )
			_preloader.addItem( addPath( x.url[ 0 ].toString() ), x.@id.toString() );
		
		if ( _confXML.stylesheet )
			_preloader.addItem( addPath( _confXML.stylesheet ), "stylesheet" );
	}
	
	private function addPath( url:String ):String
	{
		var ext:String = UText.getFileExtension( url );
		switch( ext )
		{
			case "xml": url = pathXML + url; break;
			case "swf": url = pathSWF + url; break;
			case "jpg":
			case "gif":
			case "png": url = pathIMG + url; break;
			case "css": url = pathCSS + url; break;
		}
		return url;
	}
	
	private function executePreloader():void
	{
		if ( _preloader.totalCommands > 0 )
		{
			_preloader.addEventListener( CommandEvent.PROGRESS, preloaderProgressHandler, false, 0, true );
			_preloader.addEventListener( CommandEvent.COMPLETE, preloaderCompleteHandler, false, 0, true );
			_preloader.execute();
		}
		else 
		{
			_preloader.dispose();
			_preloader = null;
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
	
	private function registerFonts():void
	{
		var loader:AssetLoader;
		var domain:ApplicationDomain;
		
		var x1:XML, x2:XML;
		for each( x1 in _confXML.fonts.item )
		{
			loader = _preloader.getCommandById( x1.@id.toString() ) as AssetLoader;
			domain = loader.loader.contentLoaderInfo.applicationDomain;
			for each( x2 in x1.classId ) 
				fontManager.registerFont( Class( domain.getDefinition( x2.toString() ) ) );
		}
		
		fontManager.traceFonts();
	}
	
	// - PUBLIC METHODS --------------------------------------------------------------
	
	public static function getInstance():Conf
	{
		if ( !_instance )
		{
			_allowInstanciation = true; {
				_instance = new Conf();
			} _allowInstanciation = false;
		}
		
		return _instance;
	}
	
	public function load( url:String ):void
	{
		_dataLoader = new DataLoader( url );
		_dataLoader.addEventListener( Event.COMPLETE, completeHandler, false, 0, true );
		_dataLoader.load();
	}
	
	public function addPreloadCommand( command:IProgressableCommand, id:String ):void 
	{
		_preloader.addCommand( command, id );
	}
	
	public function getItem( id:String ):AbstractLoader
	{
		return _preloader.getCommandById( id ) as AbstractLoader;
	}
	
	// - GETTERS & SETTERS -----------------------------------------------------------
	
	public function get datas():XML { return _confXML; }
}