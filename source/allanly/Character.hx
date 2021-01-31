package allanly;

/**
 * Character
 * Allan and Sully!
 * Top level character class
 * 29/5/2015
 */
import flixel.FlxSprite;

class Character extends FlxSprite {
	// Variables
	public var jumping:Bool = false;
	public var ignoreGravity:Bool = false;

	// Acceleration (1m = 16px, gravity acceleration = 9.8m/s)
	private static inline var GRAVITY:Float = 9.8 * 16 * 4;

	// Make character
	public function new(x:Float, y:Float, img:String) {
		super(x, y, img);

		// Gravity
		this.acceleration.y = GRAVITY;
	}

	// Move character
	public function move(elapsed:Float) {
		// Put back in place
		if (this.x < 0) {
			this.x = 0;
		}
		if (this.y < 0) {
			this.y = 0;
		}
	}

	// Update
	override public function update(elapsed:Float) {
		// Velocity from falling
		if (this.ignoreGravity) {
			this.velocity.y = 0;
		}

		// Jump
		if (this.velocity.y == 0) {
			this.jumping = false;
		}

		// Reduce x velocity
		if (this.velocity.x != 0) {
			this.velocity.x /= 2;
		}

		super.update(elapsed);
	}

	// Jump
	public function jump(magnitude:Float) {
		if (!this.jumping && !this.ignoreGravity) {
			this.y -= 4;
			this.velocity.y = -magnitude;
			this.jumping = true;
		}
	}
}
