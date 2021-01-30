package allanly;

/*
 * Bow
 * ALLAN AND SULLY!
 * Our main character, jim's, bow
 * 29/5/2015
 */
// Imports
import Math;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;

class Bow extends Arm {
	// Variables
	private var maxPower:Float;

	// Power text
	private var powerText:FlxText;

	// Container of arrows
	private var arrowContainer:FlxGroup;

	// Create bow
	public function new(x:Float, y:Float, maxPower:Float) {
		super(x, y, AssetPaths.bow_arm__png);

		// Set max power it can shoot with
		this.maxPower = maxPower;

		// Arrow container
		this.arrowContainer = new FlxGroup();

		// Power text
		this.powerText = new FlxText(0, 0, 0, "");
		FlxG.state.add(this.powerText);
	}

	// Update bow
	public override function update(elapsed:Float) {
		super.update(elapsed);

		// Keep in bounds
		if (this.tickCount > maxPower) {
			this.tickCount = this.maxPower;
		}

		// Move power text to mouse
		this.powerText.x = FlxG.mouse.x + 15;
		this.powerText.y = FlxG.mouse.y;

		this.powerText.text = "" + Math.round(tickCount / 1.2) + "%";

		// Rotate
		this.angle = new FlxPoint(this.x + this.width / 2, this.y + this.height / 2).angleBetween(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));

		// Make arrows
		if (FlxG.mouse.justPressed) {
			this.tickTimer.start(0.002, this.timerTicker, 0);
		}
		else if (FlxG.mouse.justReleased) {
			// Min velocity
			if (this.tickCount > 20) {
				var arrow = new Arrow(this, this.x + this.width / 2, this.y + this.height / 2, this.angle, tickCount * 5, 8);
				arrowContainer.add(arrow);
				FlxG.state.add(arrow);
			}
			this.tickCount = 0;
			this.tickTimer.cancel();
		}
	}

	// Change location
	public override function setPosition(x:Float = 0, y:Float = 0) {
		super.setPosition(x + 3, y + 2);
	}

	// Return arrows
	public function getArrows():FlxGroup {
		return arrowContainer;
	}
}
