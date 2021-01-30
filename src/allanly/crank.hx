package allanly

{
	/**
	 * Crank
	 * ALLAN AND SULLY!
	 * Nice throne
	 * 11/6/15
	 */
	// Librariesimport org.flixel.FlxSprite;

// Torch
public class crank extends FlxSprite
{
	// Image
	[Embed(source = "../../assets/images/crank.png")] private var picCrank:Class;
	private var activated:Boolean = false;

	// Create
	public function crank(newX:Number, newY:Number)
	{
		// Construct parent
		super(newX, newY, picCrank);

		// Images and animations
		loadGraphic(picCrank, true, false, 16, 16);

		this.addAnimation("spin", [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3], 8, false);
		this.addAnimation("stay", [0], 8, false);
		this.play("stay");

		this.solid = true;
	}

	// Turn crank
	public function spin():void
	{
		activated = true;
		this.play("spin");

		trace("Spinning crank");
	}

	// Check if its been spun
	public function getActivated():Boolean
	{
		return activated;
	}
}
}
