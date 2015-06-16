package allanly 
{
	/**
	 * ALLAN AND SULLY!
	 * Nice throne
	 * 11/6/15
	 */
	
	// Libraries
	import org.flixel.FlxSprite;
	
	// Torch
	public class throne extends FlxSprite{
		// Image
		[Embed(source="../../assets/images/throne.png")]
		private var picThrone:Class;
		
		// Create
		public function throne( newX:Number, newY:Number) {
			// Construct parent
			super( newX, newY, picThrone);
		}
	}
}