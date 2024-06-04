extends CharacterBody3D;

var _camera_effects: CameraEffects;
var _basic_movement: BasicMovement;
var _player_attack: PlayerAttack;
var _player_effects: PlayerEffects;
var _player_sounds: PlayerSounds;
var has_pickaxe: bool = false;

@onready var _camera: Camera3D = $Head/Camera3D;
@onready var _pickaxe_camera: Camera3D = $Head/Camera3D/SubViewportContainer/SubViewport/PickaxeCamera;
@onready var _head: Node3D = $Head;
@onready var _pause_menu = get_node('../PauseMenu');
@onready var _animation_tree = $AnimationTree;
@onready var _pickaxe_model = $Head/Camera3D/Pickaxe;
@onready var _pickaxe_area3D = $Head/Camera3D/PickaxeArea;
@onready var _floating_pickaxe_area3D = get_node('../FloatingPickaxe/Area3D');
@onready var _walking_audio_player = $PlayerAudioPlayers/WalkingAudioPlayer;
@onready var _pickaxe_audio_player = $PlayerAudioPlayers/PickaxeAudioPlayer;
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
	_player_attack = PlayerAttack.new(_animation_tree, _pickaxe_model, _pickaxe_area3D);
	_camera_effects = CameraEffects.new(_camera);
	_player_effects = PlayerEffects.new(self, _walk_surface_detection);
	_player_sounds = PlayerSounds.new(_pickaxe_audio_player, _walking_audio_player, _jump_and_land_audio_player, _walk_surface_detection);
	# We want to setup a signal on BasicMovement.step, so setup signals after 
	# seting up player dependencies.
	_setup_signals();
	# Capture the mouse initially.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


## Shakes the player's camera.
func shake_camera(shake_time, shake_magnitude):
	_camera_effects.shake(shake_time, shake_magnitude);


## Plays the pickaxe swing sound. Called by animation player.
func play_pickaxe_swing_sound():
	if (has_pickaxe):
		_player_sounds.play_pickaxe_swing_sound();


func _setup_signals():
	_pause_menu.settings_updated.connect(self._update_player_variables_from_Globals);
	_floating_pickaxe_area3D.body_entered.connect(self._collided_with_floating_pickaxe);
	_basic_movement.step.connect(_player_sounds.handle_step);
	_basic_movement.step.connect(_player_effects.create_walk_surface_effect);
	_basic_movement.land.connect(_player_sounds.play_land_sound);


func _process(delta):
	# Keep the pickaxe camera and main camera's global transform synced.
	_pickaxe_camera.global_transform = _camera.global_transform;


func _unhandled_input(event):
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
	elif event.is_action_pressed("attack"):
		_player_attack.player_attack();

	## Update player camera movement.
	_basic_movement.handle_player_mouse_motion(event);


func _physics_process(delta):
	## Update player movement.
	_basic_movement.handle_player_movement(delta);


## Updates any player variables from the global values.
func _update_player_variables_from_Globals() -> void:
	_basic_movement.set_look_sensitivity(Globals.setting_values.look_sensitivity);
	_basic_movement.set_fov(Globals.setting_values.fov);


## Runs when the player collides with the floating pickaxe.
func _collided_with_floating_pickaxe(body: Node3D):
	_player_attack.equip_pickaxe();
	has_pickaxe = true;
