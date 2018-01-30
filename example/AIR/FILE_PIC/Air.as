package {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.filesystem.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.display.Loader;

	public class Air extends MovieClip {
		private var _lodListNum:int;
		private var _this = this;
		public function Air() {
			var desktop:File = File.desktopDirectory.resolvePath('HuaWeiPrint');
			desktop.createDirectory();
			getDirList(desktop);
		}

		function getDirList(ds:File):void{
			var comp =0;
			var files:Array = ds.getDirectoryListing();
			if(_lodListNum!=files.length){
				for (var i:uint = 0; i < files.length; i++) {
					var list = files[i].nativePath;
					if(list.indexOf	('.jpg')>0){
						trace(files[i].nativePath);
						var fileByte:ByteArray = new ByteArray();
						var fileStream:FileStream = new FileStream();
						//fileStream.addEventListener(Event.COMPLETE, fileCompleteHandler)
						fileStream.open(files[i], FileMode.READ);
						fileStream.readBytes( fileByte, 0, fileStream.bytesAvailable );
						fileStream.close(); 
						var loader =new Loader(); 
						loader.loadBytes(fileByte);  
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e){
							
							var _load = e.target.loader as Loader ;
							trace('load ok'+_load.width);
							var tempData:BitmapData=new BitmapData(_load.width,_load.height,false);  
							tempData.draw(loader);  
							var bitmap:Bitmap=new Bitmap(tempData); 
							var bmp = new Sprite();
							var cont = new Sprite();
							bitmap.width = 842;
							bitmap.smoothing = true;
							bitmap.scaleY = bitmap.scaleX;
							
							bmp.addChild(bitmap);
							bmp.x = -bitmap.width/2;
							bmp.y = -bitmap.height / 2;
							cont.addChild(bmp);
							//cont.alpha = 0;
							//_picAry.push(cont);
							_this.addChild(cont);
							//MovieClip(root).addChild(bitmap);

						});    
					}
				}
			}
			//lrCtor = new LRCenter(contMc,_picAry,l_bt,r_bt);
			
		}
		
		


	}

}