package allanly;

/**
 * Player class
 * ALLAN AND SULLY!
 * Our main character, jim
 * 29/5/2015
 */
// Imports
import allanly.Bow;
import flixel.FlxG;
import flixel.util.FlxTimer;

class Player extends Character {
	// Timers
	private var counter:Int = 0;

	// Variables
	private var isOnLadder:Bool = false;
	private var ladderX:Float = 0;
	private var dead:Bool = false;
	private var hasWon:Bool = false;

	// Constants
	private var JUMP_VELOCITY:Float = 250.0;
	private var DEATH_TIMER:Float = 3;
	private var MOVEMENT_SPEED:Float = 200;

	// Shooting
	private var bow:Bow;

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

		// Add blank arm
		this.bow = new Bow(this.y + 2, this.x + 3, 0);

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

		trace(elapsed);

		// Kill urself
		if (!this.dead && FlxG.keys.pressed.K) {
			this.die();
		}

		// Move around
		this.move(elapsed);
	}

	// Move character
	override public function move(elapsed:Float) {
		this.ignoreGravity = this.isOnLadder;
		if (!this.dead) {
			// Move that character
			// Right
			if (FlxG.keys.pressed.D) {
				this.velocity.x = this.MOVEMENT_SPEED;
				this.animation.play("walk");
				// Flip
				if (this.scale.x < 0) {
					this.scale.x *= -1;
				}
			}
			// Left
			if (FlxG.keys.pressed.A) {
				this.velocity.x = -this.MOVEMENT_SPEED;
				this.animation.play("walk");
				// Flip
				if (this.scale.x > 0) {
					this.scale.x *= -1;
				}
			}
			// Ladder
			if (this.isOnLadder) {
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
				this.jump(this.JUMP_VELOCITY);
			}
			// Idleing
			if (!FlxG.keys.pressed.A && !FlxG.keys.pressed.D && !isOnLadder) {
				this.animation.play("idle");
			}
			// Win
			if (hasWon && counter >= DEATH_TIMER) {
				FlxG.sound.music.stop();
				counter = 0;
				FlxG.switchState(new MenuState());
			}
			// Move bow to player
			bow.setPosition(this.x, this.y);
		}
		// Restart
		else if (dead && counter >= DEATH_TIMER) {
			FlxG.sound.music.stop();
			FlxG.switchState(new PlayState());
		}
		// Menu
		if (FlxG.keys.pressed.ESCAPE) {
			FlxG.switchState(new MenuState());
		}

		super.move(elapsed);
	}

	// Get arrows
	public function getArrows() {
		return this.bow.getArrows();
	}

	// Die
	public function die() {
		if (!dead) {
			this.animation.play("die");
			bow.visible = false;
			dead = true;
			FlxG.sound.play(AssetPaths.bell__mp3);
			this.startTimer();
		}
	}

	// Win
	public function win() {
		if (!hasWon) {
			hasWon = true;
			FlxG.sound.play(AssetPaths.cheer__mp3);
			this.startTimer();
		}
	}

	// Ready to climb
	public function onLadder(isOnLadder:Bool) {
		this.isOnLadder = isOnLadder;

		if (isOnLadder == true) {
			if (FlxG.keys.pressed.W || FlxG.keys.pressed.S) {
				this.x = ladderX;
			}
		}
	}

	// Ready to climb
	public function ladderPosition(player:Player, ladder:Ladder) {
		this.ladderX = ladder.x;
	}

	// Add bow
	public function pickupBow() {
		// Bow with max power of 12
		this.bow = new Bow(this.y + 2, this.x + 3, 120);
		FlxG.state.add(bow);
	}

	private function startTimer() {
		this.counter = 0;
		new FlxTimer().start(1, this.incrementTimer, 0);
	}

	// Death timer
	private function incrementTimer(timer:FlxTimer) {
		counter++;
	}
}
