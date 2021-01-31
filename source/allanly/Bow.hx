package allanly;

/*
 * Bow
 * ALLAN AND SULLY!
 * Our main character, jim's, bow
 * 29/5/2015
 */
// Imports
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

class Bow extends Arm {
	// Variables
	private var maxPower:Float;
	private var chargeTime:Float;
	private var minPower:Float;

	// Container of arrows
	private var arrowContainer:FlxGroup;

	// Variables
	private var powerTimer:FlxTimer;
	private var power:Float;

	// Create bow
	public function new(maxPower:Float = 100.0, chargeTime:Float = 1.0, minPower:Float = 20.0) {
		super(AssetPaths.bow_arm__png);

		// Init vars
		this.power = 0;
		this.powerTimer = new FlxTimer();

		// Set max power it can shoot with
		this.maxPower = maxPower;
		this.chargeTime = chargeTime;
		this.minPower = minPower;

		// Arrow container
		this.arrowContainer = new FlxGroup();
		FlxG.state.add(arrowContainer);
	}

	// Update bow
	override public function update(elapsed:Float) {
		super.update(elapsed);

		// Rotate
		this.angle = new FlxPoint(this.x + this.width / 2.0, this.y + this.height / 2.0).angleBetween(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));

		// Make arrows
		if (FlxG.mouse.justPressed) {
			this.powerTimer.start(this.chargeTime / 100.0, this.powerTicker, 0);
		}
		else if (FlxG.mouse.justReleased) {
			// Min velocity
			if (this.power > this.minPower) {
				this.arrowContainer.add(new Arrow(this, this.x + this.width / 2, this.y + this.height / 2, this.angle, this.power, 8));
			}
			this.power = 0;
			this.powerTimer.cancel();
		}
	}

	// Get power
	public function getPower():Int {
		return Math.round(this.power * 100.0 / this.maxPower);
	}

	// Change location
	override public function setPosition(x:Float = 0.0, y:Float = 0.0) {
		super.setPosition(x + 3, y + 2);
	}

	// Return arrows
	public function getArrows():FlxGroup {
		return arrowContainer;
	}

	// Ticker for bow power
	private function powerTicker(timer:FlxTimer) {
		this.power += this.maxPower / 100.0;

		// Keep in bounds
		if (this.power > this.maxPower) {
			this.power = this.maxPower;
		}
	}
}
