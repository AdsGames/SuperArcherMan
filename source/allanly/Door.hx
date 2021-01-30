package allanly;

/**
 * Door
 * ALLAN AND SULLY!
 * This is the enemy, the archnemeis of our hero JIM!
 * 3/6/2015
 */
// Libraries
import Math;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flixel.FlxG;
import flixel.FlxSprite;

// Door (fun to kick in)
class Door extends FlxSprite {
	// Timer for animating door
	private var tick_timer:Timer;
	private var tick_count:Int;

	private var doorSpeed:Float;
	private var doorPosition:Float;

	private var open:Bool = false;

	// Create a nice one
	public function new(x:Float, y:Float) {
		super(x, y, AssetPaths.door__png);

		// Set orgin
		this.origin.x = 0;
		this.origin.y = 0;

		// Setup timer
		tick_timer = new Timer(100);
		tick_timer.addEventListener(TimerEvent.TIMER, timer_ticker);
		tick_count = 0;

		// Close the door
		this.scale.x = 0.2;
		this.doorSpeed = 0;
		this.doorPosition = 0;

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

	// Ticker for bow power
	private function timer_ticker(event:TimerEvent) {
		tick_count++;
	}
}
