package shaders {
	import flash.display.MovieClip;
	import flash.display.Shader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.ShaderJob;
	import flash.display.ShaderParameter; 
	// import ImageFormatImporter;


	public class GlitchEffect extends MovieClip {
		private var canvas:Sprite;
        private var shader:Shader;
        private var loader:URLLoader;

        private var topMiddle:Point;
        private var bottomLeft:Point;
        private var bottomRight:Point;
		
		private var time = 0.0;

		//[Embed(source = 'chessboard.jpg')]
		//protected var Picture1:Class;
		
		private var padding:int=25;
		
		//protected var tiling:CircularDisksFilter = new CircularDisksFilter(null,null);

		//[Embed(source='CircularDisks.pbj', mimeType = 'application/octet-stream')]
		//protected var DisksShader:Class; */
		
		/**	shader */
		//protected var shader:Shader= new Shader(new DisksShader());
		
		/** source image */ 
		protected var input:BitmapData; 
			
		/**	destination image */ 
		public var	output:BitmapData; 

		public function GlitchEffect() {
			canvas = new Sprite();
            addChild(canvas);

            var size:int = 400;
            topMiddle = new Point(size / 2, 10);
            bottomLeft = new Point(0, size - 10);
            bottomRight = new Point(size, size - 10);
			
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(Event.COMPLETE, onLoadComplete);
            loader.load(new URLRequest("shaders/GlitchEffect.pbj"))
		}

		private function onLoadComplete(event:Event):void
        {
            shader = new Shader(loader.data);
			
			//shader.data.size.value = [width];
			//shader.data.base.value = [ 0.33+width/2, 0.33+height/2]; 
			//shader.data.output = output;

            /*shader.data.point1.value = [topMiddle.x, topMiddle.y];
            shader.data.point2.value = [bottomLeft.x, bottomLeft.y];
            shader.data.point3.value = [bottomRight.x, bottomRight.y];*/
        }
		
		public function initSource(source:*):void { 
			if (shader != null) {
				trace ('shader init')
				var bmd:BitmapData = new BitmapData(source.width, source.height, false, 0x00001100);
				//convert a display object (MovieClip in our example) into bitmap data
				bmd.draw(source);
				
				//	set filter input and output 
				input	= bmd; 
				//output	= new BitmapData(bmd.width, bmd.height, true, 0); 
				addEventListener(Event.ENTER_FRAME, updateShaderFill);
			}
		}

        private function updateShaderFill(event:Event):void
        {
			trace('shader update')
			shader.data.src.input = input;
			time += 1/24.;
			/*time %= 1.0;*/
			shader.data.time.value = [time];
			shader.data.shake_power.value = [10.]
			shader.data.shake_rate.value = [.5]
            /*colorAngle += .06;

            var c1:Number = 1 / 3 + 2 / 3 * Math.cos(colorAngle);
            var c2:Number = 1 / 3 + 2 / 3 * Math.cos(colorAngle + d120);
            var c3:Number = 1 / 3 + 2 / 3 * Math.cos(colorAngle - d120);

            shader.data.color1.value = [c1, c2, c3, 1.0];
            shader.data.color2.value = [c3, c1, c2, 1.0];
            shader.data.color3.value = [c2, c3, c1, 1.0];*/

            canvas.graphics.clear();
            canvas.graphics.beginShaderFill(shader);
			//canvas.graphics.drawRect(50, 50, width, height)
            canvas.graphics.moveTo(topMiddle.x, topMiddle.y);
			canvas.graphics.moveTo(0, 0);
			canvas.graphics.lineTo(0, input.height)
			canvas.graphics.lineTo(input.width, input.height)
			canvas.graphics.lineTo(input.width, 0)
			canvas.graphics.lineTo(0, 0);
            //canvas.graphics.lineTo(bottomLeft.x, bottomLeft.y);
            //canvas.graphics.lineTo(bottomRight.x, bottomLeft.y);

            canvas.graphics.endFill();
			removeEventListener(Event.ENTER_FRAME, updateShaderFill);
			parent.removeChild(this);
        }
	}
}
