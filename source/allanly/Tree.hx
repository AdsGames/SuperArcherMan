package allanly;

/**
 * Tree
 * ALLAN AND SULLY!
 * Animated tree for that nature feel
 * 4/6/2015
 */
// Libraries
import flixel.FlxSprite;

class Tree extends FlxSprite {
	// Create
	public function new(x:Float, y:Float) {
		// Construct parent
		super(x, y, AssetPaths.tree__png);

		// Images and animations
		loadGraphic(AssetPaths.tree__png, true, 48, 64);
		this.animation.add("bird", [0, 1, 2, 3], 8, true);
		this.animation.add("still", [0], 8, true);

		// Only some have animation
		if (Tools.myRandom(0, 5) == 1) {
			this.animation.play("bird");
		}
		else {
			this.animation.play("still");
		}
	}
}
