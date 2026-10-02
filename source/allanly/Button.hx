package allanly;

/**
 * Button
 * Wooden pixel art button with a 1-bit pixel font label that stays sharp when the game is scaled
 */
// Libraries
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxBitmapText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

// Colours for one button state
typedef ButtonStyle = {
  var outline:FlxColor;
  var face:FlxColor;
  var light:FlxColor;
  var shadow:FlxColor;
  var text:FlxColor;
}

class Button extends FlxTypedButton<FlxBitmapText> {
  // Size of each frame
  private static inline final WIDTH:Int = 80;
  private static inline final HEIGHT:Int = 20;

  // Cache key for the drawn frames
  private static inline final GRAPHIC_KEY:String = "allanly.Button";

  // One style per FlxButtonState: normal, highlight, pressed, disabled
  private static final STYLES:Array<ButtonStyle> = [
    {
      outline: 0xFF1B0C03,
      face: 0xFF7A3A10,
      light: 0xFFA85A22,
      shadow: 0xFF4A2006,
      text: 0xFFF3E2C0
    },
    {
      outline: 0xFFFFCC33,
      face: 0xFFB0561A,
      light: 0xFFE08A40,
      shadow: 0xFF6A300C,
      text: 0xFFFFFFFF
    },
    {
      outline: 0xFFFFCC33,
      face: 0xFF5A2808,
      light: 0xFF3A1804,
      shadow: 0xFF8A4416,
      text: 0xFFE8C890
    },
    {
      outline: 0xFF2A2A2A,
      face: 0xFF5A5A5A,
      light: 0xFF707070,
      shadow: 0xFF404040,
      text: 0xFF9A9A9A
    }
  ];

  // Selected by keyboard / gamepad navigation, shows as highlighted
  public var focused:Bool = false;

  // Create
  public function new(x:Float, y:Float, text:String, ?onClick:Void->Void) {
    // Construct parent
    super(x, y, onClick);
    loadGraphic(getGraphic(), true, WIDTH, HEIGHT);

    // State shows through the colours, so keep the label solid
    labelAlphas = [1, 1, 1, 1];

    // The browser antialiases FlxText, which scaling makes jagged. A bitmap font does not.
    var newLabel = PixelText.create(text);
    newLabel.autoSize = false;
    newLabel.fieldWidth = Std.int(width);
    newLabel.alignment = CENTER;

    // Center label vertically on the button face (+1 as the face sits below the top border)
    var offsetY = Math.floor((height - newLabel.height) / 2) + 1;
    for (point in labelOffsets) {
      point.set(point.x, point.y + offsetY);
    }

    label = newLabel;
    updateLabelColor();
  }

  // Keep focus highlight when the mouse is not over the button
  override function updateButton() {
    if (focused && status == HIGHLIGHT && !checkMouseOverlap()) {
      return;
    }

    super.updateButton();

    if (focused && status == NORMAL) {
      status = HIGHLIGHT;
    }
  }

  // Activate as if clicked
  public function press() {
    onUp.fire();
  }

  // Label colour follows the button state
  override function set_status(value:FlxButtonState):FlxButtonState {
    super.set_status(value);
    updateLabelColor();
    return status;
  }

  private function updateLabelColor() {
    if (label != null) {
      // Text color needs full alpha, 0x333333 is invisible
      label.textColor = STYLES[status.toInt()].text;
    }
  }

  // Frames for every state, drawn once and shared by all buttons
  private static function getGraphic():FlxGraphic {
    var graphic = FlxG.bitmap.get(GRAPHIC_KEY);
    if (graphic != null) {
      return graphic;
    }

    var bitmap = new BitmapData(WIDTH, HEIGHT * STYLES.length, true, FlxColor.TRANSPARENT);
    for (i in 0...STYLES.length) {
      paintFrame(bitmap, i * HEIGHT, STYLES[i]);
    }

    graphic = FlxG.bitmap.add(bitmap, false, GRAPHIC_KEY);
    graphic.persist = true;
    return graphic;
  }

  // Outline with cut corners, bevelled face
  private static function paintFrame(bitmap:BitmapData, top:Int, style:ButtonStyle) {
    var rect = new Rectangle();
    inline function fill(x:Int, y:Int, w:Int, h:Int, color:FlxColor) {
      rect.setTo(x, top + y, w, h);
      bitmap.fillRect(rect, color);
    }

    // Outline, corners left out so the button looks rounded
    fill(1, 0, WIDTH - 2, HEIGHT, style.outline);
    fill(0, 1, WIDTH, HEIGHT - 2, style.outline);

    // Face
    fill(1, 1, WIDTH - 2, HEIGHT - 2, style.face);

    // Bevel, light on top and left, shadow on bottom and right
    fill(1, 1, WIDTH - 2, 1, style.light);
    fill(1, 1, 1, HEIGHT - 2, style.light);
    fill(1, HEIGHT - 2, WIDTH - 2, 1, style.shadow);
    fill(WIDTH - 2, 1, 1, HEIGHT - 2, style.shadow);
  }
}
