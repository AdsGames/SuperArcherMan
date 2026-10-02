package allanly;

/*
 * Bow
 * ALLAN AND SULLY!
 * Our main character, jim's, bow
 * 29/5/2015
 */
// Imports
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;

class Bow extends Arm {
  // Variables
  private var maxPower:Float;
  private var chargeTime:Float;
  private var minPower:Float;

  // Container of arrows
  private var arrowContainer:FlxTypedGroup<Arrow>;

  // Oldest arrows get reused past this
  private static inline final MAX_ARROWS:Int = 50;

  // Variables
  private var charging:Bool;
  private var power:Float;

  // Create bow
  public function new(maxPower:Float = 100.0, chargeTime:Float = 1.0, minPower:Float = 20.0) {
    super(AssetPaths.bow_arm__png);

    // Init vars
    power = 0;
    charging = false;

    // Set max power it can shoot with
    this.maxPower = maxPower;
    this.chargeTime = chargeTime;
    this.minPower = minPower;

    // Arrow container
    arrowContainer = new FlxTypedGroup<Arrow>(MAX_ARROWS);
    FlxG.state.add(arrowContainer);
  }

  // Update bow
  override public function update(elapsed:Float) {
    super.update(elapsed);

    // Rotate, gamepad keeps the last angle while the stick is at rest
    if (Controls.usingGamepad) {
      if (Controls.aimAngle != null) {
        angle = Controls.aimAngle + 90;
      }
    }
    else {
      angle = FlxAngle.degreesFromOrigin(FlxG.mouse.x - (x + width / 2.0), FlxG.mouse.y - (y + height / 2.0)) + 90;
    }

    if (charging) {
      charge(elapsed);
    }

    // Make arrows
    if (Controls.fireJustPressed()) {
      charging = true;
    }
    else if (Controls.fireJustReleased()) {
      // Min velocity
      if (power > minPower) {
        arrowContainer.recycle(Arrow, () -> new Arrow(this)).fire(x + width / 2, y + height / 2, angle, power, 8);
      }
      power = 0;
      charging = false;
    }
  }

  // Get power
  public function getPower():Int {
    return Math.round(power * 100.0 / maxPower);
  }

  // Change location
  override public function setPosition(x:Float = 0.0, y:Float = 0.0) {
    super.setPosition(x + 3, y + 2);
  }

  // Return arrows
  public function getArrows():FlxTypedGroup<Arrow> {
    return arrowContainer;
  }

  // Build up bow power, full after chargeTime seconds
  private function charge(elapsed:Float) {
    power += maxPower * (elapsed / chargeTime);

    // Keep in bounds
    if (power > maxPower) {
      power = maxPower;
    }
  }
}
