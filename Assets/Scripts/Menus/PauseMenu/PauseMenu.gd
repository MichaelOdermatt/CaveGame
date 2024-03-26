extends MarginContainer

signal settings_updated();

@export var title_screen_scene_path: String = 'res://Assets/Scenes/TitleScreen.tscn';

@onready var _settings_menu = $SettingsMenu;
@onready var _pause_menu_panel = $PauseMenuPanel;

var _is_pause_menu_open: bool = false;


## Opens the pause menu.
func show_menu():
	_show_pause_menu_panel();
	_is_pause_menu_open = true;
	get_tree().paused = true;


func _ready():
	_setup_signals();


## Sets up all signals for the pause menu.
func _setup_signals() -> void:
	_pause_menu_panel.settings_btn.pressed.connect(self._show_settings_menu);
	_pause_menu_panel.quit_game_btn.pressed.connect(self._exit_game);
	_pause_menu_panel.resume_game_btn.pressed.connect(self._resume_game);
	_pause_menu_panel.title_screen_btn.pressed.connect(self._title_screen);
	_settings_menu.cancel_btn.pressed.connect(self._show_pause_menu_panel);
	_settings_menu.apply_btn.pressed.connect(self._apply_btn);


## Switches the pause menu screen to show the settings menu.
func _show_settings_menu() -> void:
	_pause_menu_panel.visible = false;
	_settings_menu.visible = true;


## Switches the pause menu screen to show the pause menu panel.
func _show_pause_menu_panel() -> void:
	_pause_menu_panel.visible = true;
	_settings_menu.visible = false;


## Switches the scene to the title screen scene.
func _title_screen() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_file(title_screen_scene_path);


## Closes the settings window and applys the settings.
func _apply_btn() -> void:
	_show_pause_menu_panel();
	settings_updated.emit();


## Switches the pause menu screen to show the main menu.
func _resume_game() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	_pause_menu_panel.visible = false;
	_settings_menu.visible = false;
	_is_pause_menu_open = false;
	get_tree().paused = false;


## Exits the game.
func _exit_game():
	get_tree().quit();
