extends Node;

## Randomly selects a sound from the array and plays it through the given audio player.
func playRandomSoundFromArray(array_of_sounds: Array, audio_player: AudioStreamPlayer, randomize_pitch: bool):
	randomize();
	var sound_to_play = array_of_sounds[randi_range(0, len(array_of_sounds) - 1)];
	if (randomize_pitch):
		audio_player.pitch_scale = randf_range(0.8, 1.2);
	audio_player.stream = sound_to_play;
	audio_player.play();
