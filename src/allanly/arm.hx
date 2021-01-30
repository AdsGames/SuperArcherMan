package allanly

{
	/**
	 * Arm
	 * ALLAN AND SULLY!
	 * Arm for players
	 * 3/6/15
	 */
	// Importsimport org.flixel.FlxSprite;
import Math;
import flash.events.TimerEvent;
import flash.utils.Timer;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxU;

// Arm that attatches to player
public class arm extends FlxSprite
{
	// Variables
	protected var tick_timer:Timer;
	protected var tick_count:Number;

	// Create bow
	public function arm(newX:int, newY:int, picArm:Class)
	{
		super(newX, newY, picArm);

		// Setup timer
		tick_timer = new Timer(10);
		tick_timer.addEventListener(TimerEvent.TIMER, timer_ticker);
		tick_count = 0;
	}

	// Update bow
	public override function update():void
	{
		super.update();
	}

	// Change location
	public function setPosition(newPosition:FlxPoint, offsetX:int = 0, offsetY:int = 0):void
	{
		this.x = newPosition.x + offsetX;
		this.y = newPosition.y + offsetY;
	}

	// Ticker for bow power
	private function timer_ticker(event:TimerEvent):void
	{
		tick_count++;
	}
}
}
