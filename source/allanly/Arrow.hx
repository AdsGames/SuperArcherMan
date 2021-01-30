package allanly;

/**
 * Arrow
 * ALLAN AND SULLY!
 * Arrows and nice stuff!
 * 31/5/2015
 */
// Imports
import Math;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;

// Realistic arrows
class Arrow extends FlxSprite {
	private var parent:FlxObject;

	// Sounds
	private var arrowHitSound:FlxSound;
	private var bowReleaseSound:FlxSound;

	// Dead arrow
	public var dead:Bool = false;

	// Create arrow
	public function new(parent:FlxObject, x:Float = 0, y:Float = 0, angle:Float = 0, velocity:Float = 2, mass:Float = 1) {
		super(x, y, AssetPaths.arrow__png);
		this.angle = angle;
		this.mass = mass;
		this.velocity.x = -Math.cos((this.angle + 90) * (Math.PI / 180)) * velocity;
		this.velocity.y = -Math.sin((this.angle + 90) * (Math.PI / 180)) * velocity;

		this.parent = parent;

		// Shrink box
		offset.y = 1;
		height -= 2;
		offset.x = 7;
		width -= 13;

		// Make sure x/y velocity is never 0 to help below scripts
		if (this.velocity.x == 0) {
			this.velocity.x = 0.01;
		}
		if (this.velocity.y == 0) {
			this.velocity.y = 0.01;
		}

		// Load sounds
		arrowHitSound = new FlxSound();
		arrowHitSound.loadEmbedded(AssetPaths.arrow_hit__mp3);

		bowReleaseSound = new FlxSound();
		bowReleaseSound.loadEmbedded(AssetPaths.bow_release__mp3);

		// Init sound
		bowReleaseSound.proximity(this.x, this.y, this.parent, 400, true);
		bowReleaseSound.play();

		this.solid = true;
	}

	// Update arrow
	public override function update(elapsed:Float) {
		super.update(elapsed);

		// Update sounds
		arrowHitSound.update(elapsed);

		// Update unless dead
		if (!dead) {
			// Fall a bit
			if (this.velocity.y == 0 || this.velocity.x == 0) {
				this.velocity.y = 0;
				this.velocity.x = 0;
				dead = true;
				arrowHitSound.proximity(this.x, this.y, this.parent, 800, true);
				arrowHitSound.play();
			}
			else {
				// Fall down
				this.velocity.y += this.mass;

				// Point in proper direction
				this.angle = Math.atan2(this.velocity.y, this.velocity.x) * 180 / Math.PI;
			}
		}
	}
}
