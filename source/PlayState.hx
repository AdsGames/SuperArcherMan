package;

// Imports
import allanly.Arrow;
import allanly.Background;
import allanly.Bow;
import allanly.Character;
import allanly.Cloud;
import allanly.Controls;
import allanly.Crank;
import allanly.Crown;
import allanly.Door;
import allanly.Drawbridge;
import allanly.Enemy;
import allanly.Ladder;
import allanly.Painting;
import allanly.PixelText;
import allanly.Player;
import allanly.Spawn;
import allanly.Sword;
import allanly.Throne;
import allanly.Tools;
import allanly.Torch;
import allanly.Tree;
import allanly.WinPointer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import flixel.tile.FlxTilemap;

// THE GAME!
class PlayState extends FlxState {
  // Level Number
  public static var levelOn:Int;

  // Background
  private var sceneBackground:Background;

  // Group to hold all the guys
  private var characters:FlxGroup;

  // Hold ladders
  private var ladders:FlxGroup;

  // Hold doors
  private var doors:FlxGroup;

  // Cranks/drawbridges
  private var gameCrank:Crank;
  private var gameDrawbridge:Drawbridge;

  // Crown
  private var gameCrown:Crown;

  // Spawn point
  private var gameSpawn:Spawn;

  // Win pointer
  private var winPointer:WinPointer;

  // Clouds
  private var clouds:FlxTypedGroup<Cloud>;

  // Player
  private var jim:Player;

  // Power text
  private var powerText:FlxBitmapText;

  // Aim marker along the bow's aim line, replaces the mouse cursor while the bow is out
  private var crosshair:FlxSprite;

  // How far out from the bow the crosshair sits, further out makes small angles easier to see
  private static inline final CROSSHAIR_DISTANCE:Float = 120;

  // Level
  private var levelFront:FlxTilemap;
  private var levelMid:FlxTilemap;
  private var levelBack:FlxTilemap;
  private var levelCollide:FlxTilemap;

  // Our class constructor
  public function new(levelOn:Int) {
    super();

    PlayState.levelOn = levelOn;
  }

  // Creates some stuff
  override public function create() {
    // Mouse
    FlxG.mouse.visible = true;

    // Make jim
    jim = new Player(0, 0);

    // Group to store players
    characters = new FlxGroup();

    // Ladders
    ladders = new FlxGroup();

    // Doors
    doors = new FlxGroup();

    // Background
    sceneBackground = new Background(5000);
    add(sceneBackground);

    // Create location for pointer so no crashing
    // Crank and drawbridge do not exist until the map places them, so they never collide
    gameCrank = new Crank(-100, -100);
    gameCrank.exists = false;
    gameCrown = new Crown(-100, -100);
    gameDrawbridge = new Drawbridge(-100, -100, 0, 0);
    gameDrawbridge.exists = false;
    gameSpawn = new Spawn(-100, -100, 0, 0);

    // Load map :D
    loadMap(levelOn);

    // Power text
    powerText = PixelText.create();
    add(powerText);

    // Crosshair
    crosshair = new FlxSprite(0, 0, AssetPaths.cursor__png);
    crosshair.visible = false;
    add(crosshair);

    // Win pointer
    winPointer = new WinPointer(gameSpawn, jim);
    add(winPointer);

    // Clouds
    clouds = new FlxTypedGroup<Cloud>();
    add(clouds);

    // Zoom and follow
    FlxG.camera.follow(jim, PLATFORMER, 1);

    if (FlxG.sound.music == null || !FlxG.sound.music.playing) {
      FlxG.sound.playMusic(AssetPaths.music__mp3, 0.1, true);
    }
  }

