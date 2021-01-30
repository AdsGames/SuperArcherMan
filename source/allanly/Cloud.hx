package allanly;

/**
 * Cloud
 * ALLAN AND SULLY!
 * Animated torch for that castle feel
 * 11/6/2015
 */
// Libraries
import allanly.Tools;
import flixel.FlxSprite;

class Cloud extends FlxSprite {
	// Create
	public function new(x:Float, y:Float) {
		// Construct parent
		super(x, y, AssetPaths.cloud__png);

		// Randomization
		this.velocity.x = Tools.myRandom(5, 20);
		this.scale.x = Tools.myRandom(5, 20) / 10;
	}

	// Update
	public override function update(elapsed:Float) {
		// Update parent
		super.update(elapsed);
	}
}
