extends Node;

## Randomly selects a sound from the array and plays it through the given audio player.
func playRandomSoundFromArray(arrayOfSounds: Array, audioPlayer: AudioStreamPlayer):
	randomize();
	var soundToPlay = arrayOfSounds[randi_range(0, len(arrayOfSounds) - 1)];
	audioPlayer.stream = soundToPlay;
	audioPlayer.play();
