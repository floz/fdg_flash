/**
* @author floz
*/
package fr.filsdegraphiste.module.site.ui.about 
{
	import fr.filsdegraphiste.module.site.ui.MaskedText;
	import assets.AssetAboutBigIcon;

	import aze.motion.eaze;

	import fr.filsdegraphiste.config._;
	import fr.minuit4.core.navigation.modules.ModulePart;
	import fr.minuit4.text.Text;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	public class AboutContent extends ModulePart
	{
		private const _W:int = 290;
		
		private var _icon:AssetAboutBigIcon;
		private var _cnt:Sprite;
		private var _separatorTop:Shape;
		private var _tfTitleContent:MaskedText;
		private var _tfContent:MaskedText;
		private var _separatorBot:Shape;
		private var _tfContact:MaskedText;
		private var _cntLink:Sprite;		
		private var _linkMail:AboutLink;
		private var _linkCV:AboutLink;
		private var _linkLinkedin:AboutLink;
		private var _linkTwitter:AboutLink;
		
		public function AboutContent()
		{
			addChild( _icon = new AssetAboutBigIcon() );
			addChild( _cnt = new Sprite() );
			_cnt.addChild( _separatorTop = new Shape() );
			_cnt.addChild( _tfTitleContent = new MaskedText( "Hello world !", "about_title" ) );
			_cnt.addChild( _tfContent = new MaskedText( "My name is Lionel TAURUS, also known as Filsdegraphiste. I'm a graphic and interaction designer. %% I was a student at Gobelins, l'école de l'image, a design school and I'm currently working at Mob In Life since September 2011.", "about" ) );
			_cnt.addChild( _separatorBot = new Shape() );
			_cnt.addChild( _tfContact = new MaskedText( "Contact", "about_title" ) );
			_cnt.addChild( _cntLink = new Sprite() );
			_cntLink.addChild( _linkMail = new AboutLink( "tauruslionel@gmail.com" ) );
			_cntLink.addChild( _linkCV = new AboutLink( "Download my CV" ) );
			_cntLink.addChild( _linkLinkedin = new AboutLink( "Linkedin" ) );
			_cntLink.addChild( _linkTwitter = new AboutLink( "Twitter" ) );
			
			_icon.x = _W >> 1;
			_icon.alpha = 0;
			
			_createSeparator( _separatorTop );
			_createSeparator( _separatorBot );
			
			_cnt.y = 60;
			
			_tfTitleContent.y = 30;
			_tfContent.y = 60;
			_separatorBot.y = _tfContent.y + _tfContent.height + 30 >> 0;		
			_tfContact.y = _separatorBot.y + 30;
			_cntLink.y = _tfContact.y + 30;
			_linkMail.alpha = 0;
			_linkCV.y = _linkMail.y + _linkMail.height;
			_linkCV.alpha = 0;
			_linkLinkedin.y = _linkCV.y + 14;
			_linkLinkedin.alpha = 0;
			_linkTwitter.y = _linkLinkedin.y + 14;
			_linkTwitter.alpha = 0;
			
			_.stage.addEventListener( Event.RESIZE, _resizeHandler );
			_onResize();	
		}

		private function _resizeHandler(event : Event) : void 
		{
			_onResize();
		}

		private function _onResize() : void 
		{
			this.x = _.stage.stageWidth - _W >> 1;
			this.y = ( _.stage.stageHeight - this.height ) * .5 - 200 >> 0;
			if( this.y < 80 ) this.y = 80;
		}
		
		private function _createSeparator( s:Shape ):void
		{
			var g:Graphics = s.graphics;
			g.lineStyle( 0, 0x5f5f5f, .2 );
			g.moveTo( 0, 0 );
			g.lineTo( _W, 0 );
			
			s.alpha = 0;
			s.scaleX = .4;	
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			eaze( _icon ).delay( delay ).to( .4, { alpha:1 } );
			eaze( _separatorTop ).delay( delay + .1 ).to( .4, { alpha: 1, scaleX: 1 } );
			_tfTitleContent.show( delay + .2 );
			_tfContent.show( delay + .25 );
			eaze( _separatorBot ).delay( delay + .3 ).to( .4, { alpha: 1, scaleX: 1 } );
			_tfContact.show( delay + .4 );
			eaze( _linkMail ).delay( delay + .5 ).to( .4, { alpha: 1 } );
			eaze( _linkCV ).delay( delay + .6 ).to( .4, { alpha: 1 } );
			eaze( _linkLinkedin ).delay( delay + .7 ).to( .4, { alpha: 1 } );
			eaze( _linkTwitter ).delay( delay + .8 ).to( .4, { alpha: 1 } );
			
			return super.show( delay );
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			eaze( _icon ).delay( delay + .4 ).to( .2, { alpha: 0 } );
			eaze( _separatorTop ).delay( delay + .35 ).to( .2, { alpha: 0, scaleX: .4 } );
			_tfTitleContent.hide( delay + .3 );
			_tfContent.hide( delay + .275 );
			eaze( _separatorBot ).delay( delay + .25 ).to( .2, { alpha: 0, scaleX: .4 } );
			_tfContent.hide( delay + .2 );
			_tfContact.hide( delay + .175 );
			eaze( _linkMail ).delay( delay + .15 ).to( .2, { alpha: 0 } );
			eaze( _linkCV ).delay( delay + .1 ).to( .2, { alpha: 0 } );
			eaze( _linkLinkedin ).delay( delay + .05 ).to( .2, { alpha: 0 } );
			eaze( _linkTwitter ).delay( delay ).to( .2, { alpha: 0 } );
			
			eaze( this ).delay( 1.2 ).onComplete( parent.removeChild, this );
			
			return 1.2;
		}
	}
}