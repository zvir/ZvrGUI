/**
Suggested workflow:
- create a fontLibrary subfolder in your project (NOT in /bin or /src)
- for example: /lib/fontLibrary
- copy font files in this location
- create a FontLibrary class in the same location
- one font library can contain several font classes (duplicate embed and registration code)

FlashDevelop QuickBuild options: (just press Ctrl+F8 to compile this library)
@mxmlc -o bin/zvrMinimalDarkFonts.swf -static-link-runtime-shared-libraries=true -noplay
*/
package zvr.zvrGUI.skins.zvrMinimalDarkFonts 
{
	import flash.display.Sprite;
	import flash.text.Font;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class MDFonts extends Sprite 
	{
		
		/*
		Common unicode ranges:
		Uppercase   : U+0020,U+0041-U+005A
		Lowercase   : U+0020,U+0061-U+007A
		Numerals    : U+0030-U+0039,U+002E
		Punctuation : U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E
		Basic Latin : U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E
		Latin I     : U+0020,U+00A1-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183
		Latin Ext. A: U+0100-U+01FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183
		Latin Ext. B: U+0180-U+024F,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183
		Greek       : U+0374-U+03F2,U+1F00-U+1FFE,U+2000-U+206f,U+20A0-U+20CF,U+2100-U+2183
		Cyrillic    : U+0400-U+04CE,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183
		Armenian    : U+0530-U+058F,U+FB13-U+FB17
		Arabic      : U+0600-U+06FF,U+FB50-U+FDFF,U+FE70-U+FEFF
		Hebrew      : U+05B0-U+05FF,U+FB1D-U+FB4F,U+2000-U+206f,U+20A0-U+20CF,U+2100-U+2183
		
		About 'embedAsCFF' attribute:
		- is Flex 4 only (comment out to target Flex 2-3)
		- is 'true' by default, meaning the font is embedded for the new TextLayout engine only
		- you must set explicitely to 'false' for use in regular TextFields
		
		More information:
		http://help.adobe.com/en_US/Flex/4.0/UsingSDK/WS2db454920e96a9e51e63e3d11c0bf69084-7f5f.html
		*/
		
		[Embed(source='ProggyCleanCE.ttf'
		,fontFamily  ='Proggy'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const proggy:Class;
		public static const Proggy:String = "Proggy";
		
		
		[Embed(source='stan0753.ttf'
		,fontFamily  ='stan0753'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const stan0753:Class;
		public static const Stan0753:String = "stan0753";
		
		
		[Embed(source='uni05.ttf'
		,fontFamily  ='uni05'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const uni05:Class;
		public static const Uni05:String = "uni05";
		
		[Embed(source='stan0763.ttf'
		,fontFamily  ='stan0763'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const stan0763:Class;
		public static const Stan0763:String = "stan0763";
		
		[Embed(source='mono0755.ttf'
		,fontFamily  ='mono0755'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const mono0755:Class;
		public static const Mono0755:String = "mono0755";
		
		[Embed(source='mono0765.ttf'
		,fontFamily  ='mono0765'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const mono0765:Class;
		public static const Mono0765:String = "mono0765";
		
		
		[Embed(source='mneg0555.ttf'
		,fontFamily  ='mneg0555'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const mneg0555:Class;
		public static const Mneg0555:String = "mneg0555";
		
		
		[Embed(source='MUNIE___.TTF'
		,fontFamily  ='munie'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+00A1-U+00FF,U+0100-U+01FF,U+0180-U+024F,U+1E00-U+1EFF'
		,embedAsCFF='false'
		)]
		private static const munie:Class;
		public static const Munie:String = "munie";
		
		
		[Embed(source='monaco.ttf'
		,fontFamily  ='monaco'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  = 'normal' // normal|bold
		,advancedAntiAliasing="false"
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+0020,U+00A1-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0180-U+024F,U+0100-U+01FF'
		,embedAsCFF='false'
		)]
		
		private static const monaco:Class;
		public static const Monaco:String = "monaco";
		
		private static function getObj():Object
		{
			var o:Object = { };
			
			o[Proggy] = 	proggy	;
			o[Stan0753] = 	stan0753	;
			o[Uni05] = 		uni05	;
			o[Stan0763] = 	stan0763	;
			o[Mono0755] = 	mono0755	;
			o[Mono0765] = 	mono0765	;
			o[Mneg0555] = 	mneg0555	;
			o[Munie] = 	munie	;
			o[Monaco] = 	monaco	;
			
			return o;
			
		}
		
		private static const obj:Object = getObj();
		
		
		public function MDFonts() 
		{
			Font.registerFont(proggy);
			Font.registerFont(stan0753);
			Font.registerFont(uni05);
			Font.registerFont(stan0763);
			Font.registerFont(mono0755);
			Font.registerFont(mono0765);
			Font.registerFont(mneg0555);
			Font.registerFont(munie);
			Font.registerFont(monaco);
			
			
			
		}
		
		public static function getClass(n:String):Class
		{
			return obj[n] as Class;
		}
	}
	
}






