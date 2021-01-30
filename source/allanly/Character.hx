package allanly;

/**
 * Character
 * Allan and Sully!
 * Top level character class
 * 29/5/2015
 */
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Character extends FlxSprite {
	// Variables
	public var jumping:Bool = false;
	public var direction:String = "idle";
	public var colliding:Bool = false;
	public var ignoreGravity:Bool = false;
	public var position:FlxPoint;

	// Timers
	private var physics_timer:Timer;

	// Constants
	// Acceleration (1m = 16px, gravity acceleration = 9.8m/s)
	private var gravity_acceleration:Float = 9.8 * 16 * 4;
	// Number of SECONDS per 1 physics update. Lower numbers are more taxing but more accurate
	private var physics_interval:Float = 0.005;

	// Make character
	public function new(x:Float, y:Float, img:String) {
		super(x, y, img);

		this.physics_timer = new Timer(physics_interval * 1000);
		this.physics_timer.addEventListener(TimerEvent.TIMER, doPhysics);
		this.physics_timer.start();

		this.position = new FlxPoint(this.x, this.y);

		// Gravity
		this.acceleration.y = gravity_acceleration;
	}

	// Move character
	public function move() {
		// Put back in place
		if (this.x < 0)
			this.x = 0;
		if (this.y < 0)
			this.y = 0;
	}

	// Update
	override public function update(elapsed:Float) {
		super.update(elapsed);

		// Velocity from falling
		if (ignoreGravity)
			this.velocity.y = 0;

		// Jump
		if (this.velocity.y == 0) {
			jumping = false;
		}

		// Reduce x velocity
		if (velocity.x != 0) {
			velocity.x /= 2;
		}

		// Position
		position.x = this.x;
		position.y = this.y;
	}

	// Jump
	public function jump(magnitude:Float) {
		if (!jumping) {
			this.velocity.y = -magnitude;
			jumping = true;
		}
	}

	// Update physics
	public function doPhysics(event:TimerEvent) {}
}
