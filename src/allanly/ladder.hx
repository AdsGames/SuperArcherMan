package allanly 
{
	/**
	 * Ladder
	 * ALLAN AND SULLY!
	 * Ladder to get to higher (or lower) places
	 * 4/6/15
	 */
	
	// Libraries
	import org.flixel.FlxSprite;
	
	// Ladder to climb
	public class ladder extends FlxSprite{
		
		
		public function ladder( newX:Number, newY:Number, newWidth:Number, newHeight:Number) {
			super( newX, newY);
			this.width = newWidth;
			this.height = newHeight;
		}
	}

}