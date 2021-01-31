package allanly;

/**
 * Crown
 * ALLAN AND SULLY!
 * Animated tree for that nature feel
 * 4/6/2015
 */
// Libraries
import flixel.FlxSprite;

class Crown extends FlxSprite {
	// Image
	private var taken:Bool;

	// Create
	public function new(x:Float, y:Float):Void {
		// Construct parent
		super(x, y, AssetPaths.crown__png);

		// Init vars
		this.taken = false;

		// Images and animations
		loadGraphic(AssetPaths.crown__png, true, 16, 32);
		this.animation.add("twinkle", [0, 1, 2, 3], 8, true);
		this.animation.add("gone", [4], 8, false);
		this.animation.play("twinkle");
	}

	// Its stolen!
	public function takeCrown() {
		this.animation.play("gone");
		taken = true;
	}

	// Is it gone??
	public function isTaken():Bool {
		return taken;
	}
}
