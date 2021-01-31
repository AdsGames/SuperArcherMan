package allanly;

/**
 * Player class
 * ALLAN AND SULLY!
 * Our main character, jim
 * 29/5/2015
 */
// Imports
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;

class Player extends Character {
	// Timers
	private var counter:Int;

	// Variables
	private var isOnLadder:Bool;
	private var ladderX:Float;
	private var dead:Bool;
	private var hasWon:Bool;

	// Constants
	private static inline final JUMP_VELOCITY:Float = 250.0;
	private static inline final DEATH_TIMER:Float = 3;
	private static inline final MOVEMENT_SPEED:Float = 200;

	// Make character
	public function new(x:Float = 0, y:Float = 0) {
		// Create jim
		super(x, y, AssetPaths.player__png);

		// Default values
		this.counter = 0;

		// Variables
		this.isOnLadder = false;
		this.ladderX = 0;
		this.dead = false;
		this.hasWon = false;

		// Images and animations
		loadGraphic(AssetPaths.player__png, true, 14, 30);
		this.animation.add("walk", [0, 1, 2, 3], 10, true);
		this.animation.add("idle", [4, 5, 6, 7], 5, true);
		this.animation.add("climb", [8, 9, 10, 11], 5, true);
		this.animation.add("die", [12, 13, 14, 15, 16], 5, false);
		this.animation.play("idle");

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
				this.velocity.x = MOVEMENT_SPEED;
				this.animation.play("walk");
				// Flip
				if (this.scale.x < 0) {
					this.scale.x *= -1;
				}
			}
			// Left
			if (FlxG.keys.pressed.A) {
				this.velocity.x = -MOVEMENT_SPEED;
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
				this.jump(JUMP_VELOCITY);
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
		}
		else if (dead && counter >= DEATH_TIMER) {
			FlxG.sound.music.stop();
			FlxG.switchState(new PlayState(PlayState.levelOn));
		}

		// Menu
		if (FlxG.keys.pressed.ESCAPE) {
			FlxG.switchState(new MenuState());
		}

		super.move(elapsed);
	}

	// Get arrows
	public function getArrows():FlxGroup {
		var bow = Std.downcast(this.getArm(), Bow);
		if (bow != null) {
			return bow.getArrows();
		}
		return null;
	}

	// Die
	public function die() {
		if (!dead) {
			this.animation.play("die");
			arm.visible = false;
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

		if (isOnLadder) {
			if (FlxG.keys.pressed.W || FlxG.keys.pressed.S) {
				this.x = ladderX;
			}
		}
	}

	// Ready to climb
	public function ladderPosition(player:Player, ladder:Ladder) {
		this.ladderX = ladder.x;
	}

	// Start power timer
	private function startTimer() {
		this.counter = 0;
		new FlxTimer().start(1, this.incrementTimer, 0);
	}

	// Death timer
	private function incrementTimer(timer:FlxTimer) {
		counter++;
	}
}
