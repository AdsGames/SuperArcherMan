package allanly 
{
	/**
	 * Sword
	 * ALLAN AND SULLY!
	 * Our main character, jim's, sword
	 * 29/5/15
	 */
	
	// Imports
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import allanly.arm;
	import org.flixel.FlxPoint;
	import org.flixel.FlxU;
	import Math;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	 
	public class sword extends arm{
		// Bow image
		[Embed(source = '../../assets/images/swordArm.png')] 
		private var picArm:Class;	
		
		// Variables
		private var idle:Boolean = true;
		private var spinDir:String = "none";
		
		// Parent
		private var parent:FlxObject;
		
		// Create bow
		public function sword( newX:int, newY:int, newMaxPower:Number) {
			super( newX, newY, picArm);
		}
		
		// Update bow
		public override function update():void {
			super.update();
			
			// Spin that sword
			if ( spinDir == "right") {
				angle += 30;
			}
			else if ( spinDir == "left") {
				angle -= 30;
			}
		}
		
		// Change location
		public override function setPosition( newPosition:FlxPoint, offsetX:int = 0, offsetY:int = 0):void {
			super.setPosition( newPosition, 5, -8);
		}
		
		// SEt dir of spin
		public function setSpinDir( newSpinDir:String):void {
			spinDir = newSpinDir;
		}
	}
}