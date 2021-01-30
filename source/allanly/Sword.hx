package allanly;

/*
 * Sword
 * ALLAN AND SULLY!
 * Our main character, jim's, sword
 * 29/5/2015
 */
// Imports
import allanly.Arm;
import flixel.FlxObject;

class Sword extends Arm {
	// Variables
	private var idle:Bool = true;
	private var spinDir:String = "none";

	// Parent
	private var parent:FlxObject;

	// Create bow
	public function new(x:Float, y:Float) {
		super(x, y, AssetPaths.sword_arm__png);
	}

	// Update bow
	public override function update(elapsed:Float) {
		super.update(elapsed);

		// Spin that sword
		if (this.spinDir == "right") {
			this.angle += 30;
		}
		else if (this.spinDir == "left") {
			this.angle -= 30;
		}
	}

	// Change location
	public override function setPosition(x:Float = 0, y:Float = 0) {
		super.setPosition(x + 5, y - 8);
	}

	// SEt dir of spin
	public function setSpinDir(spinDir:String) {
		this.spinDir = spinDir;
	}
}
