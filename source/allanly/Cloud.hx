package allanly;

/**
 * Cloud
 * ALLAN AND SULLY!
 * Animated torch for that castle feel
 * 11/6/2015
 */
// Libraries
import flixel.FlxG;
import flixel.FlxSprite;

class Cloud extends FlxSprite {
  // Create
  public function new(x:Float = 0, y:Float = 0) {
    // Construct parent
    super(x, y, AssetPaths.cloud__png);
  }

  // Place and randomize (also used when recycled)
  public function spawn(x:Float, y:Float) {
    setPosition(x, y);
    velocity.x = Tools.myRandom(5, 20);
    scale.x = Tools.myRandom(5, 20) / 10;
  }

  // Update
  override public function update(elapsed:Float) {
    // Update parent
    super.update(elapsed);

    // Gone past the level
    if (x > FlxG.worldBounds.right) {
      kill();
    }
  }
}
