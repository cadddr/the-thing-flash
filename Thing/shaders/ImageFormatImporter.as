package
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	/** 
	 * Class for uploading an image from local computer to flash player.
	 * 
	 * Usage:
	 * new ImageFormatImporter(completedFunction);
	 * 
	 * when upload is completed, this class calls completedFunction(loadedBitmapData:BitmapData)
	 *		where the parameter loadedBitmapData holds the uploaded image
	 * 
	 */ 
	public class ImageFormatImporter extends FileReference
	{
		
		public var bitmapData:BitmapData;
		
		private var 
			completedFunction:Function,
			canceledFunction:Function;
		
		
		public function ImageFormatImporter(completed:Function=null, canceled:Function=null)
		{
			super();
		
			this.completedFunction = completed;
			this.canceledFunction = canceled;
			
			this.addEventListener(Event.SELECT, fileOpenSelected);
			this.addEventListener(Event.CANCEL, fileOpenCanceled);
			this.browse([ new FileFilter("Bitmap Image Formats", "*.jpg;*.png;*.gif;*.bmp") ]);
		}
		
		private function fileOpenSelected(e:Event):void {
			this.addEventListener(Event.COMPLETE, fileOpenComplete);
			this.load();
		}
		
		private function fileOpenComplete(e:Event):void {
			var loader:flash.display.Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageReady);
			loader.loadBytes(e.target.data);
		}
		
		private function imageReady(e:Event):void {
			bitmapData = flash.display.Bitmap(e.target.content).bitmapData;
			if (this.completedFunction!=null) this.completedFunction(bitmapData);
		}
		
		
		private function fileOpenCanceled(e:Event):void {
			if (this.canceledFunction!=null) this.canceledFunction(e);
		}
		
		
	}
}