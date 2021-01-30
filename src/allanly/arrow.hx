package allanly

{
	/**
	 * Arrow
	 * ALLAN AND SULLY!
	 * Arrows and nice stuff!
	 * 31/5/15
	 */
	// Importsimport org.flixel.FlxObject;
import Math;
import org.flixel.FlxG;
import org.flixel.FlxSound;
import org.flixel.FlxSprite;

// Realistic arrows
public class arrow extends FlxSprite
{
	// Variables for arrow
	[Embed(source = '../../assets/images/arrow.png')] private var picArrow:Class;

	private var parent:FlxObject;

	// Shoot sound and hit sound
	[Embed(source = "../../assets/sounds/arrow_hit.mp3")] private var arrowHit:Class;
	[Embed(source = "../../assets/sounds/bow_release.mp3")] private var bowRelease:Class;

	// Sounds
	private var arrowHitSound:FlxSound;
	private var bowReleaseSound:FlxSound;

	// Dead arrow
	public var dead:Boolean = false;

	// Create arrow
	public function arrow(newParent:FlxObject, newX:Number = 0, newY:Number = 0, newAngle:Number = 0, newVelocity:Number = 2, newMass:Number = 1)
	{
		super(newX, newY, picArrow);
		this.angle = newAngle;
		this.mass = newMass;
		this.velocity.x = -Math.cos((this.angle + 90) * (Math.PI / 180)) * newVelocity;
		this.velocity.y = -Math.sin((this.angle + 90) * (Math.PI / 180)) * newVelocity;

		this.parent = newParent;

		// Shrink box
		offset.y = 1;
		height -= 2;
		offset.x = 7;
		width -= 13;

		// Make sure x/y velocity is never 0 to help below scripts
		if (this.velocity.x == 0)
		{
			this.velocity.x = 0.01;
		}
		if (this.velocity.y == 0)
		{
			this.velocity.y = 0.01;
		}

		// Load sounds
		arrowHitSound = new FlxSound();
		arrowHitSound.loadEmbedded(arrowHit);

		bowReleaseSound = new FlxSound();
		bowReleaseSound.loadEmbedded(bowRelease);

		// Init sound
		bowReleaseSound.proximity(this.x, this.y, this.parent, 400, true);
		bowReleaseSound.play();

		this.solid = true;
	}

	// Update arrow
	public override function update():void
	{
		super.update();

		// Update sounds
		arrowHitSound.update();

		// Update unless dead
		if (!dead)
		{
			// Fall a bit
			if ((this.velocity.y == 0 || this.velocity.x == 0))
			{
				this.velocity.y = 0;
				this.velocity.x = 0;
				dead = true;
				arrowHitSound.proximity(this.x, this.y, this.parent, 800, true);
				arrowHitSound.play();
			}
			else
			{
				// Fall down
				this.velocity.y += this.mass;

				// Point in proper direction
				this.angle = Math.atan2(this.velocity.y, this.velocity.x) * 180 / Math.PI;
			}
		}
	}
}
}
