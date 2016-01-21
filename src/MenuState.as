package
{
    import org.flixel.*;
	import allanly.tools;
 
    public class MenuState extends FlxState {
        
		// Buttons
		private var startButton:FlxButton;
		private var helpButton:FlxButton;
		
		// Arrows
		private var emitter:FlxEmitter;
		private var particles:int = 5;
		[Embed(source = "../assets/images/arrow.png")] private var arrowImage:Class;
		
		
		// Title image
		[Embed(source = "../assets/images/menu.png")] private var menuImage:Class;
		private var title:FlxSprite;
		
		// Music
		[Embed(source="../assets/sounds/menu.mp3")] public var mainMusic:Class;
 
        public function MenuState() {
        }
 
		// Init game
        override public function create():void {
            FlxG.mouse.show();
			
			// Emitter
			emitter = new FlxEmitter(10, 10);
			for(var i:int = 0; i < 100; i++){
				var particle:FlxParticle = new FlxParticle();
				particle.loadGraphic(arrowImage);
				particle.exists = false;
				emitter.add(particle);
			}
			add(emitter);
			emitter.start( false, 5);
			
			title = new FlxSprite( 0, 0, menuImage);
			add(title);

            startButton = new FlxButton(280, 380, "Start Game", startGame);
			helpButton = new FlxButton(280, 420, "Instructions", showHelp);
			
            add(startButton);
			add(helpButton);
			
			FlxG.playMusic( mainMusic, 1.0);
        }
		
		// Update
		public override function update():void {
			super.update();
			
			emitter.x = tools.myRandom( 0, 640);
			emitter.y = tools.myRandom( 0, 480);
		}
 
		// Start
        private function startGame():void {
            FlxG.mouse.hide();
            FlxG.switchState(new LevelSelect);
        }
		
		// Help
		private function showHelp():void {
			FlxG.switchState(new HelpState);
		}
    }
}