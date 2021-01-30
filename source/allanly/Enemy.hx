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
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;

// Swinging enemies
class Enemy extends Character {
	private var enemyHeySound:FlxSound;

	// Shooting
	private var enemy_sword:Sword;

	// Variables
	private var movementSpeed:Int = 160;
	private var detected:Bool = false;
	private var destination_x:Int = 0;
	private var destination_y:Int = 0;

	// Pointer to jim
	private var jimPointer:Character;

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
		this.enemyHeySound = new FlxSound();
		this.enemyHeySound.loadEmbedded(AssetPaths.enemy_hey__mp3);
	}

	// Update
	override public function update(elapsed:Float) {
		super.update(elapsed);

		// Move enemy
		this.move();
	}

	// Move around
	override public function move() {
		// Parent move
		super.move();

		// Random move
		var randomMove:Int = Tools.myRandom(0, 3);

		// Detection
		if (Tools.getDistance(this.position, jimPointer.position) < 50 && !detected && health > 0) {
			this.detected = true;
			// Hey! sound
			// enemyHeySound.proximity( this.x, this.y, this.jimPointer, 800, true);
			enemyHeySound.play();
		}
		// Right
		if (detected && this.x < jimPointer.x) {
			enemy_sword.setSpinDir("right");
			this.velocity.x = movementSpeed;
			this.animation.play("walk");
			// Flip
			if (this.scale.x < 0) {
				this.scale.x *= -1;
			}
		}
		// Left
		else if (detected && this.x > jimPointer.x) {
			enemy_sword.setSpinDir("left");
			this.velocity.x = -movementSpeed;
			this.animation.play("walk");
			// Flip
			if (this.scale.x > 0) {
				this.scale.x *= -1;
			}
		}
		// Idleing
		else {
			enemy_sword.setSpinDir("none");
			this.animation.play("idle");
		}

		// Jump Jump!
		/*if ( randomMove == 2) {
			this.jump( 2000);
		}*/

		// Move sword to enemy
		// enemy_sword.setPosition(jimPointer.position);
	}

	// Move to player
	public function moveTo(x:Float, y:Float) {}

	// Get hit
	public function getHit(newVelocity:Float) {
		this.health -= Math.abs(newVelocity);
	}

	// Give sword
	public function pickupSword() {
		// Nice sword
		enemy_sword = new Sword(this.y + 1, this.x + 9, 8);
		FlxG.state.add(enemy_sword);
	}
}
