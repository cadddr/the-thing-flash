package events {
    
    import flash.events.Event;
    
    /**
     * Event dispatched when a thing's visibility changes
     */
    public class ThingRevealEvent extends Event {
        /**
         * Whether the thing is visible or invisible
         */
        public var visible:Boolean;
        
        /**
         * Constructor
         * @param visible Whether the thing is visible
         */
        public function ThingRevealEvent(type:String, visible:Boolean) {
            super(type);
            this.visible = visible;
        }  
    }
}