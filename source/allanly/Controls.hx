package allanly;

/**
 * Controls
 * Keyboard, mouse and gamepad input in one place, same bindings as SuperArcherMan2
 */
// Libraries
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class Controls {
  // Right stick push is ignored below the inner deadzone and counts as full past the outer one
  private static inline final AIM_DEADZONE:Float = 0.2;
  private static inline final AIM_OUTER_DEADZONE:Float = 0.95;

  // Stick length dropping this much in one frame means it was let go and is springing back.
  // Aim is held for a moment after, long enough for the stick to settle.
  private static inline final AIM_RELEASE_DROP:Float = 0.25;
  private static inline final AIM_RELEASE_HOLD:Float = 0.1;

  // How fast aim eases toward the stick, per second, for a light and a full push
  private static inline final AIM_TURN_RATE_MIN:Float = 8;
  private static inline final AIM_TURN_RATE_MAX:Float = 30;

  // Smoothed right stick aim in degrees, kept after the stick is let go, null until first used
  public static var aimAngle(default, null):Null<Float> = null;

  // Raw stick direction this frame
  private static var stickAngle:Float = 0;

  // Stick length last frame, and seconds left to hold aim after a release
  private static var lastAimLength:Float = 0;
  private static var aimHeldFor:Float = 0;

  // True when the last input came from a gamepad
  public static var usingGamepad(default, null):Bool = false;

  // Track the last used device, hooked to FlxG.signals.preUpdate by InitState
  public static function poll() {
    #if FLX_MOUSE
    if (FlxG.mouse.justPressed || FlxG.mouse.justMoved) {
      usingGamepad = false;
    }
    #end

    #if FLX_KEYBOARD
    if (FlxG.keys.justPressed.ANY) {
      usingGamepad = false;
    }
    #end

    #if FLX_GAMEPAD
    var push = readStickPush();
    if (push > 0) {
      updateAim(push);
    }
    if (FlxG.gamepads.anyButton(JUST_PRESSED) || push > 0) {
      usingGamepad = true;
    }
    #end

    #if FLX_MOUSE
    // Gamepad players aim with the crosshair, not the cursor
    FlxG.mouse.visible = !usingGamepad;
    #end
  }

  public static function pressed(keys:Array<FlxKey>, buttons:Array<FlxGamepadInputID>):Bool {
    #if FLX_KEYBOARD
    if (FlxG.keys.anyPressed(keys)) {
      return true;
    }
    #end

    #if FLX_GAMEPAD
    for (button in buttons) {
      if (FlxG.gamepads.anyPressed(button)) {
        return true;
      }
    }
    #end

    return false;
  }

  public static function justPressed(keys:Array<FlxKey>, buttons:Array<FlxGamepadInputID>):Bool {
    #if FLX_KEYBOARD
    if (FlxG.keys.anyJustPressed(keys)) {
      return true;
    }
    #end

    #if FLX_GAMEPAD
    for (button in buttons) {
      if (FlxG.gamepads.anyJustPressed(button)) {
        return true;
      }
    }
    #end

    return false;
  }

  // Movement
  public static function left():Bool {
    return pressed([A], [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT]);
  }

  public static function right():Bool {
    return pressed([D], [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT]);
  }

  public static function up():Bool {
    return pressed([W], [DPAD_UP, LEFT_STICK_DIGITAL_UP]);
  }

  public static function down():Bool {
    return pressed([S], [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN]);
  }

  // Jump, held
  public static function jump():Bool {
    return pressed([SPACE], [A, LEFT_TRIGGER]);
  }

  // Back to menu
  public static function menu():Bool {
    return pressed([ESCAPE], [START]);
  }

  // Kill urself
  public static function suicide():Bool {
    return pressed([K], [BACK]);
  }

  // Start charging the bow
  public static function fireJustPressed():Bool {
    #if FLX_MOUSE
    if (FlxG.mouse.justPressed) {
      return true;
    }
    #end
    return justPressed([], [RIGHT_TRIGGER]);
  }

  // Let the arrow go
  public static function fireJustReleased():Bool {
    #if FLX_MOUSE
    if (FlxG.mouse.justReleased) {
      return true;
    }
    #end

    #if FLX_GAMEPAD
    if (FlxG.gamepads.anyJustReleased(RIGHT_TRIGGER)) {
      return true;
    }
    #end

    return false;
  }

  // Ease aim toward the stick, a light push turns slowly for fine aim, a full push turns fast
  private static function updateAim(push:Float) {
    // Start from the stick when first aiming, or when coming back from the mouse
    if (aimAngle == null || !usingGamepad) {
      aimAngle = stickAngle;
      return;
    }

    var rate = AIM_TURN_RATE_MIN + (AIM_TURN_RATE_MAX - AIM_TURN_RATE_MIN) * push;
    var amount = 1 - Math.exp(-rate * FlxG.elapsed);

    // Turn the short way round
    var difference = ((stickAngle - aimAngle) % 360 + 540) % 360 - 180;
    aimAngle = aimAngle + difference * amount;
  }

  // Right stick push from 0 to 1, scaled between the deadzones. 0 when at rest or springing back.
  private static function readStickPush():Float {
    #if FLX_GAMEPAD
    var gamepad = FlxG.gamepads.lastActive;
    if (gamepad == null) {
      return 0;
    }

    // The default per axis deadzone zeroes small x or y values, snapping aim flat near each axis
    gamepad.deadZoneMode = CIRCULAR;

    var stick = gamepad.getAnalogAxes(RIGHT_ANALOG_STICK);
    var length = stick.length;
    stickAngle = stick.degrees;
    stick.put();

    // Letting go springs the stick through the centre and past it, keep the aim while it settles
    aimHeldFor = Math.max(aimHeldFor - FlxG.elapsed, 0);
    if (length < lastAimLength - AIM_RELEASE_DROP) {
      aimHeldFor = AIM_RELEASE_HOLD;
    }
    lastAimLength = length;

    if (length <= AIM_DEADZONE || aimHeldFor > 0) {
      return 0;
    }
    return Math.min((length - AIM_DEADZONE) / (AIM_OUTER_DEADZONE - AIM_DEADZONE), 1);
    #else
    return 0;
    #end
  }
}
