package;

/**
 * ALLAN AND SULLY!
 * Creator of game state
 * 5/28/15
 */
// Importsimport org.flixel.FlxGame;
import org.flixel.FlxG;
import org.flixel.plugin.photonstorm.*;

public class FirstGame extends FlxGame
{
	// Cursor image
	[Embed(source = '../assets/images/cursor.png')] private var picCursor:Class;

	public function FirstGame()
	{
		// Create the menu state
		super(640, 480, MenuState, 1);

		// Load custom cursor and then hide hardware
		// cursor
		FlxG.mouse.load(picCursor, 1, -7, -7);
		FlxG.mouse.hide();
	}
}
