package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class TextureFillsMD 
	{
		
		
		[Embed(source = '../../../../../assets/ButtonNormalPatern.png')]
		private static const ButtonNormalPatern:Class
		private static const ButtonNormalPaternBitmap:Bitmap = new ButtonNormalPatern();
		
		[Embed(source = '../../../../../assets/ButtonOverPatern.png')]
		private static const ButtonOverPatern:Class
		private static const ButtonOverPaternBitmap:Bitmap = new ButtonOverPatern();
		
		[Embed(source = '../../../../../assets/ButtonDownPatern.png')]
		private static const ButtonDownPatern:Class
		private static const ButtonDownPaternBitmap:Bitmap = new ButtonDownPatern();
		
		[Embed(source = '../../../../../assets/ButtonDownOverPatern.png')]
		private static const ButtonDownOverPatern:Class
		private static const ButtonDownOverPaternBitmap:Bitmap = new ButtonDownOverPatern();
		
		[Embed(source = '../../../../../assets/PanelNormalFillPatern.png')]
		private static const PanelNormalFillPatern:Class
		private static const PanelNormalFillPaternBitmap:Bitmap = new PanelNormalFillPatern();
		
		[Embed(source = '../../../../../assets/ButtonFocusPatern.png')]
		private static const ButtonFocusPatern:Class
		private static const ButtonFocusPaternBitmap:Bitmap = new ButtonFocusPatern();
		
		[Embed(source = '../../../../../assets/PanelSelectedFillPatern.png')]
		private static const PanelSelectedFillPatern:Class
		private static const PanelSelectedFillPaternBitmap:Bitmap = new PanelSelectedFillPatern();
		
		[Embed(source = '../../../../../assets/PanelOverFillPatern.png')]
		private static const PanelOverFillPatern:Class
		private static const PanelOverFillPaternBitmap:Bitmap = new PanelOverFillPatern();
		
		[Embed(source = '../../../../../assets/FooterNormalPattern.png')]
		private static const FooterNormalPattern:Class
		private static const FooterNormalPatternBitmap:Bitmap = new FooterNormalPattern();
		
		[Embed(source = '../../../../../assets/fillPatern.png')]
		private static const fillPatern:Class
		private static const fillPaternBitmap:Bitmap = new fillPatern();
		
		[Embed(source = '../../../../../assets/TitleNormal.png')]
		private static const TitleNormal:Class
		private static const TitleNormalBitmap:Bitmap = new TitleNormal();
		
		[Embed(source = '../../../../../assets/TitleOver.png')]
		private static const TitleOver:Class
		private static const TitleOverBitmap:Bitmap = new TitleOver();
		
		[Embed(source = '../../../../../assets/TitleSelected.png')]
		private static const TitleSelected:Class
		private static const TitleSelectedBitmap:Bitmap = new TitleSelected();
		
		[Embed(source = '../../../../../assets/fillPaternDark1.png')]
		private static const fillPaternDark1:Class
		private static const fillPaternDark1Bitmap:Bitmap = new fillPaternDark1();
		
		[Embed(source = '../../../../../assets/fillPaternDark2.png')]
		private static const fillPaternDark2:Class
		private static const fillPaternDark2Bitmap:Bitmap = new fillPaternDark2();
		
		[Embed(source = '../../../../../assets/fillPaternDark3.png')]
		private static const fillPaternDark3:Class
		private static const fillPaternDark3Bitmap:Bitmap = new fillPaternDark3();
		
		[Embed(source = '../../../../../assets/fillPaternDarkDisabled.png')]
		private static const fillPaternDarkDisabled:Class
		private static const fillPaternDarkDisabledBitmap:Bitmap = new fillPaternDarkDisabled();
		
		[Embed(source = '../../../../../assets/progressBarr.png')]
		private static const progressBarr:Class
		private static const progressBarrBitmap:Bitmap = new progressBarr();
		
		[Embed(source = '../../../../../assets/WindowFillFocussOffl.png')]
		private static const windowFillFocussOffl:Class
		private static const windowFillFocussOfflBitmap:Bitmap = new windowFillFocussOffl();
		
		[Embed(source='../../../../../assets/WindowFillNormal.png')]
		private static const windowFillNormal:Class
		private static const windowFillNormalBitmap:Bitmap = new windowFillNormal();
		
		[Embed(source='../../../../../assets/CelavraLogoGreen.png')]
		private static const celavraLogoGreen:Class
		private static const celavraLogoGreenBitmap:Bitmap = new celavraLogoGreen();
		
		[Embed(source='../../../../../assets/CelavraLogoWhite.png')]
		private static const celavraLogoWhite:Class
		private static const celavraLogoWhiteBitmap:Bitmap = new celavraLogoWhite();
		
		[Embed(source='../../../../../assets/CelavraLogo64x64.png')]
		private static const celavraLogo64x64:Class
		private static const celavraLogo64x64Bitmap:Bitmap = new celavraLogo64x64();
		
		[Embed(source='../../../../../assets/CelavraLogo32x32.png')]
		private static const celavraLogo32x32:Class
		private static const celavraLogo32x32Bitmap:Bitmap = new celavraLogo32x32();
		
		[Embed(source='../../../../../assets/CelavraLogo16x16.png')]
		private static const celavraLogo16x16:Class
		private static const celavraLogo16x16Bitmap:Bitmap = new celavraLogo16x16();
		
		public static const BUTTON_NORMAL_PATERN			: String = "ButtonNormalPatern";
		public static const BUTTON_OVER_PATERN			    : String = "ButtonOverPatern";
		public static const BUTTON_DOWN_PATERN			    : String = "ButtonDownPatern";
		public static const BUTTON_DOWN_OVER_PATERN			: String = "ButtonDownOverPatern";
		public static const BUTTON_FOCUS_PATERN				: String = "ButtonFocusPatern";
		
		public static const PANEL_NORMAL_FILL_PATERN		: String = "PanelNormalFillPatern";
		public static const PANEL_SELECTED_FILL_PATERN		: String = "PanelSelectedFillPatern";
		public static const PANEL_OVER_FILL_PATERN			: String = "PanelOverFillPatern";
		
		public static const FOOTER_NORMAL_PATTERN			: String = "FooterNormalPattern";
		
		public static const TITLE_OVER						: String = "TitleOver";
		public static const TITLE_NORMAL					: String = "TitleNormal";
		public static const TITLE_SELECTED					: String = "TitleSelected";
		
		public static const FILL_PATERN                     : String = "fillPatern";
		public static const FILL_PATERNDARK_1               : String = "fillPaternDark1";
		public static const FILL_PATERNDARK_2               : String = "fillPaternDark2";
		public static const FILL_PATERNDARK_3               : String = "fillPaternDark3";
		public static const FILL_PATERN_DARK_DISABLED       : String = "fillPaternDarkDisabled";
		public static const PROGRESS_BARR                   : String = "progressBarr";
		public static const WINDOW_FILL_FOCUSSOFFL          : String = "windowFillFocussOffl";
		public static const WINDOW_FILL_NORMAL              : String = "windowFillNormal";
		
		public static const CELAVRA_LOGO_GREEN              : String = "celavraLogoGreen";
		public static const CELAVRA_LOGO_WHITE              : String = "celavraLogoWhite";
		
		public static const CELAVRA_LOGO_64              	: String = "celavraLogo64x64";
		public static const CELAVRA_LOGO_32              	: String = "celavraLogo32x32";
		public static const CELAVRA_LOGO_16              	: String = "celavraLogo16x16";
		
		
		private static const texturies:Object =
		{
			ButtonNormalPatern			: ButtonNormalPaternBitmap,
			ButtonOverPatern			: ButtonOverPaternBitmap,	
			ButtonDownPatern			: ButtonDownPaternBitmap,	
			ButtonDownOverPatern		: ButtonDownOverPaternBitmap,	
			ButtonFocusPatern			: ButtonFocusPaternBitmap,	
			PanelNormalFillPatern		: PanelNormalFillPaternBitmap,	
			PanelOverFillPatern			: PanelOverFillPaternBitmap,	
			PanelSelectedFillPatern		: PanelSelectedFillPaternBitmap,
			FooterNormalPattern			: FooterNormalPatternBitmap,
			
			TitleOver					: TitleOverBitmap,
			TitleNormal                 : TitleNormalBitmap,
			TitleSelected               : TitleSelectedBitmap,
			
			fillPatern                  : fillPaternBitmap,
			fillPaternDark1             : fillPaternDark1Bitmap,
			fillPaternDark2             : fillPaternDark2Bitmap,
			fillPaternDark3             : fillPaternDark3Bitmap,
			fillPaternDarkDisabled      : fillPaternDarkDisabledBitmap,
			progressBarr                : progressBarrBitmap,
			windowFillFocussOffl        : windowFillFocussOfflBitmap,
			windowFillNormal            : windowFillNormalBitmap,
			
			celavraLogoGreen			: celavraLogoGreenBitmap,
			celavraLogoWhite			: celavraLogoWhiteBitmap,
			
			celavraLogo64x64			: celavraLogo64x64Bitmap,
			celavraLogo32x32			: celavraLogo32x32Bitmap,
			celavraLogo16x16			: celavraLogo16x16Bitmap
			
		}                               
		
		public static function getBitmapData(texture:String, clone:Boolean = false):BitmapData
		{                               
			return clone ? Bitmap(texturies[texture]).bitmapData.clone() : Bitmap(texturies[texture]).bitmapData;
		}
		
	}

}





















