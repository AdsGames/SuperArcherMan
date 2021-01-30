package allanly 
{
	/**
	 * Background
	 * ALLAN AND SULLY!
	 * Background handler
	 * 14/6/15
	 */
	
	// Libraries
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	// Torch
	public class background extends FlxSprite{
		// Background
		[Embed(source = "../../assets/images/mountains.png")] private var parallax:Class;
		
		// Create
		public function background( newWidth:Number) {
			// Add backgrounds
			for ( var t:Number = 0; t < newWidth; t += FlxG.width) {
				var newParallax:FlxSprite = new FlxSprite(t, 0, parallax);
				newParallax.scrollFactor.x = 0.5;
				FlxG.state.add( newParallax);
			}
		}
	}
}