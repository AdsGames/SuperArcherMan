package;

// Imports
import flixel.FlxGame;
import openfl.display.Sprite;

// Initilize game and run
class Main extends Sprite
{
	public function new():void
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
