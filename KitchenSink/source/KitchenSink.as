package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import org.josht.starling.foxhole.kitchenSink.KitchenSinkRoot;
	
	import starling.core.Starling;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#f3f3f3")]
	public class KitchenSink extends Sprite
	{
		public function KitchenSink()
		{
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		private var _starling:Starling;
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			//workaround for testing on desktop until ADL stops offsetting the
			//starling stage in fullScreen mode.
			if(Capabilities.os.indexOf("Windows") >= 0 || Capabilities.os.indexOf("Mac OS") >= 0)
			{
				this.stage.displayState = StageDisplayState.NORMAL;
				this.stage.setOrientation(StageOrientation.ROTATED_LEFT);
			}
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			this._starling = new Starling(KitchenSinkRoot, this.stage);
			this._starling.start();
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, 0, true);
		}
		
		private function stage_resizeHandler(event:Event):void
		{
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			this._starling.viewPort = viewPort;
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
		}
	}
}