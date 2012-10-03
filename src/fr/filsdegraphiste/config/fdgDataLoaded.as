/**
* @author floz
*/
package fr.filsdegraphiste.config 
{
	public const fdgDataLoaded:FDGDataLoaded = new FDGDataLoaded();
}

import flash.display.BitmapData;
class FDGDataLoaded 
{
	private var _dataLoaded:Object;
	
	public function FDGDataLoaded()
	{
		reset();
	}
	
	public function add( url:String, content:BitmapData ):void
	{
		_dataLoaded[ url ] = content;	
	}
	
	public function getImage( url:String ):BitmapData
	{
		trace( _dataLoaded[ url ] );
		return _dataLoaded[ url ];
	}
	
	public function reset():void
	{
		// todo: dispose bd
		_dataLoaded = {};	
	}
}