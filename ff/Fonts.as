package ff
{
	import flash.text.Font;

	public final class Fonts
	{	
		[Embed(
			source = "./assets/Lekton-Regular.ttf",
			fontFamily="lekton",
			fontWeight="normal",
			embedAsCFF='false')]
		private static const m_lektonRegular:Class;
		
		[Embed(
			source = "./assets/Lekton-Bold.ttf",
			fontFamily="lektonbold",
			fontWeight="bold",
			embedAsCFF='false')]
		private static const m_lektonBold:Class;
		
		[Embed(
			source = "./assets/Lekton-Italic.ttf",
			fontFamily="lekton",
			fontStyle="italic",
			embedAsCFF='false')]
		private static const m_lektonItalic:Class;
		
		[Embed(
			source = "./assets/Cousine-Regular.ttf",
			fontFamily="cousine",
			fontWeight="normal",
			embedAsCFF='false')]
		private static const m_cousineRegular:Class;
		
		[Embed(
			source = "./assets/Cousine-Bold.ttf",
			fontFamily="cousine",
			fontWeight="bold",
			embedAsCFF='false')]
		private static const m_cousineBold:Class;
		
		[Embed(
			source = "./assets/Cousine-Italic.ttf",
			fontFamily="cousine",
			fontStyle="italic",
			embedAsCFF='false')]
		private static const m_cousineItalic:Class;
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		public static const LektonRegular:Font = new m_lektonRegular as Font;
		public static const LektonBold:Font = new m_lektonBold as Font as Font;
		public static const LektonItalic:Font = new m_lektonItalic as Font;

		public static const CousineRegular:Font = new m_cousineRegular as Font;
		public static const CousineBold:Font = new m_cousineBold as Font;
		public static const CousineItalic:Font = new m_cousineItalic as Font;
	}
}