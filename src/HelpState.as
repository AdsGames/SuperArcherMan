package
{
    import org.flixel.*;
 
    public class HelpState extends FlxState {
        private var backButton:FlxButton;
 
		// Title image
		[Embed(source = "../assets/images/help.png")] private var helpImage:Class;
		private var help:FlxSprite;
		
        public function HelpState() {
        }
 
		// Init game
        override public function create():void {
            FlxG.mouse.show();
			
			help = new FlxSprite( 0, 0, helpImage);
			add( help);
			
			backButton = new FlxButton(105, 15, "Back", backMenu);
			add(backButton);
        }
 
		// Start
        private function backMenu():void {
            FlxG.switchState(new MenuState);
        }
    }
}