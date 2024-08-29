extends CharacterBody3D;

var _camera_effects: CameraEffects;
var _basic_movement: BasicMovement;
var _player_effects: PlayerEffects;
var _player_sounds: PlayerSounds;

@onready var _camera: Camera3D = $Head/Camera3D;
@onready var _head: Node3D = $Head;
@onready var _pause_menu = get_node('../PauseMenu');
@onready var _walking_audio_player = $PlayerAudioPlayers/WalkingAudioPlayer;
@onready var _jump_and_land_audio_player = $PlayerAudioPlayers/JumpAndLandAudioPlayer;
@onready var _walk_surface_detection = $WalkSurfaceDetection;

func _ready():
	var setting_values = Globals.setting_values;
	_basic_movement = BasicMovement.new(
		setting_values.look_sensitivity,
		ProjectSettings.get_setting('physics/3d/default_gravity'),
		_head,
		_camera,
		self
	);
	_camera_effects = CameraEffects.new(_camera);
	_player_effects = PlayerEffects.new(self, _walk_surface_detection);
	_player_sounds = PlayerSounds.new(_walking_audio_player, _jump_and_land_audio_player, _walk_surface_detection);
	# We want to setup a signal on BasicMovement.step, so setup signals after 
	# seting up player dependencies.
	_setup_signals();
	# Capture the mouse initially.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


## Shakes the player's camera.
func shake_camera(shake_time, shake_magnitude) -> void:
	_camera_effects.shake(shake_time, shake_magnitude);


func _setup_signals() -> void:
	_pause_menu.settings_updated.connect(self._update_player_variables_from_Globals);
	_basic_movement.step.connect(_player_sounds.handle_step);
	_basic_movement.step.connect(_player_effects.create_walk_surface_effect);
	_basic_movement.land.connect(_player_sounds.play_land_sound);


func _unhandled_input(event) -> void:
	# We want to capture the mouse if the player has clicked inside the game window.
	if (event is InputEventMouseButton &&
		event.button_index == MOUSE_BUTTON_LEFT &&
		Input.mouse_mode != Input.MOUSE_MODE_CAPTURED
	):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	# We want to release the mouse and open the pause menu if the player has pressed escape.
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		_pause_menu.show_menu();

	# Update player camera movement.
	_basic_movement.handle_player_mouse_motion(event);


func _physics_process(delta) -> void:
	# Update player movement.
	_basic_movement.handle_player_movement(delta);


## Updates any player variables from the global values.
func _update_player_variables_from_Globals() -> void:
	_basic_movement.set_look_sensitivity(Globals.setting_values.look_sensitivity);
	_basic_movement.set_fov(Globals.setting_values.fov);
