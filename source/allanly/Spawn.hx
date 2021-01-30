package allanly;

/**
 * ALLAN AND SULLY!
 * Spawnpoint, where you come from and where you go
 * 4/6/2015
 */
// Libraries
import flixel.FlxSprite;

class Spawn extends FlxSprite {
	public function new(x:Float, y:Float, width:Float, height:Float) {
		// Construct parent
		super(x, y);
		this.width = width;
		this.height = height;
		this.visible = false;
	}
}
