package allanly 
{
	/**
	 * Character
	 * Allan and Sully!
	 * Top level character class
	 * 29/5/15
	 */
	import flash.events.Event;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class character extends FlxSprite {
		// Variables
		protected var jumping:Boolean = false;
		protected var direction:String = "idle";
		protected var colliding:Boolean = false;
		protected var ignoreGravity:Boolean = false;
		public var position:FlxPoint;
		
		// Timers
		private var physics_timer:Timer;
		
		// Constants
		// Acceleration (1m = 16px, gravity acceleration = 9.8m/s)
		private const gravity_acceleration:Number = 9.8 * 16 * 4;
		
		// Number of SECONDS per 1 physics update. Lower numbers are more taxing but more accurate
		private const physics_interval:Number = 0.005;
		
		// Make character
		public function character(newX:Number, newY:Number, newPic:Class) {
			super(newX, newY, newPic);
			
			physics_timer = new Timer(physics_interval * 1000);
            physics_timer.addEventListener(TimerEvent.TIMER, doPhysics);
            physics_timer.start();
			
			position = new FlxPoint( this.x, this.y);
			
			// Gravity
			this.acceleration.y = gravity_acceleration;
		}
		
		// Move character
		protected function move():void {
			// Put back in place
			if ( this.x < 0)
				this.x = 0;
			if ( this.y < 0)
				this.y = 0;
		}
		
		// Update
		override public function update():void {
			// Velocity from falling
			if( ignoreGravity)
				this.velocity.y = 0;
			
			// Jump
			if ( this.velocity.y == 0) {
				jumping = false;
			}
			
			// Reduce x velocity
			if ( velocity.x != 0){
				velocity.x /= 2;
			}
			
			// Position
			position.x = this.x;
			position.y = this.y;
			
			super.update();
		}
		
		// Jump
		protected function jump( magnitude:Number):void {
			if( !jumping){
				this.velocity.y = -magnitude;
				jumping = true;
			}
		}
		
		// Update physics
		protected function doPhysics( event:TimerEvent):void {
			
		}
	}
}