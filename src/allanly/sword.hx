package allanly

{
	/**
	 * Sword
	 * ALLAN AND SULLY!
	 * Our main character, jim's, sword
	 * 29/5/15
	 */
	// Importsimport org.flixel.FlxObject;
import Math;
import allanly.arm;
import flash.events.TimerEvent;
import flash.utils.Timer;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxU;

public class sword extends arm
{
	// Bow image
	[Embed(source = '../../assets/images/swordArm.png')] private var picArm:Class;

	// Variables
	private var idle:Boolean = true;
	private var spinDir:String = "none";

	// Parent
	private var parent:FlxObject;

	// Create bow
	public function sword(newX:int, newY:int, newMaxPower:Number)
	{
		super(newX, newY, picArm);
	}

	// Update bow
	public override function update():void
	{
		super.update();

		// Spin that sword
		if (spinDir == "right")
		{
			angle += 30;
		}
		else if (spinDir == "left")
		{
			angle -= 30;
		}
	}

	// Change location
	public override function setPosition(newPosition:FlxPoint, offsetX:int = 0, offsetY:int = 0):void
	{
		super.setPosition(newPosition, 5, -8);
	}

	// SEt dir of spin
	public function setSpinDir(newSpinDir:String):void
	{
		spinDir = newSpinDir;
	}
}
}
