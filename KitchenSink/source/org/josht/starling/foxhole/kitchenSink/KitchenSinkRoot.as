package org.josht.starling.foxhole.kitchenSink
{
	import com.gskinner.motion.easing.Cubic;
	
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	
	import org.josht.starling.display.ScreenNavigator;
	import org.josht.starling.display.ScreenNavigatorItem;
	import org.josht.starling.display.transitions.ScreenSlidingStackTransitionManager;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.kitchenSink.screens.ButtonScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ListScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.MainMenuScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.PickerListScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.SliderScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ToggleSwitchScreen;
	import org.josht.starling.foxhole.themes.MinimalTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class KitchenSinkRoot extends Sprite
	{
		private static const MAIN_MENU:String = "mainMenu";
		private static const BUTTON:String = "button";
		private static const SLIDER:String = "slider";
		private static const TOGGLE_SWITCH:String = "toggleSwitch";
		private static const LIST:String = "list";
		private static const PICKER_LIST:String = "pickerList";
		
		private static const ORIGINAL_DPI:int = Mouse.supportsCursor ? 72 : 326;
		
		public function KitchenSinkRoot()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private var _addedWatcher:AddedWatcher;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		private function addedToStageHandler(event:Event):void
		{
			const isDesktop:Boolean = Mouse.supportsCursor;
			this._addedWatcher = new MinimalTheme(this.stage, !isDesktop);
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._navigator.addScreen(MAIN_MENU, new ScreenNavigatorItem(MainMenuScreen,
			{
				onButton: BUTTON,
				onSlider: SLIDER,
				onToggleSwitch: TOGGLE_SWITCH,
				onList: LIST,
				onPickerList: PICKER_LIST
			},
			{
				originalDPI: ORIGINAL_DPI
			}));
			
			this._navigator.addScreen(BUTTON, new ScreenNavigatorItem(ButtonScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: ORIGINAL_DPI
			}));
			
			this._navigator.addScreen(SLIDER, new ScreenNavigatorItem(SliderScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: ORIGINAL_DPI
			}));
			
			this._navigator.addScreen(TOGGLE_SWITCH, new ScreenNavigatorItem(ToggleSwitchScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: ORIGINAL_DPI
			}));
			
			this._navigator.addScreen(LIST, new ScreenNavigatorItem(ListScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: ORIGINAL_DPI
			}));
			
			this._navigator.addScreen(PICKER_LIST, new ScreenNavigatorItem(PickerListScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: ORIGINAL_DPI
			}));
			
			this._navigator.showScreen(MAIN_MENU);
			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;
			this._transitionManager.ease = Cubic.easeOut;
			
			/*import fr.kouma.starling.utils.Stats;
			var stats:Stats = new Stats();//null, false);
			this.stage.addChild(stats);
			stats.y = this.stage.stageHeight - stats.height;*/
		}
	}
}