package allanly 
{
	/**
	 * ALLAN AND SULLY!
	 * Our main character, jim's, bow
	 * 29/5/15
	 */
	
	// Imports
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import Math;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import org.flixel.plugin.photonstorm.FlxBar;
	 
	public class bow extends arm{
		// Bow image
		[Embed(source = '../../assets/images/bowArm.png')] 
		private var picArm:Class;	
		
		// Variables
		private var maxPower:Number;
		private var shooting_angle:Number = 0;
		private var shooting_power:Number = 0;
		
		// Power text
		private var powerText:FlxText;
		
		// Container of arrows
		private var arrow_container:FlxGroup;
		
		// Create bow
		public function bow( newX:int, newY:int, newMaxPower:Number) {
			super( newX, newY, picArm);
			
			// Set max power it can shoot with
			maxPower = newMaxPower;
			
			// Arrow container
			arrow_container = new FlxGroup();
			
			// Power text 
			powerText = new FlxText( 0, 40, 100, "swag");
			FlxG.state.add( powerText);
		}
		
		// Update bow
		public override function update():void {
			super.update();
			
			// Move power text to mouse
			powerText.x = FlxG.mouse.x + 15;
			powerText.y = FlxG.mouse.y;
			
			powerText.text = String( Math.round(tick_count/1.2)) + "%";
			
			// Rotate
			this.angle = FlxU.getAngle( new FlxPoint(this.x + this.width/2, this.y + this.height/2), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
			
			// Make arrows
			if ( FlxG.mouse.justPressed()) {
				tick_timer.start();
			}
			else if ( FlxG.mouse.justReleased()) {	
				// Min velocity
				if( tick_count > 20){
					var niceArrow:arrow = new arrow( this, this.x+ this.width/2, this.y + this.height/2, this.angle, tick_count*5, 8);
					arrow_container.add( niceArrow);
					FlxG.state.add( niceArrow);
				}
				tick_count = 0;
				tick_timer.stop();
			}
			
			// Counter
			if ( tick_count > 0) {
				// Keep in bounds
				if ( tick_count > maxPower) {
					tick_count = maxPower;
				}
			}
		}
		
		// Change location
		public override function setPosition( newPosition:FlxPoint, offsetX:int = 0, offsetY:int = 0):void {
			super.setPosition(  newPosition, 3, 2);
		}
		
		// Return arrows
		public function getArrows():FlxGroup {
			return arrow_container;
		}
	}
}