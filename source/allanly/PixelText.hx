package allanly;

/**
 * PixelText
 * Bitmap text with flixel's built in 1-bit pixel font
 */
// Libraries
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;

class PixelText {
  // Create text, scale is whole numbers so pixels stay square
  public static function create(text:String = "", x:Float = 0, y:Float = 0, scale:Int = 1):FlxBitmapText {
    var bitmapText = new FlxBitmapText(x, y, text, FlxBitmapFont.getDefaultFont());
    bitmapText.useTextColor = true;
    bitmapText.textColor = 0xFFFFFFFF;
    bitmapText.antialiasing = false;
    bitmapText.scale.set(scale, scale);
    bitmapText.updateHitbox();
    return bitmapText;
  }
}
