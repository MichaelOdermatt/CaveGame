extends Control

## This script handles all internal logic for the pause menu panel.

@onready var resume_game_btn: Button = $CenterContainer/Panel/VBoxContainer/VBoxContainer/Resume;
@onready var settings_btn: Button = $CenterContainer/Panel/VBoxContainer/VBoxContainer/Settings;
@onready var title_screen_btn: Button = $CenterContainer/Panel/VBoxContainer/VBoxContainer/TitleScreen;
@onready var quit_game_btn: Button = $CenterContainer/Panel/VBoxContainer/VBoxContainer/ExitGame;