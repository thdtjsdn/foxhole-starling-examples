package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.display.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class PickerListScreen extends Screen
	{
		public function PickerListScreen()
		{
			super();
		}
		
		private var _title:Label;
		private var _backButton:Button;
		private var _list:PickerList;
		
		private var _onBack:Signal = new Signal(PickerListScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}
		
		override protected function initialize():void
		{
			this._title = new Label();
			this._title.text = "PickerList";
			this.addChild(this._title);
			
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);
			this.addChild(this._backButton);
			
			var items:Vector.<String> = new <String>[];
			for(var i:int = 0; i < 150; i++)
			{
				var label:String = "Item " + (i + 1).toString();
				items.push(label);
			}
			items.fixed = true;
			
			this._list = new PickerList();
			this._list.dataProvider = new ListCollection(items);
			this.addChildAt(this._list, 0);
			
			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function layout():void
		{
			const margin:Number = this.originalHeight * 0.04 * this.dpiScale;
			const spacingY:Number = this.originalHeight * 0.02 * this.dpiScale;
			
			this._title.validate();
			this._title.x = this.stage.stageWidth - this._title.width - margin;
			this._title.y = margin;
			
			this._backButton.x = this._backButton.y = margin;
			
			this._list.validate();
			this._list.x = (this.stage.stageWidth - this._list.width) / 2;
			this._list.y = (this.stage.stageHeight - this._list.height) / 2;
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
	}
}