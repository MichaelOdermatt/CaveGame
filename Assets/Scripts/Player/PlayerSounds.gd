class_name PlayerSounds;
extends Node;

var _footstep1 = preload("res://Assets/Audio/Footsteps/Footstep1.wav");
var _footstep2 = preload("res://Assets/Audio/Footsteps/Footstep2.wav");
var _footstep3 = preload("res://Assets/Audio/Footsteps/Footstep3.wav");
var _footstep4 = preload("res://Assets/Audio/Footsteps/Footstep4.wav");
var _footstep5 = preload("res://Assets/Audio/Footsteps/Footstep5.wav");

var _footstep_audio_player: AudioStreamPlayer;
var _footstep_sounds = [_footstep1, _footstep2, _footstep3, _footstep4, _footstep5];

func _init(footstep_audio_player: AudioStreamPlayer):
    _footstep_audio_player = footstep_audio_player;


## Starts playing the players walking sounds.
func play_walk_sounds():
    _footstep_audio_player.finished.connect(self._play_footstep_sound);
    _play_footstep_sound();


## Stops playing the players walking sounds.
func stop_walk_sounds():
    _footstep_audio_player.finished.disconnect(self._play_footstep_sound);


## Plays a random footstep sound.
func _play_footstep_sound():
    Helpers.playRandomSoundFromArray(_footstep_sounds, _footstep_audio_player);