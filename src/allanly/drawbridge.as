package allanly 
{
	/**
	 * ALLAN AND SULLY!
	 * Nice throne
	 * 11/6/15
	 */
	
	// Libraries
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	// Torch
	public class drawbridge extends FlxSprite{
		// Image
		[Embed(source="../../assets/images/drawbridge.png")]
		private var picDrawbridge:Class;
		
		// Sound
		[Embed(source="../../assets/sounds/bridge.mp3")]
		private var soundBridge:Class;
		
		// Timers
		private var fall_timer:Timer;
		
		// Create
		public function drawbridge( newX:Number, newY:Number, newWidth:Number, newHeight:Number) {
			// Construct parent
			super( newX, newY, picDrawbridge);
		
			this.width = newWidth;
			this.height = newHeight;
			
			this.origin.x = this.width/2;
			this.origin.y = this.height - this.width/2;
			
			this.immovable = true;
			
			fall_timer = new Timer(100);
            fall_timer.addEventListener(TimerEvent.TIMER, fallDown);
		}
		
		// Spin for test
		override public function update():void {
			super.update();
		}
		
		// Turn crank
		public function fall():void {
			fall_timer.start();
			FlxG.play(soundBridge);
		}
		
		// Turn crank
		public function fallDown(event:TimerEvent):void {
			if( this.angle > -90){
				this.angle -= 5;
				FlxG.camera.shake.apply();
			}
			else{
				this.angle = -90;
				fall_timer.stop();
				
				// For collision
				this.x -= this.height - this.width;
				this.y += this.height - this.width;
				
				this.offset.x -= this.height - this.width;
				this.offset.y += this.height - this.width;
				
				var oldWidth:Number = this.width;
				this.width = this.height;
				this.height = oldWidth;
			}
		}
	}
}