package allanly

{
	/**
	 * Door
	 * ALLAN AND SULLY!
	 * This is the enemy, the archnemeis of our hero JIM!
	 * 3/6/15
	 */
	// Librariesimport org.flixel.FlxSprite;
import Math;
import flash.events.TimerEvent;
import flash.utils.Timer;
import org.flixel.FlxG;

// Door (fun to kick in)
public class door extends FlxSprite
{
	// Image
	[Embed(source = '../../assets/images/door.png')] private var picDoor:Class;

	// Timer for animating door
	private var tick_timer:Timer;
	private var tick_count:Number;

	private var doorSpeed:Number;
	private var doorPosition:Number;

	private var open:Boolean = false;

	// Create a nice one
	public function door(newX:int, newY:int)
	{
		super(newX, newY, picDoor);

		// Set orgin
		this.origin.x = 0;
		this.origin.y = 0;

		// Setup timer
		tick_timer = new Timer(100);
		tick_timer.addEventListener(TimerEvent.TIMER, timer_ticker);
		tick_count = 0;

		// Close the door
		this.scale.x = 0.2;
		this.doorSpeed = 0;
		this.doorPosition = 0;

		// Cant move
		this.immovable = true;
	}

	// Update
	public override function update():void
	{
		super.update();

		// Slow down
		doorPosition += doorSpeed;
		doorSpeed /= 1.02;

		// Swinging
		this.scale.x = Math.sin(doorPosition) + 0.2;
	}

	// Open door
	public function hitDoor(magnitude:Number):void
	{
		// Only move if its not already open
		if (this.scale.x < 0.6 && this.scale.x > -0.6)
		{
			doorSpeed = magnitude / 1000;
		}
	}

	// Ticker for bow power
	private function timer_ticker(event:TimerEvent):void
	{
		tick_count++;
	}
}
}
