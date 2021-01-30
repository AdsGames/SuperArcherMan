package allanly;

/**
 * Arm
 * ALLAN AND SULLY!
 * Arm for players
 * 3/6/2015
 */
// Imports
import flixel.FlxSprite;
import flixel.util.FlxTimer;

// Arm that attatches to player
class Arm extends FlxSprite {
	// Variables
	public var tick_timer:FlxTimer;
	public var tick_count:Float;

	// Create bow
	public function new(x:Float, y:Float, image:String) {
		super(x, y, image);

		// Setup timer
		this.tick_timer = new FlxTimer();
		this.tick_timer.start(10, this.timer_ticker, 0);
		this.tick_count = 0;
	}

	// Update bow
	public override function update(elapsed:Float) {
		super.update(elapsed);
	}

	// Change location
	// public function setPosition(newPosition:FlxPoint, offsetX:Int = 0, offsetY:Int = 0) {
	// 	this.x = newPosition.x + offsetX;
	// 	this.y = newPosition.y + offsetY;
	// }
	// Ticker for bow power
	private function timer_ticker(timer:FlxTimer) {
		tick_count++;
	}
}
