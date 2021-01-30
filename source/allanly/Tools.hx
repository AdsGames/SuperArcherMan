package allanly;

/**
 * Tools
 * ALLAN AND SULLY
 * Tools for all classes
 * 14/6/2015
 */
import Math;
import flixel.math.FlxPoint;

class Tools {
	public function new() {}

	// Distance between 2 pts
	static public function getDistance(p1:FlxPoint, p2:FlxPoint):Float {
		var XX:Float = p2.x - p1.x;
		var YY:Float = p2.y - p1.y;
		return Math.sqrt(XX * XX + YY * YY);
	}

	// Random generator
	static public function myRandom(min:Int, max:Int):Int {
		var n:Int = Math.round(min + Math.random() * (max - min));
		return n;
	}
}
