package allanly 
{
	/**
	 * ALLAN AND SULLY!
	 * Animated torch for that castle feel
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