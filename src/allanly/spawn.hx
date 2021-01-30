package allanly

{
	/**
	 * ALLAN AND SULLY!
	 * Spawnpoint, where you come from and where you go
	 * 4/6/15
	 */
	// Librariesimport org.flixel.FlxSprite;

// Spawn
public class spawn extends FlxSprite
{
	public function spawn(newX:Number, newY:Number, newWidth:Number, newHeight:Number)
	{
		// Construct parent
		super(newX, newY);
		this.width = newWidth;
		this.height = newHeight;
		this.visible = false;
	}
}
}
