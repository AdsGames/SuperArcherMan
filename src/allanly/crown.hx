package allanly 
{
	/**
	 * Crown
	 * ALLAN AND SULLY!
	 * Animated tree for that nature feel
	 * 4/6/15
	 */
	
	// Libraries
	import org.flixel.FlxSprite;
	
	// Torch
	public class crown extends FlxSprite{
		// Image
		[Embed(source = '../../assets/images/crown.png')] 
		private var picCrown:Class;
		
		private var taken:Boolean = false;
		
		// Create
		public function crown( newX:Number, newY:Number) {
			// Construct parent
			super( newX, newY, picCrown);
			
			// Images and animations
			loadGraphic( picCrown, true, false, 16, 32);
			this.addAnimation("twinkle", [0, 1, 2, 3], 8, true);
			this.addAnimation("gone", [4], 8, false);
			this.play("twinkle");
		}
		
		// Its stolen!
		public function takeCrown():void {
			this.play("gone");
			taken = true;
		}
		
		// Is it gone??
		public function isTaken():Boolean {
			return  taken;
		}
	}
}