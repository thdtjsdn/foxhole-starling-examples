package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.display.Image;
	import org.josht.starling.display.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import starling.textures.Texture;
	
	public class ButtonScreen extends Screen
	{
		[Embed(source="/../assets/images/skull.png")]
		private static const SKULL_ICON:Class;
		
		[Embed(source="/../assets/images/skull_selected.png")]
		private static const SKULL_SELECTED_ICON:Class;
		
		public function ButtonScreen()
		{
			super();
		}
		
		private var _backButton:Button;
		private var _button:Button;
		private var _title:Label;
		private var _toggleLabel:Label;
		private var _toggleToggle:ToggleSwitch;
		private var _horizontalAlignLabel:Label;
		private var _horizontalAlignPicker:PickerList;
		private var _verticalAlignLabel:Label;
		private var _verticalAlignPicker:PickerList;
		private var _iconLabel:Label;
		private var _iconToggle:ToggleSwitch;
		private var _iconPositionLabel:Label;
		private var _iconPositionPicker:PickerList;
		
		private var _icon:Image;
		private var _selectedIcon:Image;
		
		private var _onBack:Signal = new Signal(ButtonScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}
		
		override protected function initialize():void
		{
			this._icon = new Image(Texture.fromBitmap(new SKULL_ICON()));
			this._icon.scaleX = this._icon.scaleY = this.dpiScale;
			
			this._selectedIcon = new Image(Texture.fromBitmap(new SKULL_SELECTED_ICON()));
			this._selectedIcon.scaleX = this._selectedIcon.scaleY = this.dpiScale;
			
			this._title = new Label();
			this._title.text = "Button";
			this.addChild(this._title);
			
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);
			this.addChild(this._backButton);
			
			this._button = new Button();
			this._button.label = "Click Me";
			this._button.defaultIcon = this._icon;
			this._button.defaultSelectedIcon = this._selectedIcon;
			this._button.width = 264 * this.dpiScale;
			this._button.height = 264 * this.dpiScale;
			this.addChild(this._button);
			
			this._toggleLabel = new Label();
			this._toggleLabel.text = "isToggle";
			this.addChild(this._toggleLabel);
			this._toggleToggle = new ToggleSwitch();
			this._toggleToggle.isSelected = this._button.isToggle;
			this._toggleToggle.onChange.add(toggleToggle_onChange);
			this.addChild(this._toggleToggle);
			
			this._horizontalAlignLabel = new Label();
			this._horizontalAlignLabel.text = "horizontalAlign";
			this.addChild(this._horizontalAlignLabel);
			this._horizontalAlignPicker = new PickerList();
			this._horizontalAlignPicker.dataProvider = new ListCollection(new <String>
			[
				Button.HORIZONTAL_ALIGN_LEFT,
				Button.HORIZONTAL_ALIGN_CENTER,
				Button.HORIZONTAL_ALIGN_RIGHT
			]);
			this._horizontalAlignPicker.selectedItem = this._button.horizontalAlign;
			this._horizontalAlignPicker.onChange.add(horizontalAlignPicker_onChange);
			this.addChild(this._horizontalAlignPicker);
			
			this._verticalAlignLabel = new Label();
			this._verticalAlignLabel.text = "verticalAlign";
			this.addChild(this._verticalAlignLabel);
			this._verticalAlignPicker = new PickerList();
			this._verticalAlignPicker.dataProvider = new ListCollection(new <String>
			[
				Button.VERTICAL_ALIGN_TOP,
				Button.VERTICAL_ALIGN_MIDDLE,
				Button.VERTICAL_ALIGN_BOTTOM
			]);
			this._verticalAlignPicker.selectedItem = this._button.verticalAlign;
			this._verticalAlignPicker.onChange.add(verticalAlignPicker_onChange);
			this.addChild(this._verticalAlignPicker);
			
			this._iconLabel = new Label();
			this._iconLabel.text = "icon";
			this.addChild(this._iconLabel);
			this._iconToggle = new ToggleSwitch();
			this._iconToggle.isSelected = this._button.defaultIcon != null;
			this._iconToggle.onChange.add(iconToggle_onChange);
			this.addChild(this._iconToggle);
			
			this._iconPositionLabel = new Label();
			this._iconPositionLabel.text = "icon";
			this.addChild(this._iconPositionLabel);
			this._iconPositionPicker = new PickerList();
			this._iconPositionPicker.dataProvider = new ListCollection(new <String>
			[
				Button.ICON_POSITION_TOP,
				Button.ICON_POSITION_RIGHT,
				Button.ICON_POSITION_RIGHT_BASELINE,
				Button.ICON_POSITION_BOTTOM,
				Button.ICON_POSITION_LEFT,
				Button.ICON_POSITION_LEFT_BASELINE
			]);
			this._iconPositionPicker.selectedItem = this._button.iconPosition;
			this._iconPositionPicker.onChange.add(iconPositionPicker_onChange);
			this.addChild(this._iconPositionPicker);
			
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
			
			this._toggleToggle.validate();
			this._toggleToggle.x = this.stage.stageWidth - this._toggleToggle.width - margin;
			this._toggleToggle.y = this._title.y + this._title.height + spacingY;
			this._toggleLabel.validate();
			this._toggleLabel.x = this._toggleToggle.x - this._toggleLabel.width - spacingX;
			this._toggleLabel.y = this._toggleToggle.y + (this._toggleToggle.height - this._toggleLabel.height) / 2;
			
			this._horizontalAlignPicker.validate();
			this._horizontalAlignPicker.x = this.stage.stageWidth - this._horizontalAlignPicker.width - margin;
			this._horizontalAlignPicker.y = this._toggleToggle.y + this._toggleToggle.height + spacingY;
			this._horizontalAlignLabel.validate();
			this._horizontalAlignLabel.x = this._horizontalAlignPicker.x - this._horizontalAlignLabel.width - spacingX;
			this._horizontalAlignLabel.y = this._horizontalAlignPicker.y + (this._horizontalAlignPicker.height - this._horizontalAlignLabel.height) / 2;
			
			this._verticalAlignPicker.validate();
			this._verticalAlignPicker.x = this.stage.stageWidth - this._verticalAlignPicker.width - margin;
			this._verticalAlignPicker.y = this._horizontalAlignPicker.y + this._horizontalAlignPicker.height + spacingY;
			this._verticalAlignLabel.validate();
			this._verticalAlignLabel.x = this._verticalAlignPicker.x - this._verticalAlignLabel.width - spacingX;
			this._verticalAlignLabel.y = this._verticalAlignPicker.y + (this._verticalAlignPicker.height - this._verticalAlignLabel.height) / 2;
			
			this._iconToggle.validate();
			this._iconToggle.x = this.stage.stageWidth - this._iconToggle.width - margin;
			this._iconToggle.y = this._verticalAlignPicker.y + this._verticalAlignPicker.height + spacingY;
			this._iconLabel.validate();
			this._iconLabel.x = this._iconToggle.x - this._iconLabel.width - spacingX;
			this._iconLabel.y = this._iconToggle.y + (this._iconToggle.height - this._iconLabel.height) / 2;
			
			this._iconPositionPicker.validate();
			this._iconPositionPicker.x = this.stage.stageWidth - this._iconPositionPicker.width - margin;
			this._iconPositionPicker.y = this._iconToggle.y + this._iconToggle.height + spacingY;
			this._iconPositionLabel.validate();
			this._iconPositionLabel.x = this._iconPositionPicker.x - this._iconPositionLabel.width - spacingX;
			this._iconPositionLabel.y = this._iconPositionPicker.y + (this._iconPositionPicker.height - this._iconPositionLabel.height) / 2;
			
			var minX:Number = Math.min(this._toggleLabel.x, this._horizontalAlignLabel.x, this._verticalAlignLabel.x, this._iconLabel.x, this._iconPositionLabel.x) - spacingX;
			this._button.validate();
			this._button.x = (minX - this._button.width) / 2;
			this._button.y = (this.stage.stageHeight - this._button.height) / 2;
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
		
		private function toggleToggle_onChange(toggle:ToggleSwitch):void
		{
			this._button.isToggle = this._toggleToggle.isSelected;
		}
		
		private function horizontalAlignPicker_onChange(picker:PickerList):void
		{
			this._button.horizontalAlign = this._horizontalAlignPicker.selectedItem as String;
		}
		
		private function verticalAlignPicker_onChange(picker:PickerList):void
		{
			this._button.verticalAlign = this._verticalAlignPicker.selectedItem as String;
		}
		
		private function iconToggle_onChange(toggle:ToggleSwitch):void
		{
			this._button.defaultIcon = this._iconToggle.isSelected ? this._icon : null;
			this._button.defaultSelectedIcon = this._iconToggle.isSelected ? this._selectedIcon : null;
		}
		
		private function iconPositionPicker_onChange(picker:PickerList):void
		{
			this._button.iconPosition = this._iconPositionPicker.selectedItem as String;
		}
	}
}