  // HINT: THIS UPDATES
  override public function update(elapsed:Float) {
    // Collide everybuddy
    FlxG.collide(characters, levelCollide);
    FlxG.collide(jim, levelCollide);
    FlxG.collide(jim.getArrows(), levelCollide);
    FlxG.overlap(jim.getArrows(), doors, hitDoorArrow);

    // kill "friends"
    FlxG.overlap(jim.getArrows(), characters, hitEnemy);

    // Ladders
    jim.onLadder(FlxG.overlap(jim, ladders, jim.ladderPosition));

    // Door action
    FlxG.overlap(jim, doors, collideDoor);
    FlxG.overlap(characters, doors, collideDoor);

    // Run into draw bridge
    FlxG.collide(jim, gameDrawbridge);
    FlxG.collide(characters, gameDrawbridge);
    FlxG.collide(jim.getArrows(), gameDrawbridge);

    // Win!
    if (FlxG.overlap(jim, gameSpawn) && gameCrown.isTaken()) {
      jim.win();
    }

    // The drawbridge + crank
    if (FlxG.overlap(gameCrank, jim.getArrows()) && !gameCrank.getActivated()) {
      gameDrawbridge.fall();
      gameCrank.spin();
    }

    // Crown
    if (FlxG.overlap(gameCrown, jim)) {
      gameCrown.takeCrown();
      winPointer.enable();
    }

    // Die
    if (FlxG.overlap(jim, characters)) {
      jim.die();
      FlxG.sound.music.stop();
    }

    // Make some clouds
    if (Tools.myRandom(0, 1000) == 1) {
      clouds.recycle(Cloud).spawn(-100, Tools.myRandom(0, 200));
    }

    // Menu
    if (Controls.menu()) {
      FlxG.switchState(MenuState.new);
      FlxG.sound.music.stop();
    }

    super.update(elapsed);

    // Crosshair at a fixed distance along the aim line, for both mouse and gamepad.
    // Placed after super.update so it uses this frame's bow angle and position.
    var bow = Std.downcast(jim.getArm(), Bow);
    crosshair.visible = bow != null && bow.active;
    if (crosshair.visible) {
      var aim = (bow.angle - 90) * Math.PI / 180;
      crosshair.x = bow.x + bow.width / 2 + Math.cos(aim) * CROSSHAIR_DISTANCE - crosshair.width / 2;
      crosshair.y = bow.y + bow.height / 2 + Math.sin(aim) * CROSSHAIR_DISTANCE - crosshair.height / 2;
    }

    // The crosshair replaces the cursor, it uses the same image
    FlxG.mouse.visible = !crosshair.visible && !Controls.usingGamepad;

    // Move power text next to the aim point
    var aimX = crosshair.visible ? crosshair.x + crosshair.width / 2 : FlxG.mouse.x;
    var aimY = crosshair.visible ? crosshair.y + crosshair.height / 2 : FlxG.mouse.y;
    powerText.x = aimX + 15;
    powerText.y = aimY;

    if (bow != null) {
      powerText.text = "" + bow.getPower() + "%";
    }
  }

  // Door actions
  private function collideDoor(player:Character, door:Door) {
    door.hitDoor(player.velocity.x);
  }

  // Arrows through door
  private function hitDoorArrow(arrow:Arrow, door:Door) {
    // Door is closed
    if (!arrow.dead && door.scale.x <= 0.2 && door.scale.x >= -0.2) {
      arrow.velocity.x /= 1.2;
      arrow.velocity.y /= 1.2;
      door.hitDoor(arrow.velocity.x);
    }
  }

  // Enemy actions
  private function hitEnemy(arrow:Arrow, enemy:Enemy) {
    if (!arrow.hasHit && arrow.velocity.x != 0 && arrow.velocity.y != 0) {
      arrow.hasHit = true;
      enemy.getHit(arrow.velocity.length);
      arrow.velocity.x *= -0.1;

      if (enemy.health <= 0) {
        characters.remove(enemy);
      }
    }
  }

