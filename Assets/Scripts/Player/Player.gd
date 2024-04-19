extends CharacterBody3D;

var _basic_movement: BasicMovement;
var _player_attack: PlayerAttack;

@onready var _camera: Camera3D = $Head/Camera3D;
@onready var _head: Node3D = $Head;
@onready var _pause_menu = get_node('../PauseMenu');
@onready var _animation_player = $Head/Camera3D/AnimationPlayer;

func _ready():
	_pause_menu.settings_updated.connect(self._update_player_variables_from_Globals);
	var setting_values = Globals.setting_values;
	_basic_movement = BasicMovement.new(
		setting_values.look_sensitivity, 
		ProjectSettings.get_setting('physics/3d/default_gravity'), 
		_head, 
		_camera, 
		self
	);
	_player_attack = PlayerAttack.new(_animation_player);
	## Capture the mouse initially.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


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
