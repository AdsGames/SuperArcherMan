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
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;

class Bow extends Arm {
	// Variables
	private var maxPower:Float;
	private var shooting_angle:Float = 0;
	private var shooting_power:Float = 0;

	// Power text
	private var powerText:FlxText;

	// Container of arrows
	private var arrow_container:FlxGroup;

	// Create bow
	public function new(x:Float, y:Float, maxPower:Float) {
		super(x, y, AssetPaths.bowArm__png);

		// Set max power it can shoot with
		this.maxPower = maxPower;

		// Arrow container
		this.arrow_container = new FlxGroup();

		// Power text
		this.powerText = new FlxText(0, 40, 100, "");
		FlxG.state.add(powerText);
	}

	// Update bow
	public override function update(elapsed:Float) {
		super.update(elapsed); // Move power text to mouse

		powerText.x = FlxG.mouse.x + 15;
		powerText.y = FlxG.mouse.y;

		powerText.text = "" + Math.round(tick_count / 1.2) + "%";

		// Rotate
		this.angle = new FlxPoint(this.x + this.width / 2, this.y + this.height / 2).angleBetween(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));

		// Make arrows
		if (FlxG.mouse.justPressed) {
			tick_timer.start();
		}
		else if (FlxG.mouse.justReleased) {
			// Min velocity
			if (this.tick_count > 20) {
				var arrow = new Arrow(this, this.x + this.width / 2, this.y + this.height / 2, this.angle, tick_count * 5, 8);
				arrow_container.add(arrow);
				FlxG.state.add(arrow);
			}
			this.tick_count = 0;
			// tick_timer.stop();
		}

		// Counter
		if (this.tick_count > 0) {
			// Keep in bounds
			if (this.tick_count > maxPower) {
				this.tick_count = this.maxPower;
			}
		}
	}

	// Change location
	// public override function setPosition(newPosition:FlxPoint, offsetX:Int = 0, offsetY:Int = 0) {
	// 	super.setPosition(newPosition, 3, 2);
	// }
	// Return arrows
	public function getArrows():FlxGroup {
		return arrow_container;
	}
}
