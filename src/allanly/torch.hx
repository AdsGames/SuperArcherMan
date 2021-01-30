package allanly 
{
	/**
	 * Animated torch
	 * ALLAN AND SULLY!
	 * Animated torch for that castle feel
	 * 4/6/15
	 */
	
	// Libraries
	import org.flixel.FlxSprite;
	
	// Torch
	public class torch extends FlxSprite{
		// Image
		[Embed(source = '../../assets/images/torch.png')] 
		private var picTorch:Class;
		
		// Create
		public function torch( newX:Number, newY:Number) {
			// Construct parent
			super( newX, newY, picTorch);
			
			// Images and animations
			loadGraphic( picTorch, true, false, 16, 16);
			this.addAnimation("flame", [0, 1, 2, 3], 8, true);
			this.play("flame");
		}
	}
}