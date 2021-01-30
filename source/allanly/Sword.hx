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
import flixel.math.FlxPoint;

class Sword extends Arm {
	// Variables
	private var idle:Bool = true;
	private var spinDir:String = "none";

	// Parent
	private var parent:FlxObject;

	// Create bow
	public function new(x:Float, y:Float, newMaxPower:Float) {
		super(x, y, AssetPaths.swordArm__png);
	}

	// Update bow
	public override function update(elapsed:Float) {
		super.update(elapsed);

		// Spin that sword
		if (spinDir == "right") {
			angle += 30;
		}
		else if (spinDir == "left") {
			angle -= 30;
		}
	}

	// Change location
	// public override function setPosition(newPosition:FlxPoint, offsetX:Int = 0, offsetY:Int = 0) {
	// 	super.setPosition(newPosition, 5, -8);
	// }
	// SEt dir of spin
	public function setSpinDir(newSpinDir:String) {
		spinDir = newSpinDir;
	}
}
