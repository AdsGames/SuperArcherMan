package{
	// Imports
	import allanly.*;
    import org.flixel.*;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	
	// THE GAME!
    public class PlayState extends FlxState {	
		// Level Number
		public static var levelOn:int = 0;
		
		// Tileset
		[Embed(source = "../assets/maps/level1/tilemapflat.png")] private var ImgTiles1:Class;
		[Embed(source = "../assets/maps/level2/tilemapflat.png")] private var ImgTiles2:Class;
		[Embed(source = "../assets/maps/level3/tilemapflat.png")] private var ImgTiles3:Class;
		private var ImgTiles:Class;
		
		// Maps
		[Embed(source = "../assets/maps/level1/map.tmx", mimeType = "application/octet-stream")] private static var MapTiles1:Class;
		[Embed(source = "../assets/maps/level2/map.tmx", mimeType = "application/octet-stream")] private static var MapTiles2:Class;
		[Embed(source = "../assets/maps/level3/map.tmx", mimeType = "application/octet-stream")] private static var MapTiles3:Class;
		private static var MapTiles:Class;
		
		// 4 maps
		private var map_back:FlxTilemap;
		private var map_mid:FlxTilemap;
		private var map_collide:FlxTilemap;
		private var map_fore:FlxTilemap;
		
		// Background
		public var sceneBackground:background;
		
		// Group to hold all the guys
		public var characters:FlxGroup;
		
		// Hold ladders
		public var ladders:FlxGroup;
		
		// Hold doors
		private var doors:FlxGroup;
		
		// Cranks/drawbridges
		private var gameCrank:crank;
		private var gameDrawbridge:drawbridge;
		
		// Crown
		private var gameCrown:crown;
		
		// Spawn point
		public var gameSpawn:spawn;
		
		// Mouse
		private var MouseRectangle:FlxSprite;
		
		// Player
		private var jim:player;
		
		// Our class constructor
        public function PlayState() {
			
        }
 
		// Creates some stuff
        override public function create():void {
			// Mouse
			FlxG.mouse.show();
			
			// Make jim
			jim = new player(0, 0);
			
			// Group to store players
			characters = new FlxGroup();
			
			// Ladders
			ladders = new FlxGroup();
			
			// Doors
			doors = new FlxGroup();
			
			// Background
			sceneBackground = new background( 5000);
			
			// Create location for pointer so no crashing
			gameCrank = new crank( -100, -100);
			gameCrown = new crown( -100, -100);
			gameDrawbridge = new drawbridge( -100, -100, 0, 0);
			gameSpawn = new spawn( -100, -100, 0, 0);
			
			// Tiles for level
			if ( levelOn == 1){
				ImgTiles = ImgTiles1;
				MapTiles = MapTiles1;
				FlxG.bgColor = 0xFF0094FE;
			}
			else if ( levelOn == 2){
				ImgTiles = ImgTiles2;
				MapTiles = MapTiles2;
				FlxG.bgColor = 0xFF76C4FC;
			}
			else if ( levelOn == 3){
				ImgTiles = ImgTiles3;
				MapTiles = MapTiles3;
				FlxG.bgColor = 0xFF080038;
			}
				
			// Load map :D
			map_back = new FlxTilemap();
			map_mid = new FlxTilemap();
			map_collide = new FlxTilemap();
			map_fore = new FlxTilemap();
			loadTmxFile( MapTiles);
			
			// Scroll that map
			FlxG.camera.follow( jim);
			
			// Secret mouse 
			MouseRectangle = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			
			// Debug!
			//FlxG.debug = true;
			//FlxG.visualDebug = true;
        }
		
		// HINT: THIS UPDATES
		override public function update():void {
			// Collide everybuddy
			FlxG.collide( characters, map_collide);
			FlxG.collide( jim, map_collide);
			FlxG.collide( jim.getArrows(), map_collide);
			FlxG.overlap( jim.getArrows(), doors, hit_door_arrow);
			
			// kill "friends"
			FlxG.overlap( jim.getArrows(), characters, hit_enemy);
			
			// Ladders
			jim.onLadder(FlxG.overlap( jim, ladders, jim.ladderPosition));
			
			// Door action
			FlxG.overlap( jim, doors, collide_door);
			FlxG.overlap( characters, doors, collide_door);
			
			// Run into draw bridge
			FlxG.collide( jim, gameDrawbridge);
			FlxG.collide( characters, gameDrawbridge);
			FlxG.collide( jim.getArrows(), gameDrawbridge);
			
			// Win!
			if (FlxG.overlap( jim, gameSpawn) && gameCrown.isTaken() ) {
				jim.win();
			}
			
			// The drawbridge + crank
			if (FlxG.overlap( gameCrank, jim.getArrows()) && !gameCrank.getActivated()) {
				gameDrawbridge.fall();
				gameCrank.spin();
			}
			
			// Crown
			if (FlxG.overlap( gameCrown, jim)) {
				gameCrown.takeCrown();
			}
			
			// Zoom
			/*if ( FlxG.keys.E) {
				MouseRectangle.x += getSign(FlxG.mouse.x - 640);
				MouseRectangle.y += getSign(FlxG.mouse.y - 480);
				
				FlxG.camera.follow( MouseRectangle);
				FlxG.camera.setBounds( jim.x - 400, jim.y - 300, 800, 600);
			}
			else {*/
				FlxG.camera.follow( jim);
				FlxG.camera.setBounds( 0, 0, map_back.widthInTiles * 16, map_back.heightInTiles * 16);
			//}
			
			// Die
			if ( FlxG.overlap( jim, characters)) {
				jim.die();
				FlxG.music.stop();
			}
			
			// Make some clouds
			if ( tools.myRandom( 0, 1000) == 1) {
				var newCloud:cloud = new cloud( -100, tools.myRandom( 0, 200));
				add(newCloud);
			}
			
			super.update();
        }
		
		// Door actions
		private function collide_door( newPlayer:character, newDoor:door):void {
			newDoor.hitDoor( newPlayer.velocity.x); 
		}
		
		// Arrows through door
		private function hit_door_arrow( newArrow:arrow, newDoor:door):void {
			// Door is closed
			if ( !newArrow.dead && (newDoor.scale.x <= 0.2 || newDoor.scale.x >= -0.2)) {
				newArrow.velocity.x /= 1.2;
				newArrow.velocity.y /= 1.2;
				newDoor.hitDoor( newArrow.velocity.x);
			}
		}
		
		// Enemy actions
		private function hit_enemy( newArrow:arrow, newEnemy:enemy):void {
			if( newArrow.velocity.x != 0 && newArrow.velocity.y != 0){
				newEnemy.getHit( newArrow.velocity.x / Math.cos( newArrow.angle));
				newArrow.velocity.x *= -0.1;
				
				if ( newEnemy.health <= 0) {
					characters.remove( newEnemy);
				}
			}
		}
		
		// Get sign
		private function getSign( newNumber:Number):Number {
			if ( newNumber < 0) {
				return -1;
			}
			else if ( newNumber > 0) {
				return 1;
			}
			return 0;
		}
		
		/********************
		 * MAP LOADING HERE *
		 ********************/
		// Load the map!
		private function loadTmxFile( TMXFile:Class):void{ 
			/*var loader:URLLoader = new URLLoader(); 
			loader.addEventListener(Event.COMPLETE, onTmxLoaded); 
			loader.load(new URLRequest("../assets/maps/level" + String(levelOn) + "/map.tmx"));*/
			
			var xml:XML = new XML(new TMXFile());
			var tmx:TmxMap = new TmxMap(xml);
			loadStateFromTmx(tmx);
		}
		
		
		// Callback for level loaded 
		private function onTmxLoaded( e:Event):void{
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);
			loadStateFromTmx(tmx);
		}
		
		// Load each layer
		private function loadStateFromTmx(tmx:TmxMap):void {
			trace( "XML loaded!");
			
			// Background
			var mapCsv:String = tmx.getLayer('back').toCsv(tmx.getTileSet('tiles'));
			map_back.loadMap(mapCsv,ImgTiles);
			map_back.follow();
			add(map_back);
			
			// Midground
			mapCsv = tmx.getLayer('mid').toCsv(tmx.getTileSet('tiles'));
			map_mid.loadMap(mapCsv,ImgTiles);
			map_mid.follow();
			add(map_mid);
			
			// Collide (collision layer)
			mapCsv = tmx.getLayer('collide').toCsv(tmx.getTileSet('tiles'));
			map_collide.loadMap(mapCsv,ImgTiles);
			map_collide.follow();
			add(map_collide);
			
			// Create the flixel implementation of the objects specified in the ObjectGroup 'objects'
			var group:TmxObjectGroup = tmx.getObjectGroup('objects');
			for each(var object:TmxObject in group.objects)
				spawnObject(object)
			
			// Foreground
			mapCsv = tmx.getLayer('front').toCsv(tmx.getTileSet('tiles'));
			map_fore.loadMap(mapCsv,ImgTiles);
			map_fore.follow();
			add(map_fore);
		}
		
		// Spawn objects using tiled object layer
		private function spawnObject(obj:TmxObject):void {
			trace( "Adding " + obj.type + " at x:" + obj.x + " y:" + obj.y + " width:" + obj.width + " height:" + obj.height);
			
			//Add game objects based on the 'type' property
			switch(obj.type)
			{
				case "player":
					jim.x = obj.x, 
					jim.y = obj.y;
					add( jim);
					jim.pickupBow();
					gameSpawn = new spawn( obj.x, obj.y, obj.width, obj.height);
					return;
				case "enemy":
					var newEnemy:enemy = new enemy( jim, obj.x, obj.y);
					characters.add( newEnemy);
					add( newEnemy);
					newEnemy.pickupSword();
					return;
				case "door":
					var newDoor:door = new door( obj.x, obj.y);
					add( newDoor);
					doors.add( newDoor);
					return;
				case "torch":
					var newTorch:torch = new torch( obj.x, obj.y);
					add( newTorch);
					return;
				case "tree":
					var newTree:tree = new tree( obj.x, obj.y);
					add( newTree);
					return;
				case "ladder":
					var newLadder:ladder = new ladder( obj.x, obj.y, obj.width, obj.height);
					ladders.add( newLadder);
					return;
				case "crown":
					gameCrown.x = obj.x;
					gameCrown.y = obj.y;
					add( gameCrown);
					return;
				case "painting":
					var newPainting:painting = new painting( obj.x, obj.y);
					add( newPainting);
					return;
				case "throne":
					var newThrone:throne = new throne( obj.x, obj.y);
					add( newThrone);
					return;
				case "drawBridge":
					gameDrawbridge = new drawbridge( obj.x, obj.y, obj.width, obj.height);
					add( gameDrawbridge);
					return;
				case "crank":
					gameCrank.x = obj.x;
					gameCrank.y = obj.y;
					add( gameCrank);
					return;
				case "water":
					var newWater:water = new water( obj.x, obj.y, obj.width, obj.height);
					return;
				default:
					return;
			}
		}
    }
}