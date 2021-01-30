package allanly;

/**
 * Player class
 * ALLAN AND SULLY!
 * Our main character, jim
 * 29/5/2015
 */
// Imports
import allanly.Bow;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

class Player extends Character {
	// Timers
	private var dieTimer:Timer;
	private var counter:Int = 0;

	// Variables
	private var movementSpeed:Float = 160;
	private var isLadder:Bool = false;
	private var ladderX:Float = 0;
	private var dead:Bool = false;
	private var hasWon:Bool = false;

	// Shooting
	private var jims_bow:Bow;

	// Make character
	public function new(x:Float = 0, y:Float = 0) {
		// Create jim
		super(x, y, AssetPaths.player__png);

		// Images and animations
		loadGraphic(AssetPaths.player__png, true, 14, 30);
		this.animation.add("walk", [0, 1, 2, 3], 10, true);
		this.animation.add("idle", [4, 5, 6, 7], 5, true);
		this.animation.add("climb", [8, 9, 10, 11], 5, true);
		this.animation.add("die", [12, 13, 14, 15, 16], 5, false);
		this.animation.play("idle");

		// Timer
		dieTimer = new Timer(1000);
		dieTimer.addEventListener(TimerEvent.TIMER, counterFunction);

		// Add blank arm
		jims_bow = new Bow(this.y + 2, this.x + 3, 0);

		// Say a little something on creation
		var randomSaying:Int = Tools.myRandom(0, 4);
		if (randomSaying == 1) {
			FlxG.sound.play(AssetPaths.jim_saying1__mp3);
		}
		else if (randomSaying == 2) {
			FlxG.sound.play(AssetPaths.jim_saying2__mp3);
		}
		else if (randomSaying == 3) {
			FlxG.sound.play(AssetPaths.jim_saying3__mp3);
		}
		else if (randomSaying == 4) {
			FlxG.sound.play(AssetPaths.jim_saying4__mp3);
		}
	}

	// Update
	override public function update(elapsed:Float) {
		// Update parent
		super.update(elapsed);

		// Kill urself
		if (!dead && FlxG.keys.pressed.K) {
			die();
		}

		// Move around
		move();
	}

	// Move character
	override public function move() {
		this.ignoreGravity = isLadder;
		if (!dead) {
			// Move that character
			// Right
			if (FlxG.keys.pressed.G) {
				velocity.x = movementSpeed;
				this.animation.play("walk");
				// Flip
				if (this.scale.x < 0) {
					this.scale.x *= -1;
				}
			}
			// Left
			if (FlxG.keys.pressed.A) {
				velocity.x = -movementSpeed;
				this.animation.play("walk");
				// Flip
				if (this.scale.x > 0) {
					this.scale.x *= -1;
				}
			}
			// Ladder
			if (isLadder) {
				if (FlxG.keys.pressed.W) {
					this.animation.play("climb");
					this.y -= 1;
				}
				else if (FlxG.keys.pressed.S) {
					this.animation.play("climb");
					this.y += 1;
				}
			}
			// Jump Jump!
			if (FlxG.keys.pressed.SPACE) {
				this.jump(250);
			}
			// Idleingd
			if (!FlxG.keys.pressed.A && !FlxG.keys.pressed.D && !isLadder) {
				this.animation.play("idle");
			}
			// Win
			if (hasWon && counter >= 3) {
				FlxG.sound.music.stop();
				dieTimer.stop();
				counter = 0;
				FlxG.switchState(new MenuState());
			}
			// Move bow to player
			jims_bow.setPosition(this.x, this.y);
		}
		// Restart
		else if (dead && counter >= 3) {
			FlxG.sound.music.stop();
			dieTimer.stop();
			counter = 0;
			FlxG.switchState(new PlayState());
		}
		// Menu
		if (FlxG.keys.pressed.ESCAPE) {
			FlxG.switchState(new MenuState());
		}
		super.move();
	}

	// Get arrows
	public function getArrows() {
		return jims_bow.getArrows();
	}

	// Die
	public function die() {
		if (!dead) {
			this.animation.play("die");
			jims_bow.x = -100;
			jims_bow.y = -100;
			dead = true;
			FlxG.sound.play(AssetPaths.bell__mp3);
			counter = 0;
			dieTimer.start();
		}
	}

	// Win
	public function win() {
		if (!hasWon) {
			hasWon = true;
			counter = 0;
			dieTimer.start();
			FlxG.sound.play(AssetPaths.cheer__mp3);
		}
	}

	// Ready to climb
	public function onLadder(isOnLadder:Bool) {
		isLadder = isOnLadder;

		if (isOnLadder == true) {
			if (FlxG.keys.pressed.W || FlxG.keys.pressed.S) {
				this.x = ladderX;
			}
		}
	}

	// Ready to climb
	public function ladderPosition(newPlayer:Player, newLadder:Ladder) {
		ladderX = newLadder.x;
	}

	// Add bow
	public function pickupBow() {
		// Bow with max power of 12
		jims_bow = new Bow(this.y + 2, this.x + 3, 120);
		FlxG.state.add(jims_bow);
	}

	// Counter
	private function counterFunction(event:TimerEvent) {
		counter++;
	}
}
