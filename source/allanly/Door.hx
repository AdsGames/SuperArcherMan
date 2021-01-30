package allanly;

/**
 * Door
 * ALLAN AND SULLY!
 * This is the enemy, the archnemeis of our hero JIM!
 * 3/6/2015
 */
// Libraries
import Math;
import flixel.FlxSprite;

// Door (fun to kick in)
class Door extends FlxSprite {
	private var doorSpeed:Float = 0;
	private var doorPosition:Float = 0;
	private var open:Bool = false;

	// Create a nice one
	public function new(x:Float, y:Float) {
		super(x, y, AssetPaths.door__png);

		// Set orgin
		this.origin.x = 0;
		this.origin.y = 0;

		// Close the door
		this.scale.x = 0.2;

		// Cant move
		this.immovable = true;
	}

	// Update
	public override function update(elapsed:Float) {
		super.update(elapsed);

		// Slow down
		this.doorPosition += this.doorSpeed;
		this.doorSpeed /= 1.02;

		// Swinging
		this.scale.x = Math.sin(doorPosition) + 0.2;
	}

	// Open door
	public function hitDoor(magnitude:Float) {
		// Only move if its not already open
		if (this.scale.x < 0.6 && this.scale.x > -0.6) {
			doorSpeed = magnitude / 1000;
		}
	}
}
