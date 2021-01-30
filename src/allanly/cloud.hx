package allanly

{
	/**
	 * Cloud
	 * ALLAN AND SULLY!
	 * Animated torch for that castle feel
	 * 11/6/15
	 */
	// Librariesimport org.flixel.FlxSprite;

// Torch
public class cloud extends FlxSprite
{
	// Image
	[Embed(source = '../../assets/images/cloud.png')] private var picCloud:Class;

	// Create
	public function cloud(newX:Number, newY:Number)
	{
		// Construct parent
		super(newX, newY, picCloud);

		// Randomization
		this.velocity.x = tools.myRandom(5, 20);
		this.scale.x = tools.myRandom(5, 20) / 10;
	}

	// Update
	public override function update():void
	{
		// Update parent
		super.update();
	}
}
}
