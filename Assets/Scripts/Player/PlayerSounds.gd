extends Node3D;

var _footstep1 = preload("res://Assets/Audio/Footsteps/Footstep1.wav");
var _footstep2 = preload("res://Assets/Audio/Footsteps/Footstep2.wav");
var _footstep3 = preload("res://Assets/Audio/Footsteps/Footstep3.wav");
var _footstep4 = preload("res://Assets/Audio/Footsteps/Footstep4.wav");
var _footstep5 = preload("res://Assets/Audio/Footsteps/Footstep5.wav");
var _footstep_sounds = [_footstep1, _footstep2, _footstep3, _footstep4, _footstep5];

@onready var _walk_audio_player = $WalkingAudioPlayer;

# var _character: CharacterBody3D;
# var _footstep_timer: Timer;
# var _walk_sounds_playing: bool = false;

# func _init(footstep_audio_player: AudioStreamPlayer, character: CharacterBody3D):
# 	_footstep_audio_player = footstep_audio_player;
# 	_character = character;
# 	_footstep_timer = Timer.new();
# 	character.add_child(_footstep_timer);


## Starts playing the walking sounds.
# func start_walk_sounds():
# 	if (_walk_sounds_playing):
# 		return;
# 
# 	_walk_sounds_playing = true;
# 	_footstep_timer.wait_time = 0.6;
# 	_footstep_timer.timeout.connect(self._play_footstep_sound);
# 	_footstep_timer.start();
# 
# 
# ## Stops playing the walking sounds.
# func stop_walk_sounds():
# 	if (!_walk_sounds_playing):
# 		return;
# 	
# 	_walk_sounds_playing = false;
# 	_footstep_timer.timeout.disconnect(self._play_footstep_sound);
# 	_footstep_timer.stop();
# 
# 
# func handle_movement_sounds(delta: float):
# 	if _character.is_on_floor() && _character.velocity.length() >= MOVEMENT_SOUND_THRESHOLD:
# 		start_walk_sounds();
# 	else:
# 		stop_walk_sounds();


## Plays a random footstep sound.
func play_footstep_sound():
	Helpers.playRandomSoundFromArray(_footstep_sounds, _walk_audio_player, true);
