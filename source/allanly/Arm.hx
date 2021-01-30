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
	public var tickTimer:FlxTimer = new FlxTimer();
	public var tickCount:Float = 0;

	// Create arm
	public function new(x:Float, y:Float, image:String) {
		super(x, y, image);
	}

	// Update bow
	public override function update(elapsed:Float) {
		super.update(elapsed);
	}

	// Ticker for bow power
	private function timerTicker(timer:FlxTimer) {
		tickCount++;
	}
}
