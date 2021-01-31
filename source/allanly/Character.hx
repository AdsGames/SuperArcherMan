package allanly;

/**
 * Character
 * Allan and Sully!
 * Top level character class
 * 29/5/2015
 */
import flixel.FlxG;
import flixel.FlxSprite;

class Character extends FlxSprite {
	// Variables
	private var jumping:Bool;
	private var ignoreGravity:Bool;

	// Weapon
	private var arm:Arm;

	// Acceleration (1m = 16px, gravity acceleration = 9.8m/s)
	private static inline final GRAVITY:Float = 9.8 * 16 * 4;

	// Make character
	public function new(x:Float, y:Float, img:String) {
		super(x, y, img);

		// Init vars
		this.jumping = false;
		this.ignoreGravity = false;

		// Add blank arm
		this.arm = new Arm();

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

		// Move bow to player
		this.arm.setPosition(this.x, this.y);
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

	// Add arm
	public function pickupArm(arm:Arm) {
		FlxG.state.remove(this.arm);
		this.arm = arm;
		FlxG.state.add(this.arm);
	}

	// Get arm
	public function getArm():Arm {
		return this.arm;
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
