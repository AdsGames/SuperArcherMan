package allanly;

/**
 * Arrow
 * ALLAN AND SULLY!
 * Arrows and nice stuff!
 * 31/5/2015
 */
// Imports
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

// Realistic arrows
class Arrow extends FlxSprite {
  private var parent:FlxObject;

  // Dead arrow
  public var dead:Bool;

  // Already hit an enemy
  public var hasHit:Bool;

  // Create arrow
  public function new(parent:FlxObject) {
    super(0, 0, AssetPaths.arrow__png);
    this.parent = parent;

    // Shrink box
    offset.y = 1;
    height -= 2;
    offset.x = 7;
    width -= 13;

    solid = true;
  }

  // Shoot arrow (also used when recycled)
  public function fire(x:Float, y:Float, angle:Float = 0, velocity:Float = 2, mass:Float = 1) {
    setPosition(x, y);
    this.angle = angle;
    this.mass = mass;
    this.velocity.x = -Math.cos((angle + 90) * (Math.PI / 180)) * velocity;
    this.velocity.y = -Math.sin((angle + 90) * (Math.PI / 180)) * velocity;

    dead = false;
    hasHit = false;

    // Make sure x/y velocity is never 0 to help below scripts
    if (this.velocity.x == 0) {
      this.velocity.x = 0.01;
    }
    if (this.velocity.y == 0) {
      this.velocity.y = 0.01;
    }

    // Init sound
    FlxG.sound.create(AssetPaths.bow_release__mp3)
      .setup(1, false, true)
      .proximity(x, y, parent, 400, true)
      .play();
  }

  // Update arrow
  override public function update(elapsed:Float) {
    super.update(elapsed);

    // Left the world (arrows above the map can still fall back in)
    var bounds = FlxG.worldBounds;
    if (x + width < bounds.left || x > bounds.right || y > bounds.bottom) {
      kill();
      return;
    }

    // Update unless dead
    if (!dead) {
      // Fall a bit
      if (velocity.y == 0 || velocity.x == 0) {
        velocity.y = 0;
        velocity.x = 0;
        dead = true;
        FlxG.sound.create(AssetPaths.arrow_hit__mp3)
          .setup(1, false, true)
          .proximity(x, y, parent, 800, true)
          .play();
      }
      else {
        // Fall down
        velocity.y += mass;

        // Point in proper direction
        angle = Math.atan2(velocity.y, velocity.x) * 180 / Math.PI;
      }
    }
  }
}
