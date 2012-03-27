package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.display.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.HSlider;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.controls.VSlider;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class SliderScreen extends Screen
	{
		public function SliderScreen()
		{
			super();
		}
		
		private var _backButton:Button;
		private var _title:Label;
		private var _slider:Slider;
		private var _valueLabel:Label;
		private var _directionPicker:PickerList;
		private var _directionLabel:Label;
		private var _liveDraggingToggle:ToggleSwitch;
		private var _liveDraggingLabel:Label;
		private var _stepSlider:Slider;
		private var _stepLabel:Label;
		
		private var _onBack:Signal = new Signal(SliderScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}
		
		override protected function initialize():void
		{
			this._title = new Label();
			this._title.text = "Slider";
			this.addChild(this._title);
			
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);
			this.addChild(this._backButton);
			
			this._slider = new Slider();
			this._slider.minimum = 0;
			this._slider.maximum = 100;
			this._slider.step = 1;
			this._slider.value = 50;
			this._slider.onChange.add(slider_onChange);
			this.addChild(this._slider);
			
			this._directionLabel = new Label();
			this._directionLabel.text = "direction";
			this.addChild(this._directionLabel);
			this._directionPicker = new PickerList();
			this._directionPicker.dataProvider = new ListCollection(new <String>
			[
				Slider.DIRECTION_HORIZONTAL,
				Slider.DIRECTION_VERTICAL
			]);
			this._directionPicker.selectedItem = this._slider.direction;
			this._directionPicker.onChange.add(directionPicker_onChange);
			this.addChild(this._directionPicker);
			
			this._liveDraggingLabel = new Label();
			this._liveDraggingLabel.text = "liveDragging";
			this.addChild(this._liveDraggingLabel);
			this._liveDraggingToggle = new ToggleSwitch();
			this._liveDraggingToggle.isSelected = this._slider.liveDragging;
			this._liveDraggingToggle.onChange.add(liveDraggingToggle_onChange);
			this.addChild(this._liveDraggingToggle);
			
			this._stepLabel = new Label();
			this._stepLabel.text = "step";
			this.addChild(this._stepLabel);
			this._stepSlider = new Slider();
			this._stepSlider.minimum = 1;
			this._stepSlider.maximum = 20;
			this._stepSlider.step = 1;
			this._stepSlider.value = 1;
			this._stepSlider.onChange.add(stepSlider_onChange);
			this.addChild(this._stepSlider);
			
			this._valueLabel = new Label();
			this._valueLabel.text = this._slider.value.toString();
			this.addChild(this._valueLabel);
			
			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function layout():void
		{
			const margin:Number = this.originalHeight * 0.04 * this.dpiScale;
			const spacingX:Number = this.originalHeight * 0.02 * this.dpiScale;
			const spacingY:Number = this.originalHeight * 0.02 * this.dpiScale;
			
			this._backButton.x = this._backButton.y = margin;
			
			this._title.validate();
			this._title.x = this.stage.stageWidth - this._title.width - margin;
			this._title.y = margin;
			
			this._directionPicker.validate();
			this._directionPicker.x = this.stage.stageWidth - this._directionPicker.width - margin;
			this._directionPicker.y = this._title.y + this._title.height + spacingY;
			this._directionLabel.validate();
			this._directionLabel.x = this._directionPicker.x - this._directionLabel.width - spacingX;
			this._directionLabel.y = this._directionPicker.y + (this._directionPicker.height - this._directionLabel.height) / 2;
			
			this._liveDraggingToggle.validate();
			this._liveDraggingToggle.x = this.stage.stageWidth - this._liveDraggingToggle.width - margin;
			this._liveDraggingToggle.y = this._directionPicker.y + this._directionPicker.height + spacingY;
			this._liveDraggingLabel.validate();
			this._liveDraggingLabel.x = this._liveDraggingToggle.x - this._liveDraggingLabel.width - spacingX;
			this._liveDraggingLabel.y = this._liveDraggingToggle.y + (this._liveDraggingToggle.height - this._liveDraggingLabel.height) / 2;
			
			this._stepSlider.validate();
			this._stepSlider.x = this.stage.stageWidth - this._stepSlider.width - margin;
			this._stepSlider.y = this._liveDraggingToggle.y + this._liveDraggingToggle.height + spacingY;
			this._stepLabel.validate();
			this._stepLabel.x = this._stepSlider.x - this._stepLabel.width - spacingX;
			this._stepLabel.y = this._stepSlider.y + (this._stepSlider.height - this._stepLabel.height) / 2;
			
			var minX:Number = Math.min(this._directionLabel.x, this._liveDraggingLabel.x, this._stepLabel.x) - spacingX;
			this._slider.validate(); //auto-size the slider
			this._slider.x = (minX - this._slider.width) / 2;
			this._slider.y = (this.stage.stageHeight - this._slider.height) / 2;
			this._valueLabel.validate();
			this._valueLabel.x = this._slider.x + this._slider.width + spacingX;
			this._valueLabel.y = this._slider.y + (this._slider.height - this._valueLabel.height) / 2;
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function slider_onChange(slider:Slider):void
		{
			this._valueLabel.text = this._slider.value.toString();
		}
		
		private function directionPicker_onChange(list:PickerList):void
		{
			this._slider.direction = this._directionPicker.selectedItem as String;
			const temp:Number = this._slider.width;
			this._slider.width = this._slider.height;
			this._slider.height = temp;
			this.layout();
		}
		
		private function liveDraggingToggle_onChange(toggle:ToggleSwitch):void
		{
			this._slider.liveDragging = this._liveDraggingToggle.isSelected;
		}
		
		private function stepSlider_onChange(slider:Slider):void
		{
			this._slider.step = this._stepSlider.value;
		}
		
		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
	}
}