package;

/**
 * ALLAN AND SULLY!
 * The Menu
 * 5/28/2015
 */
import allanly.Tools;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.ui.FlxButton;

class MenuState extends FlxState {
	// Arrows
	private var emitter:FlxEmitter;

	public function new() {
		super();
	}

	// Init game
	override public function create() {
		FlxG.mouse.visible = true;

		// Emitter
		emitter = new FlxEmitter(10, 10);
		for (i in 0...100) {
			var particle = new FlxParticle();
			particle.loadGraphic(AssetPaths.arrow__png);
			particle.exists = false;
			emitter.add(particle);
		}

		add(emitter);

		emitter.start(false, 0.1);

		add(new FlxSprite(0, 0, AssetPaths.menu__png));

		add(new FlxButton(280, 380, "Start Game", this.startGame));
		add(new FlxButton(280, 420, "Instructions", this.showHelp));

		if (FlxG.sound.music == null) {
			FlxG.sound.playMusic(AssetPaths.menu__mp3, 1, true);
		}
		else if (!FlxG.sound.music.playing) {
			FlxG.sound.music.play();
		}
	}

	// Update
	public override function update(elapsed:Float) {
		super.update(elapsed);

		emitter.x = Tools.myRandom(0, FlxG.width);
		emitter.y = Tools.myRandom(0, FlxG.height);
	}

	// Start
	private function startGame() {
		FlxG.mouse.visible = false;
		FlxG.switchState(new LevelSelect());
	}

	// Help
	private function showHelp() {
		FlxG.switchState(new HelpState());
	}
}
