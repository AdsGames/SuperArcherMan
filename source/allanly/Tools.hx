package allanly;

/**
 * Tools
 * ALLAN AND SULLY
 * Tools for all classes
 * 14/6/2015
 */
// Libraries
import flixel.FlxG;

class Tools {
  // Distance between 2 pts
  public static function getDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float {
    var xx:Float = x2 - x1;
    var yy:Float = y2 - y1;
    return Math.sqrt(xx * xx + yy * yy);
  }

  // Random generator, min and max included
  public static function myRandom(min:Int, max:Int):Int {
    return FlxG.random.int(min, max);
  }
}
