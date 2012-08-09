<?php

define( "DIR_PROJECTS", "images/projects/" );
define( "DIR_PROJECTS_FROM_PHP", "./../".DIR_PROJECTS );

function getProjects()
{
	$result = array();

	$news = array();

	$result[ "projects" ] = array();
	$result[ "projects" ] = getProjectsFromFolder( $result[ "projects" ], $news, DIR_PROJECTS_FROM_PHP );
	$result[ "projects" ][ "news" ] = $news;

	foreach( $result[ "projects" ] as $projectName=>$list )
	{
		$list[ "files_to_load" ] = array();
		grabFilesToLoad( $list );
		$result[ "projects" ][ $projectName ] = $list;
	}

	return $result;
}

function getProjectsFromFolder( $result, &$news, $dir )
{
	$json = null;

	$files = scandir( $dir );
	while( $file = array_shift( $files ) )
	{
		if( $file == "." || $file == ".." )
			continue;

		if( is_dir( $dir.$file ) )
		{
			$result[ $file ] = array();
			$result[ $file ] = getProjectsFromFolder( $result[ $file ], $news, $dir.$file."/", $file );
		}
		else
		{
			switch( pathinfo( $file, PATHINFO_EXTENSION ) )
			{
				case "jpg":
				case "png":
					if( pathinfo( $file, PATHINFO_FILENAME ) == "preview" )
					{
						$result[ "preview" ] = substr( $dir, 3 ).$file;
						break;
					}

					if( !isset( $result[ "images" ] ) )
						$result[ "images" ] = array();

					array_push( $result[ "images" ], substr( $dir, 3 ).$file );
					break;
				case "json":
					$json = file_get_contents( $dir.$file );
					$json = htmlentities( stripslashes( $json ), ENT_NOQUOTES );
					$json = json_decode( $json, TRUE );

					foreach( $json as $key=>$value )
					{
						$result[ $key ] = $value;
					}
					
					break;
			}
		}
	}
	if( isset( $result[ "new" ] ) && $result[ "new" ] == true )
	{
		array_push( $news, $result );
	}
	
	return $result;
}

function grabFilesToLoad( &$projects )
{
	foreach( $projects as $key=>$value )
	{
		if( $key === "files_to_load" )
			continue;

		if( isset( $value[ "title" ] ) )
		{
			addFilesToLoad( $projects, $value );
		}
		else
		{
			foreach( $value as $name=>$data )
				addFilesToLoad( $projects, $data );
		}
	}
}

function addFilesToLoad( &$projects, $value )
{
	array_push( $projects[ "files_to_load" ], $value[ "preview" ] );
	//$n = count( $value[ "images" ] );
	//for( $i = 0; $i < $n; $i++ )
	//	array_push( $projects[ "files_to_load" ], $value[ "images" ][ $i ] );
	array_push( $projects[ "files_to_load" ], $value[ "images" ][ 1 ] );
	array_push( $projects[ "files_to_load" ], $value[ "images" ][ count( $value[ "images" ] ) - 1 ] );
}

$result = array();
$result[ "message" ] = "error";

//$action = $_GET[ "action" ];
$action = $_POST[ "action" ];
switch( $action )
{
	case "get_projects": 
		$result[ "message" ] = "success";
		$result[ "result" ] = getProjects();
		break;
}

header( "content-type:application/json" );
echo json_encode( $result );
exit();

?>