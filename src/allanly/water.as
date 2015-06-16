package allanly 
{
	/**
	 * ALLAN AND SULLY!
	 * Water effects
	 * 12/6/15
	 */
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.*;
	import org.flixel.FlxG; 
	
	public class water extends FlxSprite{
		//Call the effects private variables
		private var sinewave:SineWaveFX;
		private var wibbleWobble:FlxSprite;
		
		// Create the water
		public function water( newX:Number, newY:Number, newWidth:Number, newHeight:Number) {
			//	Get a sinewave effect from FlxSpecialFX
			sinewave = FlxSpecialFX.sineWave();
			
			//if you don't want to use a png, add the next line like I do. It makes a flxSprite instead
			var pic:FlxSprite = new FlxSprite(newX, newY, null);
			pic = new FlxSprite(newX, newY + 8, null).makeGraphic( newWidth, newHeight, 0xff0000FF);
			
			// Waves
			wibbleWobble = sinewave.createFromFlxSprite(pic, SineWaveFX.WAVETYPE_VERTICAL_SINE, pic.height/4, pic.width);
			wibbleWobble.alpha =  0.85;
			
			//You don't have to add alpha if you want. but yes, you do have to add it to the wibbleWobble to get it to work
			sinewave.start();
			FlxG.state.add(wibbleWobble);
		}
	}
}