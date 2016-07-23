package
{
	// Imports
    import flash.display.Sprite;
    import flash.events.Event;
 

	// Initilize game and run
    public class Main extends Sprite
    {
        public function Main():void
        {
            if (stage)
            {
                init();
            } else {
                addEventListener(Event.ADDED_TO_STAGE, init);
            }
        }
 
        private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
 
            var game:FirstGame = new FirstGame;
 
            addChild(game);
        } 
    }
}