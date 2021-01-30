package allanly

{
	/**
	 * Tree
	 * ALLAN AND SULLY!
	 * Animated tree for that nature feel
	 * 4/6/15
	 */
	// Librariesimport org.flixel.FlxSprite;

// Torch
public class tree extends FlxSprite
{
	// Image
	[Embed(source = '../../assets/images/tree.png')] private var picTorch:Class;

	// Create
	public function tree(newX:Number, newY:Number)
	{
		// Construct parent
		super(newX, newY, picTorch);

		// Images and animations
		loadGraphic(picTorch, true, false, 48, 64);
		this.addAnimation("bird", [0, 1, 2, 3], 8, true);
		this.addAnimation("still", [0], 8, true);

		// Only some have animation
		if (tools.myRandom(0, 5) == 1)
			this.play("bird");
		else
			this.play("still");
	}
}
}
