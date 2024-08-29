class_name BasicMovement

signal step();
## Signal for when the player lands after being airborn. The force
## parameter represents the force with which the player hit the ground.
signal land(force);

var WALK_SPEED = 4.5;
var SPRINT_SPEED = 6.0;
var JUMP_VELOCITY = 4.5;
var MIN_LOOK_ANGLE = -75;
var MAX_LOOK_ANGLE = 75;
var GROUND_ACCELERATION = 9.0;
var AIR_ACCELERATION = 2.0;

# Step consts
var STEP_FREQ = 2.4;
var STEP_THRESHOLD = 0.1;

var _look_sensitivity;
var _gravity;
var _head;
var _camera;
var _character;

var _previous_frame_velocity_y: float;
## Variable used to emit the 'land' signal when the player first hits the ground after being airborn.
var _on_ground: bool = false;

# Step variables
var _step_pos: float;
var _just_stepped: bool = false;

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

	# Emit the land signal on the first frame the player hits the ground.
	if _character.is_on_floor() && !_on_ground:
		_on_ground = true;
		# Reset the step pos to zero. This prevents a step even firing immediately after you land. 
		_step_pos = 0;
		emit_signal('land', _calc_land_force());

	# Add the gravity.
	if not _character.is_on_floor():
		_character.velocity.y -= _gravity * delta;
		_on_ground = false;

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and _character.is_on_floor():
		_character.velocity.y = JUMP_VELOCITY;

	# Get the input direction and handle the movement/deceleration.
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
	var direction = (_head.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	_character.velocity.x = lerp(_character.velocity.x, direction.x * speed, delta * acceleration);
	_character.velocity.z = lerp(_character.velocity.z, direction.z * speed, delta * acceleration);

	# Update the step value as a function of player speed.
	_step_pos += delta * _character.velocity.length() * float(_character.is_on_floor());
	_update_step(_step_pos);

	# Update the previous frame's y velocity. This is used to calculate the force for the land signal.
	_previous_frame_velocity_y = _character.velocity.y;

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


## Handles emitting the step signal.
func _update_step(time: float) -> void:
	var pos = sin(time * STEP_FREQ);

	if (pos < STEP_THRESHOLD && !_just_stepped):
		_just_stepped = true;
		emit_signal('step');
	elif (pos > STEP_THRESHOLD && _just_stepped):
		_just_stepped = false;


## Calculates the force of the players landing. 
## Returned as a magnitude between 0 and 1.
func _calc_land_force() -> float:
	var land_force = abs(_previous_frame_velocity_y) / 12.0;
	return clamp(land_force, 0, 1);