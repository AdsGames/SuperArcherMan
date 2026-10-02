package;

import allanly.Button;
import allanly.MenuNav;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class LevelSelect extends FlxState {
  private var backButton:Button;

  private var backgroundImage:FlxSprite;

  private var level1Button:Button;
  private var level2Button:Button;
  private var level3Button:Button;

  public function new() {
    super();
  }

  // Init game
  override public function create() {
    FlxG.mouse.visible = true;

    backgroundImage = new FlxSprite(0, 0, AssetPaths.level__png);
    add(backgroundImage);

    level1Button = new Button(175, 245, "Enter", launchLevel1);
    level2Button = new Button(400, 245, "Enter", launchLevel2);
    level3Button = new Button(285, 450, "Enter", launchLevel3);
    backButton = new Button(550, 450, "Back", backMenu);

    add(level1Button);
    add(level2Button);
    add(level3Button);
    add(backButton);

    // Keyboard and gamepad
    add(new MenuNav([level1Button, level2Button, level3Button, backButton], backMenu));
  }

  // Back
  private function backMenu() {
    FlxG.switchState(MenuState.new);
  }

  // 1
  private function launchLevel1() {
    FlxG.sound.music.stop();
    FlxG.switchState(() -> new PlayState(1));
  }

  // 2
  private function launchLevel2() {
    FlxG.sound.music.stop();
    FlxG.switchState(() -> new PlayState(2));
  }

  // 3
  private function launchLevel3() {
    FlxG.sound.music.stop();
    FlxG.switchState(() -> new PlayState(3));
  }
}
