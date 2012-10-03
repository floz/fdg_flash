/**
* @author floz
*/
package fr.filsdegraphiste.config 
{
	public class FDGData 
	{
		//private var _data:Object;
		private var _data:XML;
		
		public var projects:XML;
		public var works:XML;
		public var lab:XML;
		public var news:XML;
		
		public function FDGData( data:XML )
		{
			_data = data;
			
			var i:int, n:int;
			var result:XMLList;			
			
			this.projects = _data[ "projects" ][ 0 ];
			
			this.works = projects.rub.( @id == "works" )[ 0 ];
			this.works.appendChild( generateFilesToLoad( works..project ) );
			generateFilesToLoadForProjects( works );
			
			this.lab = projects.rub.( @id == "lab" )[ 0 ];
			this.lab.appendChild( generateFilesToLoad( lab..project ) );
			generateFilesToLoadForProjects( lab );
			
			this.news = XML( "<rub id='news'></rub>" );
			
			var tmpNews:XMLList = projects.rub.( @id == "news" ).project;
			n = tmpNews.length();
			for( i = 0; i < n; i++ )
			{
				result = works..project.( @id == tmpNews[ i ].@id );
				if( result.length() > 0 )
				{
					this.news.appendChild( result[ 0 ] );
					continue;
				}
				
				result = lab..project.( @id == tmpNews[ i ].@id );
				if( result.length() > 0 )
				{
					this.news.appendChild( result[ 0 ] );
				}
			}
			
			this.news.appendChild( generateFilesToLoad( news..project ) );
			
			this.projects.rub.( @id == "news" )[ 0 ] = this.news;
		}
		
		private function generateFilesToLoad( projects:XMLList ):XML
		{
			var filesToLoad:XML = XML( "<files_to_load></files_to_load>" );
			
			var n:int = projects.length();
			for( var i:int = 0; i < n; i++ )
			{
				filesToLoad.appendChild( XML( "<image>" + projects[ i ].preview[ 0 ] + "</image>" ) );
				filesToLoad.appendChild( XML( "<image>" + projects[ i ].elements.element.( @type == "image" )[ 1 ] + "</image>" ) );
				filesToLoad.appendChild( XML( "<image>" + projects[ i ].elements.element.( @type == "image" )[ projects[ i ].elements.element.( @type == "image" ).length() - 1 ] + "</image>" ) );		
			}
			
			return filesToLoad;
		}
		
		private function generateFilesToLoadForProjects( data:XML ):void
		{
			var x:XML, filesToLoad:XML;
			
			var projects:XMLList = data..project;
			var n:int = projects.length();
			for( var i:int; i < n; i++ )
			{
				filesToLoad = XML( "<files_to_load></files_to_load>" );
				for each( x in projects[ i ]..element.( @type == "image" ) )
					filesToLoad.appendChild( XML( "<image>" + x.toString() + "</image>" ) );
				
				projects[ i ].appendChild( filesToLoad );
			}
		}
	}
}

