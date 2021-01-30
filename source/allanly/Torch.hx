package allanly;

/**
 * Animated torch
 * ALLAN AND SULLY!
 * Animated torch for that castle feel
 * 4/6/2015
 */
// Libraries
import flixel.FlxSprite;

// Torch
class Torch extends FlxSprite {
	public function new(x:Float, y:Float) {
		// Construct parent
		super(x, y, AssetPaths.torch__png); // Images and animations
		loadGraphic(AssetPaths.torch__png, true, 16, 16);
		this.animation.add("flame", [0, 1, 2, 3], 8, true);
		this.animation.play("flame");
	}
}
