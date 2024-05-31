class_name PlayerSounds;
extends Node3D;

var _standard_land = preload("res://Assets/Audio/Land/Land.wav");
var _water_land = preload("res://Assets/Audio/Land/LandWater.wav");

var _standard_footstep1 = preload("res://Assets/Audio/Footsteps/Standard/Footstep1.wav");
var _standard_footstep2 = preload("res://Assets/Audio/Footsteps/Standard/Footstep2.wav");
var _standard_footstep5 = preload("res://Assets/Audio/Footsteps/Standard/Footstep3.wav");
var _standard_footstep_sounds = [_standard_footstep1, _standard_footstep2, _standard_footstep5];

var _water_footstep1 = preload("res://Assets/Audio/Footsteps/Water/WaterFootstep1.wav");
var _water_footstep2 = preload("res://Assets/Audio/Footsteps/Water/WaterFootstep2.wav");
var _water_footstep5 = preload("res://Assets/Audio/Footsteps/Water/WaterFootstep3.wav");
var _water_footstep_sounds = [_water_footstep1, _water_footstep2, _water_footstep5];

var _sand_footstep1 = preload("res://Assets/Audio/Footsteps/Sand/SandFootstep1.wav");
var _sand_footstep2 = preload("res://Assets/Audio/Footsteps/Sand/SandFootstep2.wav");
var _sand_footstep5 = preload("res://Assets/Audio/Footsteps/Sand/SandFootstep3.wav");
var _sand_footstep_sounds = [_sand_footstep1, _sand_footstep2, _sand_footstep5];

var _pickaxe_audio_player: AudioStreamPlayer;
var _walking_audio_player: AudioStreamPlayer;
var _jump_and_land_audio_player: AudioStreamPlayer;
var _walk_surface_detection: Area3D;

func _init(pickaxe_audio_player: AudioStreamPlayer, walking_audio_player: AudioStreamPlayer, jump_and_land_audio_player: AudioStreamPlayer, walk_surface_detection: Area3D):
	_pickaxe_audio_player = pickaxe_audio_player;
	_walking_audio_player = walking_audio_player;
	_jump_and_land_audio_player = jump_and_land_audio_player;
	_walk_surface_detection = walk_surface_detection;


func handle_step():
	var walk_surface_type = _get_walk_surface_type();
	
	if (walk_surface_type == 'Water'):
		_play_water_footstep_sound();
	elif (walk_surface_type == 'Sand'):
		_play_sand_footstep_sound();
	else:
		_play_standard_footstep_sound();


## Plays the pickaxe swing sound.
func play_pickaxe_swing_sound():
	_pickaxe_audio_player.play();


## Plays sound for when the player lands after being airborn.
func play_land_sound(force: float):
	_jump_and_land_audio_player.volume_db = linear_to_db(force)

	var walk_surface_type = _get_walk_surface_type();
	
	if (walk_surface_type == 'Water'):
		_play_water_land_sound();
	elif (walk_surface_type == 'Sand'):
		_play_sand_footstep_sound();
	else:
		_play_standard_land_sound();


## Plays a random standard footstep sound.
func _play_standard_footstep_sound():
	Helpers.playRandomSoundFromArray(_standard_footstep_sounds, _walking_audio_player, true);


## Plays a random water footstep sound.
func _play_water_footstep_sound():
	Helpers.playRandomSoundFromArray(_water_footstep_sounds, _walking_audio_player, true);


## Plays a random sand footstep sound.
func _play_sand_footstep_sound():
	Helpers.playRandomSoundFromArray(_sand_footstep_sounds, _walking_audio_player, true);


## Plays the standard land sound.
func _play_standard_land_sound():
	_jump_and_land_audio_player.pitch_scale = randf_range(0.8, 1.2);
	_jump_and_land_audio_player.stream = _standard_land;
	_jump_and_land_audio_player.play();


## Plays the water land sound.
func _play_water_land_sound():
	_jump_and_land_audio_player.stream = _water_land;
	_jump_and_land_audio_player.play();


## Plays a string representing the material type that the player is currently on.
func _get_walk_surface_type():
	var colliders = _walk_surface_detection.get_overlapping_bodies();

	# Get a list of all the groups that the colliders are in.
	var collider_groups = [];
	for collider in colliders:
		collider_groups.append_array(collider.get_groups());
	
	if (collider_groups.has('Water')):
		return 'Water'
	elif (collider_groups.has('Sand')):
		return 'Sand'
	else:
		return 'Standard'