/*
{
   "message":"success",
   "result":{
      "projects":{
         "lab":{
            "FDG":{
               "images":[
                  ".\/images\/projects\/lab\/FDG\/01.jpg",
                  ".\/images\/projects\/lab\/FDG\/02.jpg",
                  ".\/images\/projects\/lab\/FDG\/03.jpg"
               ],
               "title":"Bird 01",
               "subtitle":"Motion",
               "description":"Exp&eacute;rimentation vid&eacute;o avec Cin&eacute;ma 4d et After Effects.",
               "preview":".\/images\/projects\/lab\/FDG\/preview.png"
            },
            "MODERN HERO":{
               "images":[
                  ".\/images\/projects\/lab\/MODERN HERO\/01.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/02.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/03.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/04.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/05.jpg"
               ],
               "title":"Modern Hero",
               "subtitle":"Concept Game",
               "description":"Concept design pour un jeu sur iphone",
               "new":"true",
               "preview":".\/images\/projects\/lab\/MODERN HERO\/preview.png"
            },
            "files_to_load":[
               ".\/images\/projects\/lab\/FDG\/preview.png",
               ".\/images\/projects\/lab\/FDG\/02.jpg",
               ".\/images\/projects\/lab\/FDG\/03.jpg",
               ".\/images\/projects\/lab\/MODERN HERO\/preview.png",
               ".\/images\/projects\/lab\/MODERN HERO\/02.jpg",
               ".\/images\/projects\/lab\/MODERN HERO\/05.jpg"
            ]
         },
         "works":{
            "illustrations":{
               "SKATE":{
                  "images":[
                     ".\/images\/projects\/works\/illustrations\/SKATE\/01.jpg",
                     ".\/images\/projects\/works\/illustrations\/SKATE\/02.jpg",
                     ".\/images\/projects\/works\/illustrations\/SKATE\/03.jpg",
                     ".\/images\/projects\/works\/illustrations\/SKATE\/04.jpg",
                     ".\/images\/projects\/works\/illustrations\/SKATE\/05.jpg"
                  ],
                  "title":"Skateboard 3e Oeil Paris",
                  "subtitle":"Design produit",
                  "description":"R&eacute;alisation de visuels pour les planches de skateboard de la marque 3e oeil.",
                  "preview":".\/images\/projects\/works\/illustrations\/SKATE\/preview.png"
               }
            },
            "interactive_app":{
               "FENCHURCH":{
                  "images":[
                     ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/01.jpg",
                     ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/02.jpg",
                     ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/03.jpg",
                     ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/04.jpg",
                     ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/05.jpg"
                  ],
                  "title":"Fenchurch app",
                  "subtitle":"Concept mobile application",
                  "description":"Conception et r&eacute;alisation du design de l'application mobile de la marque de v&ecirc;tement Fenchurch en &eacute;quipe avec Cl&eacute;ment Pavageau. L'application &agrave; pour but d'organiser des rencontres sur des spots urbains entre les pratiquants du skate.",
                  "preview":".\/images\/projects\/works\/interactive_app\/FENCHURCH\/preview.png"
               },
               "MOBIMASTER":{
                  "images":[
                     ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/01.jpg",
                     ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/02.jpg",
                     ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/03.jpg",
                     ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/04.jpg",
                     ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/05.jpg"
                  ],
                  "title":"Mobi Master",
                  "subtitle":"Jeu mobile iOs\/Android",
                  "description":"R&eacute;alisation de l'univers graphique et de l'interface du jeu Mobi Master. Dans ce jeu, vous allez devoir prendre soin de votre mobi(le) en l'entrainant et en prenant soin de lui afin de devenir le meilleur des combattants parmis vos amis !",
                  "preview":".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/preview.png"
               },
               "PHORM":{
                  "images":[
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/01.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/02.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/03.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/04.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/05.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/06.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/07.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/08.jpg",
                     ".\/images\/projects\/works\/interactive_app\/PHORM\/09.jpg"
                  ],
                  "title":"Phorm",
                  "subtitle":"Concept game",
                  "description":"Phorm est un univers dans lequel le joueur va devoir de cr&eacute;er des signes pour r&eacute;tablir la communication entre les diff&eacute;rents personnages.",
                  "preview":".\/images\/projects\/works\/interactive_app\/PHORM\/preview.png"
               },
               "TRAILER WIDO":{
                  "images":[
                     ".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/01.jpg",
                     ".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/02.jpg",
                     ".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/03.jpg",
                     ".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/04.jpg"
                  ],
                  "title":"Wido, rifts of destiny \/ Trailer",
                  "subtitle":"Motion",
                  "description":"Ecriture, tournage et r&eacute;alisation de la post-prod sur le trailer du jeu Wido, Les failles du destin, projet de 2&egrave;me ann&eacute;e &agrave; Gobelins, l'&eacute;cole de l'image.",
                  "preview":".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/preview.png"
               },
               "WIDO GAME":{
                  "images":[
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/00.jpg",
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/01.jpg",
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/02.jpg",
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/03.jpg",
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/04.jpg",
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/05.jpg",
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/06.jpg",
                     ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/07.jpg"
                  ],
                  "title":"Wido, rifts of destiny \/ Game",
                  "subtitle":"Interactive Game",
                  "description":"Wido, rifts of destiny est un jeu &agrave; destination des jeunes adolescents qui vous invite &agrave; d&eacute;couvrir la Mythologie Nordique &agrave; traver un dispositif de jeu innovant. Prenez votre smartphone en main et partez &agrave; l'aventure pour plonger au coeur de l'univers nordique !",
                  "preview":".\/images\/projects\/works\/interactive_app\/WIDO GAME\/preview.png"
               }
            },
            "web":{
               "BIMOLO":{
                  "images":[
                     ".\/images\/projects\/works\/web\/BIMOLO\/01.jpg",
                     ".\/images\/projects\/works\/web\/BIMOLO\/02.jpg",
                     ".\/images\/projects\/works\/web\/BIMOLO\/03.jpg"
                  ],
                  "title":"Bimolo",
                  "subtitle":"Web design",
                  "description":"Proposition de maquettes pour le site de lotterie en ligne Bimolo.",
                  "preview":".\/images\/projects\/works\/web\/BIMOLO\/preview.png"
               },
               "FORD":{
                  "images":[
                     ".\/images\/projects\/works\/web\/FORD\/01.jpg",
                     ".\/images\/projects\/works\/web\/FORD\/02.jpg",
                     ".\/images\/projects\/works\/web\/FORD\/03.jpg",
                     ".\/images\/projects\/works\/web\/FORD\/04.jpg"
                  ],
                  "title":"Ford",
                  "subtitle":"Web design",
                  "description":"Recherche graphique pour la refonte du site Ford.",
                  "preview":".\/images\/projects\/works\/web\/FORD\/preview.png"
               },
               "FZFS":{
                  "images":[
                     ".\/images\/projects\/works\/web\/FZFS\/01.jpg",
                     ".\/images\/projects\/works\/web\/FZFS\/02.jpg",
                     ".\/images\/projects\/works\/web\/FZFS\/03.jpg",
                     ".\/images\/projects\/works\/web\/FZFS\/04.jpg"
                  ],
                  "title":"FZFS",
                  "subtitle":"Concept Design",
                  "description":"Conception de l'identit&eacute; visuelle de FZFS, (Floz alias Florian Zumbrunn et Filsdegraphiste alias Lionel Taurus)",
                  "preview":".\/images\/projects\/works\/web\/FZFS\/preview.png"
               },
               "GRAND OPTICAL":{
                  "images":[
                     ".\/images\/projects\/works\/web\/GRAND OPTICAL\/01.jpg",
                     ".\/images\/projects\/works\/web\/GRAND OPTICAL\/02.jpg",
                     ".\/images\/projects\/works\/web\/GRAND OPTICAL\/03.jpg"
                  ],
                  "title":"GrandOptical",
                  "subtitle":"Web design",
                  "description":"R&eacute;alisation de pages pour le site de vente en ligne GrandOptical.",
                  "preview":".\/images\/projects\/works\/web\/GRAND OPTICAL\/preview.png"
               },
               "MIL":{
                  "images":[
                     ".\/images\/projects\/works\/web\/MIL\/01.jpg",
                     ".\/images\/projects\/works\/web\/MIL\/02.jpg",
                     ".\/images\/projects\/works\/web\/MIL\/03.jpg"
                  ],
                  "title":"Mob In Life",
                  "subtitle":"Charte graphique",
                  "description":"R&eacute;alisation de la charte graphique du studio Mob In Life.",
                  "preview":".\/images\/projects\/works\/web\/MIL\/preview.png"
               },
               "ONE PIECE":{
                  "images":[
                     ".\/images\/projects\/works\/web\/ONE PIECE\/01.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/02.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/03.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/08.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/09.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/10.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/11.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/12.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/13.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/15.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/16.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/17.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/18.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/19.jpg",
                     ".\/images\/projects\/works\/web\/ONE PIECE\/20.jpg"
                  ],
                  "title":"One Piece Pirate Warriors",
                  "subtitle":"Web design",
                  "description":"R&eacute;alisation du site du quizz Treasure Quest pour la sortie du jeu One Piece Pirate Warriors.",
                  "preview":".\/images\/projects\/works\/web\/ONE PIECE\/preview.png"
               },
               "RICARD":{
                  "images":[
                     ".\/images\/projects\/works\/web\/RICARD\/01.jpg",
                     ".\/images\/projects\/works\/web\/RICARD\/02.jpg"
                  ],
                  "title":"Ricard",
                  "subtitle":"Motion",
                  "description":"Animation vid&eacute;o de cocktails pour le site Ricard.",
                  "preview":".\/images\/projects\/works\/web\/RICARD\/preview.png"
               }
            },
            "files_to_load":[
               ".\/images\/projects\/works\/illustrations\/SKATE\/preview.png",
               ".\/images\/projects\/works\/illustrations\/SKATE\/02.jpg",
               ".\/images\/projects\/works\/illustrations\/SKATE\/05.jpg",
               ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/preview.png",
               ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/02.jpg",
               ".\/images\/projects\/works\/interactive_app\/FENCHURCH\/05.jpg",
               ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/preview.png",
               ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/02.jpg",
               ".\/images\/projects\/works\/interactive_app\/MOBIMASTER\/05.jpg",
               ".\/images\/projects\/works\/interactive_app\/PHORM\/preview.png",
               ".\/images\/projects\/works\/interactive_app\/PHORM\/02.jpg",
               ".\/images\/projects\/works\/interactive_app\/PHORM\/09.jpg",
               ".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/preview.png",
               ".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/02.jpg",
               ".\/images\/projects\/works\/interactive_app\/TRAILER WIDO\/04.jpg",
               ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/preview.png",
               ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/01.jpg",
               ".\/images\/projects\/works\/interactive_app\/WIDO GAME\/07.jpg",
               ".\/images\/projects\/works\/web\/BIMOLO\/preview.png",
               ".\/images\/projects\/works\/web\/BIMOLO\/02.jpg",
               ".\/images\/projects\/works\/web\/BIMOLO\/03.jpg",
               ".\/images\/projects\/works\/web\/FORD\/preview.png",
               ".\/images\/projects\/works\/web\/FORD\/02.jpg",
               ".\/images\/projects\/works\/web\/FORD\/04.jpg",
               ".\/images\/projects\/works\/web\/FZFS\/preview.png",
               ".\/images\/projects\/works\/web\/FZFS\/02.jpg",
               ".\/images\/projects\/works\/web\/FZFS\/04.jpg",
               ".\/images\/projects\/works\/web\/GRAND OPTICAL\/preview.png",
               ".\/images\/projects\/works\/web\/GRAND OPTICAL\/02.jpg",
               ".\/images\/projects\/works\/web\/GRAND OPTICAL\/03.jpg",
               ".\/images\/projects\/works\/web\/MIL\/preview.png",
               ".\/images\/projects\/works\/web\/MIL\/02.jpg",
               ".\/images\/projects\/works\/web\/MIL\/03.jpg",
               ".\/images\/projects\/works\/web\/ONE PIECE\/preview.png",
               ".\/images\/projects\/works\/web\/ONE PIECE\/02.jpg",
               ".\/images\/projects\/works\/web\/ONE PIECE\/20.jpg",
               ".\/images\/projects\/works\/web\/RICARD\/preview.png",
               ".\/images\/projects\/works\/web\/RICARD\/02.jpg",
               ".\/images\/projects\/works\/web\/RICARD\/02.jpg"
            ]
         },
         "news":{
            "0":{
               "images":[
                  ".\/images\/projects\/lab\/MODERN HERO\/01.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/02.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/03.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/04.jpg",
                  ".\/images\/projects\/lab\/MODERN HERO\/05.jpg"
               ],
               "title":"Modern Hero",
               "subtitle":"Concept Game",
               "description":"Concept design pour un jeu sur iphone",
               "new":"true",
               "preview":".\/images\/projects\/lab\/MODERN HERO\/preview.png"
            },
            "files_to_load":[
               ".\/images\/projects\/lab\/MODERN HERO\/preview.png",
               ".\/images\/projects\/lab\/MODERN HERO\/02.jpg",
               ".\/images\/projects\/lab\/MODERN HERO\/05.jpg"
            ]
         }
      }
   }
}
*/