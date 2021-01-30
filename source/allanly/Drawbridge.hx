package allanly;

/**
 * Drawbridge
 * ALLAN AND SULLY!
 * A drawbridge that opens with crank
 * 11/6/2015
 */
// Libraries
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

// Torch
class Drawbridge extends FlxSprite {
	// Timers
	private var fall_timer:FlxTimer;

	// Create
	public function new(x:Float, y:Float, width:Float, height:Float) {
		// Construct parent
		super(x, y, AssetPaths.drawbridge__png);

		this.width = width;
		this.height = height;

		this.origin.x = this.width / 2;
		this.origin.y = this.height - this.width / 2;

		this.immovable = true;

		this.fall_timer = new FlxTimer();

		this.solid = true;
	}

	// Spin for test
	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	// Turn crank
	public function fall() {
		this.fall_timer.start(100, fallDown);
		FlxG.sound.play(AssetPaths.bridge__mp3);
	}

	// Turn crank
	public function fallDown(timer:FlxTimer) {
		if (this.angle > -90) {
			this.angle -= 5;
			FlxG.camera.shake();
		}
		else {
			this.angle = -90;

			// For collision
			this.x -= this.height - this.width;
			this.y += this.height - this.width;

			this.offset.x -= this.height - this.width;
			this.offset.y += this.height - this.width;

			var oldWidth:Float = this.width;
			this.width = this.height;
			this.height = oldWidth;
		}
	}
}
