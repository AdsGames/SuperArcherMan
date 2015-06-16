package
{
    import org.flixel.*;
 
    public class LevelSelect extends FlxState {
		[Embed(source = "../assets/images/level.png")] private var picLevelSelect:Class;
		
        private var backButton:FlxButton;
		
		private var backgroundImage:FlxSprite;
		
		private var level1Button:FlxButton;
		private var level2Button:FlxButton;
		private var level3Button:FlxButton;
		
        public function LevelSelect() {
        }
 
		// Init game
        override public function create():void {
            FlxG.mouse.show();
			
			backgroundImage = new FlxSprite( 0, 0, picLevelSelect);
			add(backgroundImage);
			
			level1Button = new FlxButton(175, 245, "Enter", launchLevel1);
			level2Button = new FlxButton(400, 245, "Enter", launchLevel2);
			level3Button = new FlxButton(285, 450, "Enter", launchLevel3);
			backButton = new FlxButton(550, 450, "Back", backMenu);
			
			add(level1Button);
			add(level2Button);
			add(level3Button);
            add(backButton);
        }
 
		// Back
        private function backMenu():void {
            FlxG.switchState(new MenuState);
        }
		
		// 1
        private function launchLevel1():void {
			PlayState.levelOn = 1;
            FlxG.switchState(new PlayState);
        }
		
		// 2
        private function launchLevel2():void {
			PlayState.levelOn = 2;
            FlxG.switchState(new PlayState);
        }
		
		// 3
        private function launchLevel3():void {
			PlayState.levelOn = 3;
            FlxG.switchState(new PlayState);
        }
    }
}