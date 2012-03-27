package org.josht.starling.foxhole.themes
{
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import org.josht.starling.display.Image;
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.SimpleItemRenderer;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.controls.VSlider;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.text.BitmapFontTextFormat;
	import org.josht.starling.text.BitmapFont;
	import org.josht.utils.math.roundToNearest;
	
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	public class MinimalTheme extends AddedWatcher
	{
		[Embed(source="/../assets/images/minimal.png")]
		private static const ATLAS_IMAGE:Class;
		
		[Embed(source="/../assets/images/minimal.xml",mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;
		
		private static const ATLAS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE, false), XML(new ATLAS_XML()));
		
		[Embed(source="/../assets/fonts/pf_ronda_seven.fnt",mimeType="application/octet-stream")]
		private static const ATLAS_FONT_XML:Class;
		
		public function MinimalTheme(root:DisplayObject, scaleToDPI:Boolean = true)
		{
			super(root);
			this.initialize(scaleToDPI);
		}
		
		private function initialize(scaleToDPI:Boolean):void
		{
			const scale:Number = scaleToDPI ? (Capabilities.screenDPI / 326) : 1;
			const font:BitmapFont = new BitmapFont(ATLAS.getTexture("pf_ronda_seven_0"), XML(new ATLAS_FONT_XML()));
			
			//since it's a pixel font, we want a multiple of the original size,
			//which, in this case, is 8.
			const fontSize:int = Math.max(8, roundToNearest(24 * scale, 8));
			
			this.setInitializerForClass(Label, function(label:Label):void
			{
				label.textFormat = new BitmapFontTextFormat(font, fontSize, 0x666666);
				//since it's a pixel font, we don't want to smooth it.
				label.smoothing = TextureSmoothing.NONE;
			});
			
			const buttonGrid:Rectangle = new Rectangle(9, 9, 2, 2);
			
			this.setInitializerForClass(Button, function(button:Button):void
			{
				const defaultSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("button-up-skin"), buttonGrid);
				defaultSkin.width = 88 * scale;
				defaultSkin.height = 88 * scale;
				defaultSkin.textureScale = scale;
				button.defaultSkin = defaultSkin;
				
				const downSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("button-down-skin"), buttonGrid);
				downSkin.width = 88 * scale;
				downSkin.height = 88 * scale;
				downSkin.textureScale = scale;
				button.downSkin = downSkin;
				
				const defaultSelectedSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("button-selected-skin"), buttonGrid);
				defaultSelectedSkin.width = 88 * scale;
				defaultSelectedSkin.height = 88 * scale;
				defaultSelectedSkin.textureScale = scale;
				button.defaultSelectedSkin = defaultSelectedSkin;
				
				button.selectedDownSkin = downSkin;
				
				button.defaultTextFormat = new BitmapFontTextFormat(font, fontSize, 0x666666);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(font, fontSize, 0x333333);
				
				button.contentPadding = 16 * scale;
				button.gap = 12 * scale;
			});
			
			this.setInitializerForClass(Slider, function(slider:Slider):void
			{
				const thumbDefaultSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("thumb-skin"), buttonGrid);
				thumbDefaultSkin.textureScale = scale;
				slider.thumbProperties =
				{
					width: 88 * scale,
					height: 88 * scale,
					defaultSkin: thumbDefaultSkin,
					upSkin: null,
					downSkin: null,
					defaultSelectedSkin: null,
					selectedUpSkin: null,
					selectedDownSkin: null
				};
				
				const trackDefaultSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("inset-background-skin"), buttonGrid);
				trackDefaultSkin.textureScale = scale;
				slider.trackProperties = 
				{
					width: 264 * scale,
					height: 88 * scale,
					defaultSkin: trackDefaultSkin,
					downSkin: null,
					defaultSelectedSkin: null,
					selectedDownSkin: null
				};
			});
			
			this.setInitializerForClass(VSlider, function(slider:VSlider):void
			{
				slider.trackProperties.width = 88 * scale;
				slider.trackProperties.height = 264 * scale;
			});
			
			this.setInitializerForClass(ToggleSwitch, function(toggleSwitch:ToggleSwitch):void
			{
				const thumbDefaultSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("thumb-skin"), buttonGrid);
				thumbDefaultSkin.textureScale = scale;
				toggleSwitch.thumbProperties =
				{
					width: 88 * scale,
					height: 88 * scale,
					defaultSkin: thumbDefaultSkin,
					upSkin: null,
					downSkin: null,
					defaultSelectedSkin: null,
					selectedUpSkin: null,
					selectedDownSkin: null
				};
				
				const onSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("inset-background-skin"), buttonGrid);
				onSkin.textureScale = scale;
				onSkin.width = 132 * scale;
				onSkin.height = 88 * scale;
				toggleSwitch.onSkin = onSkin;
				
				const offSkin:Scale9Image = new Scale9Image(ATLAS.getTexture("inset-background-simple-skin"), buttonGrid);
				offSkin.textureScale = scale;
				offSkin.width = 132 * scale;
				offSkin.height = 88 * scale;
				toggleSwitch.offSkin = offSkin;
				
				toggleSwitch.defaultTextFormat = new BitmapFontTextFormat(font, fontSize, 0x666666);
				toggleSwitch.onTextFormat = new BitmapFontTextFormat(font, fontSize, 0x333333);
			});
			
			this.setInitializerForClass(SimpleItemRenderer, function(renderer:SimpleItemRenderer):void
			{
				const defaultSkin:Image = new Image(ATLAS.getTexture("list-item-up"));
				//no smoothing. it's a solid color and we'll be stretching it
				//quite a bit
				defaultSkin.smoothing = TextureSmoothing.NONE;
				defaultSkin.width = 88 * scale;
				defaultSkin.height = 88 * scale;
				renderer.defaultSkin = defaultSkin;
				
				const downSkin:Image = new Image(ATLAS.getTexture("list-item-down"));
				downSkin.smoothing = TextureSmoothing.NONE;
				downSkin.width = 88 * scale;
				downSkin.height = 88 * scale;
				renderer.downSkin = downSkin;
				
				const defaultSelectedSkin:Image = new Image(ATLAS.getTexture("list-item-selected"));
				defaultSelectedSkin.smoothing = TextureSmoothing.NONE;
				defaultSelectedSkin.width = 88 * scale;
				defaultSelectedSkin.height = 88 * scale;
				renderer.defaultSelectedSkin = defaultSelectedSkin;
				
				renderer.upSkin = null;
				renderer.selectedUpSkin = null;
				renderer.selectedDownSkin = null;
				
				renderer.contentPadding = 20 * scale;
				renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			});
			
			this.setInitializerForClass(PickerList, function(list:PickerList):void
			{
				list.listProperties =
				{
					clipContent: true
				}
				
				const defaultIcon:Image = new Image(ATLAS.getTexture("drop-down-arrow"));
				defaultIcon.scaleX = defaultIcon.scaleY = scale;
				list.buttonProperties =
				{
					width: 176 * scale,
					gap: Number.POSITIVE_INFINITY, //fill as completely as possible
					horizontalAlign: Button.HORIZONTAL_ALIGN_LEFT,
					iconPosition: Button.ICON_POSITION_RIGHT,
					defaultIcon: defaultIcon
				};
			});
		}
	}
}