  // Load each layer
  private function loadMap(levelOn:Int) {
    // trace("Loading Map!");

    levelFront = new FlxTilemap();
    levelMid = new FlxTilemap();
    levelBack = new FlxTilemap();
    levelCollide = new FlxTilemap();

    add(levelBack);
    add(levelMid);
    add(levelFront);
    add(levelCollide);

    // Tiles for level
    var spritesheet:String = "";
    var tmx:TiledMap;

    if (levelOn == 1) {
      spritesheet = AssetPaths.level1_tiles__png;
      tmx = new TiledMap(AssetPaths.level1_map__tmx);
    }
    else if (levelOn == 2) {
      spritesheet = AssetPaths.level2_tiles__png;
      tmx = new TiledMap(AssetPaths.level2_map__tmx);
    }
    else if (levelOn == 3) {
      spritesheet = AssetPaths.level3_tiles__png;
      tmx = new TiledMap(AssetPaths.level3_map__tmx);
    }
    else {
      return;
    }

    // Set background color
    bgColor = tmx.backgroundColor;

    // Parse layers
    for (layer in tmx.layers) {
      if (layer.type == TILE) {
        var tileLayer:TiledTileLayer = cast(layer, TiledTileLayer);
        if (layer.name == "collide") {
          levelCollide.loadMapFromArray(tileLayer.tileArray, tileLayer.width, tileLayer.height, spritesheet, 16, 16, OFF, 1);
          levelCollide.follow();
        }
        else if (layer.name == "front") {
          levelFront.loadMapFromArray(tileLayer.tileArray, tileLayer.width, tileLayer.height, spritesheet, 16, 16, OFF, 1);
          levelFront.follow();
        }
        else if (layer.name == "back") {
          levelBack.loadMapFromArray(tileLayer.tileArray, tileLayer.width, tileLayer.height, spritesheet, 16, 16, OFF, 1);
          levelBack.follow();
        }
        else if (layer.name == "mid") {
          levelMid.loadMapFromArray(tileLayer.tileArray, tileLayer.width, tileLayer.height, spritesheet, 16, 16, OFF, 1);
          levelMid.follow();
        }
      }
      else if (layer.type == OBJECT) {
        var objLayer:TiledObjectLayer = cast(layer, TiledObjectLayer);
        spawnObjects(objLayer);
      }
    }
  }

  // Spawn objects using tiled object layer
  private function spawnObjects(group:TiledObjectLayer) {
    // Spawn stuff
    for (obj in group.objects) {
      spawnObject(obj);
    }
  }

  private function spawnObject(obj:TiledObject) {
    // trace("Adding " + obj.type + " at x:" + obj.x + " y:" + obj.y + " width:" + obj.width + " height:" + obj.height);

    // Add game objects based on the 'type' property
    switch (obj.type) {
      case "player":
        jim.setPosition(obj.x, obj.y);
        add(jim);
        jim.pickupArm(new Bow(600.0, 1.0, 100.0));
        gameSpawn = new Spawn(obj.x, obj.y, obj.width, obj.height);
        add(gameSpawn);
        return;
      case "enemy":
        var enemy = new Enemy(jim, obj.x, obj.y);
        characters.add(enemy);
        add(enemy);
        enemy.pickupArm(new Sword());
        return;
      case "door":
        var door = new Door(obj.x, obj.y);
        add(door);
        doors.add(door);
        return;
      case "torch":
        add(new Torch(obj.x, obj.y));
        return;
      case "tree":
        add(new Tree(obj.x, obj.y));
        return;
      case "ladder":
        ladders.add(new Ladder(obj.x, obj.y, obj.width, obj.height));
        return;
      case "crown":
        gameCrown.setPosition(obj.x, obj.y);
        add(gameCrown);
        return;
      case "painting":
        add(new Painting(obj.x, obj.y));
        return;
      case "throne":
        add(new Throne(obj.x, obj.y));
        return;
      case "drawBridge":
        gameDrawbridge = new Drawbridge(obj.x, obj.y, obj.width, obj.height);
        add(gameDrawbridge);
        return;
      case "crank":
        gameCrank.setPosition(obj.x, obj.y);
        gameCrank.exists = true;
        add(gameCrank);
        return;
      case "water":
        // var water = new Water(obj.x, obj.y, obj.width, obj.height);
        return;
      default:
        return;
    }
  }
}
