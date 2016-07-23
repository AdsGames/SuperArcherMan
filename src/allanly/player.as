package allanly 
{
	/**
	 * Player class
	 * ALLAN AND SULLY!
	 * Our main character, jim
	 * 29/5/15
	 */
	
	// Imports
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.system.FlxAnim;
	import allanly.bow;
	import org.flixel.FlxGroup;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class player extends character {
		// Image
		[Embed(source = '../../assets/images/player.png')] 
		private var picChar:Class;
		
		// Sayings
		[Embed(source = "../../assets/sounds/jim_saying1.mp3")]
		private var saying1:Class;
		[Embed(source = "../../assets/sounds/jim_saying2.mp3")]
		private var saying2:Class;
		[Embed(source = "../../assets/sounds/jim_saying3.mp3")]
		private var saying3:Class;
		[Embed(source = "../../assets/sounds/jim_saying4.mp3")]
		private var saying4:Class;
		
		[Embed(source = "../../assets/sounds/cheer.mp3")]
		private var winSound:Class;
		
		
		// Sound
		[Embed(source="../../assets/sounds/bell.mp3")]
		private var soundDeath:Class;
		
		// Timers
		private var dieTimer:Timer;
		private var counter:int = 0;
		
		// Variables
		private var movementSpeed:Number = 160;
		private var isLadder:Boolean = false;
		private var ladderX:Number = 0;
		private var dead:Boolean = false;
		private var hasWon:Boolean = false;
		
		// Shooting
		private	var jims_bow:bow;
		
		// Make character
		public function player( newX:Number = 0, newY:Number = 0) {
			// Create jim
			super( newX, newY, picChar);
			
			// Images and animations
			loadGraphic( picChar, true, false, 14, 30);
			this.addAnimation("walk", [0, 1, 2, 3], 10, true);
			this.addAnimation("idle", [4, 5, 6, 7], 5, true);
			this.addAnimation("climb", [8, 9, 10, 11], 5, true);
			this.addAnimation("die", [12, 13, 14, 15, 16], 5, false);
			this.play("idle");
			
			// Timer
			dieTimer = new Timer(1000);
            dieTimer.addEventListener(TimerEvent.TIMER, counterFunction);
			
			// Add blank arm
			jims_bow = new bow(this.y + 2, this.x + 3, 0);
			
			// Say a little something on creation
			var randomSaying:int = tools.myRandom( 0, 4);
			if ( randomSaying == 1) {
				FlxG.play( saying1);
			}
			else if ( randomSaying == 2) {
				FlxG.play( saying2);
			}
			else if ( randomSaying == 3) {
				FlxG.play( saying3);
			}
			else if ( randomSaying == 4) {
				FlxG.play( saying4);
			}
		}
		
		// Update
		override public function update():void {
			// Update parent
			super.update();
			
			// Kill urself
			if ( !dead && FlxG.keys.K)
				die();
			
			// Move around
			move();
		}
		
		// Move character
		override protected function move():void {
			this.ignoreGravity = isLadder;
			
			if ( !dead) {
				// Move that character
				// Right
				if ( FlxG.keys.D){
					velocity.x = movementSpeed;
					this.play("walk");
					
					// Flip
					if ( this.scale.x < 0) {
						this.scale.x *= -1;
					}
				}
				// Left
				if ( FlxG.keys.A){
					velocity.x = -movementSpeed;
					this.play("walk");
					
					// Flip
					if ( this.scale.x > 0) {
						this.scale.x *= -1;
					}
				}
				
				// Ladder
				if( isLadder){
					if ( FlxG.keys.W) {
						this.play("climb");
						this.y -= 1;
					}
					else if ( FlxG.keys.S) {
						this.play("climb");
						this.y += 1;
					}
				}
				
				// Jump Jump!
				if ( FlxG.keys.SPACE) {
					this.jump( 250);
				}
				
				// Idleingd
				if ( !FlxG.keys.A && !FlxG.keys.D && !isLadder) {
					this.play("idle");
				}
				
				// Win
				if ( hasWon && counter >= 3) {
					FlxG.music.stop();
					dieTimer.stop();
					counter = 0;
					FlxG.switchState(new MenuState);
				}
				
				// Move bow to player
				jims_bow.setPosition( position);
			}
			// Restart
			else if ( dead && counter >= 3) {
				FlxG.music.stop();
				dieTimer.stop();
				counter = 0;
				FlxG.switchState(new PlayState);
			}
			
			// Menu
			if ( FlxG.keys.ESCAPE) {
				FlxG.switchState(new MenuState);
			}
			
			super.move();
		}
		
		// Get arrows
		public function getArrows():FlxGroup {
			return jims_bow.getArrows();
		}
		
		// Die
		public function die():void {
			if( !dead){
				this.play("die");
				jims_bow.x = - 100;
				jims_bow.y = -100;
				dead = true;
				FlxG.play( soundDeath);
				counter = 0;
				dieTimer.start();
			}
		}
		
		// Win
		public function win():void {
			if( !hasWon){
				hasWon = true;
				counter = 0;
				dieTimer.start();
				FlxG.play( winSound);
			}
		}
		
		// Ready to climb
		public function onLadder( isOnLadder:Boolean):void {	
			isLadder = isOnLadder;
			
			if( isOnLadder == true){
				if ( FlxG.keys.W || FlxG.keys.S) {
					this.x = ladderX;
				}
			}
		}
		
		// Ready to climb
		public function ladderPosition( newPlayer:player, newLadder:ladder):void {	
			ladderX = newLadder.x;
		}
		
		// Add bow
		public function pickupBow():void {
			// Bow with max power of 12
			jims_bow = new bow(this.y + 2, this.x + 3, 120);
			FlxG.state.add( jims_bow);
		}
		
		// Counter
		private function counterFunction( event:TimerEvent):void {
			counter++;
		}
	}
}

