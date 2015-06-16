package {
	/**
	 * ALLAN AND SULLY!
	 * Creator of game state
	 * 5/28/15
	 */
    import org.flixel.FlxGame;//location of flixel library
	import org.flixel.plugin.photonstorm.*;//location of photonstorm extended classes
 
    public class FirstGame extends FlxGame{
        public function FirstGame() {
			// Create the menu state
            super(640, 480, MenuState, 1);
        }
    }
}