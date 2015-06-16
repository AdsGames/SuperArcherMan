package allanly 
{
	/**
	 * Tools
	 * ALLAN AND SULLY
	 * Tools for all classes
	 * 14/6/15
	 */
	import org.flixel.FlxPoint;
	import Math;
	 
	public class tools {
		public function tools() {
			
		}
		
		// Distance between 2 pts
		static public function getDistance(P1:FlxPoint, P2:FlxPoint):Number{
			var XX:Number = P2.x - P1.x;
			var YY:Number = P2.y - P1.y;
			return Math.sqrt( XX * XX + YY * YY );
		}
		
		// Random generator
		static public function myRandom(min:Number, max:Number):Number{
			var n:Number = Math.round(min + Math.random() * (max - min));
			return n;
		}
	}
}