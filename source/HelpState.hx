package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class HelpState extends FlxState {
	private var backButton:FlxButton;

	// Title image
	private var help:FlxSprite;

	public function HelpState() {} // Init game

	override public function create() {
		FlxG.mouse.visible = true;

		help = new FlxSprite(0, 0, AssetPaths.help__png);
		add(help);

		backButton = new FlxButton(105, 15, "Back", backMenu);
		add(backButton);
	} // Start

	private function backMenu() {
		FlxG.switchState(new MenuState());
	}
}
