package;

import allanly.Button;
import allanly.Controls;
import allanly.MenuNav;
import allanly.PixelText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;

class HelpState extends FlxState {
  // Gamepad controls, drawn over the keyboard controls in the help image
  private var gamepadHelp:FlxSpriteGroup;

  // Create help state
  override public function create() {
    FlxG.mouse.visible = true;
    add(new FlxSprite(0, 0, AssetPaths.help__png));
    var backButton = new Button(105, 15, "Back", backMenu);
    add(backButton);

    createGamepadHelp();

    // Keyboard and gamepad
    add(new MenuNav([backButton], backMenu));
  }

  // Panel covering the "Controls" box
  private function createGamepadHelp() {
    gamepadHelp = new FlxSpriteGroup(414, 170);
    gamepadHelp.add(new FlxSprite(0, 0).makeGraphic(222, 256, 0xFF6D2E00));

    var lines = [
      "Controller:",
      "",
      "Stick  Move/Climb",
      "LT / A  Jump",
      "R-Stick  Aim",
      "RT (hold)  Shoot",
      "Back  Suicide",
      "Start  Menu"
    ];
    for (i in 0...lines.length) {
      var text = PixelText.create(lines[i], 8, 8 + i * 28, 2);
      text.textColor = 0xFF000000;
      gamepadHelp.add(text);
    }

    gamepadHelp.visible = false;
    add(gamepadHelp);
  }

  // Show controls for the device in use
  override public function update(elapsed:Float) {
    super.update(elapsed);
    gamepadHelp.visible = Controls.usingGamepad;
  }

  // Start
  private function backMenu() {
    FlxG.switchState(MenuState.new);
  }
}
