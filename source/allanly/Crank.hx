package allanly;

/**
 * Crank
 * ALLAN AND SULLY!
 * Nice throne
 * 11/6/2015
 */
// Libraries
import flixel.FlxSprite;

class Crank extends FlxSprite {
	// Image
	private var activated:Bool;

	// Create
	public function new(x:Float, y:Float) {
		// Construct parent
		super(x, y, AssetPaths.crank__png);

		// Init vars
		this.activated = false;

		// Images and animations
		loadGraphic(AssetPaths.crank__png, true, 16, 16);

		this.animation.add("spin", [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3], 8, false);
		this.animation.add("stay", [0], 8, false);
		this.animation.play("stay");
		this.solid = true;
	}

	// Turn crank
	public function spin() {
		this.activated = true;
		this.animation.play("spin");
	}

	// Check if its been spun
	public function getActivated():Bool {
		return this.activated;
	}
}
