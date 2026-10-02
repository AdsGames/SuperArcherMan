package allanly;

/**
 * Background
 * ALLAN AND SULLY!
 * Background handler
 * 14/6/2015
 */
// Libraries
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Background extends FlxTypedGroup<FlxSprite> {
  // Create
  public function new(width:Int) {
    super();

    // Add backgrounds
    var t:Int = 0;
    while (t < width) {
      var paralax:FlxSprite = new FlxSprite(t, 0, AssetPaths.mountains__png);
      paralax.scrollFactor.x = 0.5;
      add(paralax);
      t += FlxG.width;
    }
  }
}
