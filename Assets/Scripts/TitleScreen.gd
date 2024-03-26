extends Control;

@export var first_level_scene_path: String = 'res://Assets/Scenes/TitleScreen.tscn';

@onready var _main_menu: Control = $MarginContainer/MainMenu;
@onready var _settings_menu: Control = $MarginContainer/SettingsMenu;


func _ready():
    _setup_signals();


## Sets up all signals for the main menu.
func _setup_signals() -> void:
    _main_menu.start_game_btn.pressed.connect(self._start_game);
    _main_menu.settings_btn.pressed.connect(self._show_settings_menu);
    _main_menu.quit_game_btn.pressed.connect(self._exit_game);
    _settings_menu.cancel_btn.pressed.connect(self._show_main_menu);
    _settings_menu.apply_btn.pressed.connect(self._show_main_menu);


## Switches the title screen to show the settings menu.
func _show_settings_menu() -> void:
    _main_menu.visible = false;
    _settings_menu.visible = true;


## Switches the title screen to show the main menu.
func _show_main_menu() -> void:
    _main_menu.visible = true;
    _settings_menu.visible = false;


## Starts the game.
func _start_game():
    get_tree().change_scene_to_file(first_level_scene_path);


## Exits the game.
func _exit_game():
    get_tree().quit();
