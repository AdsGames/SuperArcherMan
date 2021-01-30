package allanly;

/**
 * Enemy
 * ALLAN AND SULLY!
 * This is the enemy, the archnemeis of our hero JIM!
 * 1/6/2015
 */
// Libraries
import allanly.Sword;
import allanly.Tools;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

// Swinging enemies
class Enemy extends Character {
	private var heySound:FlxSound;

	// Shooting
	private var sword:Sword;

	// Variables
	private var detected:Bool = false;

	// Pointer to jim
	private var jimPointer:Character;

	// Constants
	private var MOVEMENT_SPEED:Int = 200;

	// Create enemy
	public function new(jimPointer:Character, x:Float = 0, y:Float = 0) {
		super(x, y - 40, AssetPaths.enemy__png);

		// Images and animations
		loadGraphic(AssetPaths.enemy__png, true, 14, 30);
		this.animation.add("walk", [0, 1, 2, 3], 10, true);
		this.animation.add("idle", [4, 5, 6, 7], 5, true);
		this.animation.play("idle");

		// Player
		this.jimPointer = jimPointer;

		// Init health
		this.health = 10;

		// Load sounds
		this.heySound = new FlxSound();
		this.heySound.loadEmbedded(AssetPaths.enemy_hey__mp3);
	}

	// Update
	override public function update(elapsed:Float) {
		super.update(elapsed);

		// Update sound
		this.heySound.update(elapsed);

		// Move enemy
		this.move(elapsed);
	}

	// Move around
	override public function move(elapsed:Float) {
		// Detection
		var distance = Tools.getDistance(new FlxPoint(this.x, this.y), new FlxPoint(this.jimPointer.x, this.jimPointer.y));
		if (!this.detected && distance < 50 && this.health > 0) {
			this.detected = true;

			// Hey! sound
			this.heySound.proximity(this.x, this.y, this.jimPointer, 800, true);
			this.heySound.play();
		}
		// Right
		if (detected && this.x < jimPointer.x) {
			this.sword.setSpinDir("right");
			this.velocity.x = this.MOVEMENT_SPEED;
			this.animation.play("walk");

			// Flip
			if (this.scale.x < 0) {
				this.scale.x *= -1;
			}
		}
		// Left
		else if (detected && this.x > jimPointer.x) {
			this.sword.setSpinDir("left");
			this.velocity.x = -this.MOVEMENT_SPEED;
			this.animation.play("walk");

			// Flip
			if (this.scale.x > 0) {
				this.scale.x *= -1;
			}
		}
		// Idleing
		else {
			sword.setSpinDir("none");
			this.animation.play("idle");
		}

		// Move sword to self
		this.sword.setPosition(this.x, this.y);

		// Parent move
		super.move(elapsed);
	}

	// Get hit
	public function getHit(velocity:Float) {
		this.health -= Math.abs(velocity);
	}

	// Give sword
	public function pickupSword() {
		// Nice sword
		this.sword = new Sword(this.y + 1, this.x + 9);
		FlxG.state.add(this.sword);
	}
}
