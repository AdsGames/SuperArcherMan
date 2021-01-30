package allanly

{
	/**
	 * Enemy
	 * ALLAN AND SULLY!
	 * This is the enemy, the archnemeis of our hero JIM!
	 * 1/6/15
	 */
	// Librariesimport org.flixel.FlxObject;import allanly.sword;
import allanly.tools;
import org.flixel.FlxG;
import org.flixel.FlxSound;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.system.FlxAnim;

// Swinging enemies
public class enemy extends character
{
	// Image
	[Embed(source = '../../assets/images/enemy.png')] private var picEnemy:Class;

	// Sounds
	[Embed(source = "../../assets/sounds/enemy_hey.mp3")] private var enemyHey:Class;

	private var enemyHeySound:FlxSound;

	// Shooting
	private var enemy_sword:sword;

	// Variables
	private var movementSpeed:Number = 160;
	private var detected:Boolean = false;
	private var destination_x:int = 0;
	private var destination_y:int = 0;

	// Pointer to jim
	private var jimPointer:character;

	// Create enemy
	public function enemy(newJimPointer:character, newX:Number = 0, newY:Number = 0)
	{
		// Send constructor to parent
		super(newX, newY - 40, picEnemy);

		// Images and animations
		loadGraphic(picEnemy, true, false, 14, 30);
		this.addAnimation("walk", [0, 1, 2, 3], 10, true);
		this.addAnimation("idle", [4, 5, 6, 7], 5, true);
		this.play("idle");

		// Player
		jimPointer = newJimPointer;

		// Init health
		this.health = 10;

		// Load sounds
		enemyHeySound = new FlxSound();
		enemyHeySound.loadEmbedded(enemyHey);
	}

	// Update
	override public function update():void
	{
		super.update();

		// Move enemy
		this.move();
	}

	// Move around
	override protected function move():void
	{
		// Parent move
		super.move();

		// Random move
		var randomMove:int = tools.myRandom(0, 3);

		// Detection
		if (tools.getDistance(this.position, jimPointer.position) < 50 && !detected && health > 0)
		{
			this.detected = true;

			// Hey! sound
			// enemyHeySound.proximity( this.x, this.y, this.jimPointer, 800, true);
			enemyHeySound.play();
		}

		// Right
		if ((detected && this.x < jimPointer.x))
		{
			enemy_sword.setSpinDir("right");

			this.velocity.x = movementSpeed;
			this.play("walk");

			// Flip
			if (this.scale.x < 0)
			{
				this.scale.x *= -1;
			}
		}
		// Left
		else if ((detected && this.x > jimPointer.x))
		{
			enemy_sword.setSpinDir("left");

			this.velocity.x = -movementSpeed;
			this.play("walk");

			// Flip
			if (this.scale.x > 0)
			{
				this.scale.x *= -1;
			}
		}

		// Idleing
		else
		{
			enemy_sword.setSpinDir("none");
			this.play("idle");
		}

		// Jump Jump!
		/*if ( randomMove == 2) {
			this.jump( 2000);
		}*/

		// Move sword to enemy
		enemy_sword.setPosition(position);
	}

	// Move to player
	public function moveTo(newX:Number, newY:Number):void {}

	// Get hit
	public function getHit(newVelocity:Number):void
	{
		this.health -= Math.abs(newVelocity);
	}

	// Give sword
	public function pickupSword():void
	{
		// Nice sword
		enemy_sword = new sword(this.y + 1, this.x + 9, 8);
		FlxG.state.add(enemy_sword);
	}
}
}
