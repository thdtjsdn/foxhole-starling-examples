package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.display.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class ToggleSwitchScreen extends Screen
	{
		public function ToggleSwitchScreen()
		{
			super();
		}
		
		private var _title:Label;
		private var _toggleSwitch:ToggleSwitch;
		private var _valueLabel:Label;
		private var _backButton:Button;
		
		private var _onBack:Signal = new Signal(ToggleSwitchScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}
		
		override protected function initialize():void
		{
			this._title = new Label();
			this._title.text = "ToggleSwitch";
			this.addChild(this._title);
			
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);
			this.addChild(this._backButton);
			
			this._toggleSwitch = new ToggleSwitch();
			this._toggleSwitch.isSelected = false;
			this._toggleSwitch.onChange.add(toggleSwitch_onChange);
			this.addChild(this._toggleSwitch);
			
			this._valueLabel = new Label();
			this._valueLabel.text = this._toggleSwitch.isSelected ? "1" : "0";
			this.addChild(this._valueLabel);
			
			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function layout():void
		{
			const margin:Number = this.originalHeight * 0.04 * this.dpiScale;
			const spacingX:Number = this.originalWidth * 0.02 * this.dpiScale;
			const spacingY:Number = this.originalWidth * 0.02 * this.dpiScale;
			
			this._backButton.x = this._backButton.y = margin;
			
			this._title.validate();
			this._title.x = this.stage.stageWidth - this._title.width - margin;
			this._title.y = margin;
			
			this._toggleSwitch.validate(); //auto-size the slider
			this._toggleSwitch.x = (this.stage.stageWidth - this._toggleSwitch.width) / 2;
			this._toggleSwitch.y = (this.stage.stageHeight - this._toggleSwitch.height) / 2;
			this._valueLabel.validate();
			this._valueLabel.x = this._toggleSwitch.x + this._toggleSwitch.width + spacingX;
			this._valueLabel.y = this._toggleSwitch.y + (this._toggleSwitch.height - this._valueLabel.height) / 2;
		}
		
		private function toggleSwitch_onChange(toggleSwitch:ToggleSwitch):void
		{
			this._valueLabel.text = this._toggleSwitch.isSelected ? "1" : "0";
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