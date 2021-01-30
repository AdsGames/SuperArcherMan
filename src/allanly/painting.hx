package allanly 
{
	/**
	 * Snazzy animated paintint
	 * ALLAN AND SULLY!
	 * Nice painting
	 * 11/6/15
	 */
	
	// Libraries
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	// Torch
	public class painting extends FlxSprite{
		// Image
		[Embed(source="../../assets/images/painting.png")]
		private var picPainting:Class;
		
		// Create
		public function painting( newX:Number, newY:Number) {
			// Construct parent
			super( newX, newY, picPainting);
			
			// Images and animations
			loadGraphic( picPainting, true, false, 48, 32);
			
			this.addAnimation("superBlink", [0, 1, 2, 3, 4, 5, 6, 7, 7, 7, 7, 7, 6, 5, 4, 3, 2, 1, 0], 8, false);
			
			this.addAnimation("normal", [0], 8, true);
			this.play("normal");
		}
		
		// Update
		public override function update():void {
			if ( tools.myRandom( 0, 500) == 1) {
				this.play("superBlink", true);
			}
		}
	}
}