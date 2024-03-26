class_name BasicMovement

var WALK_SPEED = 5.0;
var SPRINT_SPEED = 8.0;
var JUMP_VELOCITY = 4.5;
var MIN_LOOK_ANGLE = -75;
var MAX_LOOK_ANGLE = 75;
var GROUND_ACCELERATION = 9.0;
var AIR_ACCELERATION = 2.0;

var _look_sensitivity;
var _gravity;
var _head;
var _camera;
var _character;


func _init(
	look_sensitivity: float, 
	gravity: float,
	head: Node3D, 
	camera: Camera3D, 
	character: CharacterBody3D
):
	_look_sensitivity = look_sensitivity;
	_gravity = gravity;
	_head = head;
	_camera = camera;
	_character = character;


## Reads inputs and updates the player's movement accordingly.
func handle_player_movement(delta: float) -> void:
	# Handle Sprinting.
	var speed: float;
	if (Input.is_action_pressed('sprint')):
		speed = SPRINT_SPEED;
	else:
		speed = WALK_SPEED;

	# Add the gravity.
	if not _character.is_on_floor():
		_character.velocity.y -= _gravity * delta;

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and _character.is_on_floor():
		_character.velocity.y = JUMP_VELOCITY;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector(
		"movement_left", 
		"movement_right", 
		"movement_forward", 
		"movement_backward"
	);

	var acceleration: float;
	if _character.is_on_floor():
		acceleration = GROUND_ACCELERATION;
	else:
		acceleration = AIR_ACCELERATION;

	# Apply an acceleration value to the players movement.
	var direction = (_head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	_character.velocity.x = lerp(_character.velocity.x, direction.x * speed, delta * acceleration);
	_character.velocity.z = lerp(_character.velocity.z, direction.z * speed, delta * acceleration);

	_character.move_and_slide();


## Updates the players / cameras rotation with the mouse movement.
func handle_player_mouse_motion(event) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			_head.rotate_y(-event.relative.x * _look_sensitivity);
			_camera.rotate_x(-event.relative.y * _look_sensitivity);
			_camera.rotation.x = clamp(
				_camera.rotation.x, 
				deg_to_rad(MIN_LOOK_ANGLE), 
				deg_to_rad(MAX_LOOK_ANGLE)
			);


## Sets the player's look sensitivity.
func set_look_sensitivity(new_look_sensitivity: float) -> void:
	_look_sensitivity = new_look_sensitivity;


## Sets the player's fov.
func set_fov(new_fov: float) -> void:
	_camera.fov = new_fov;
