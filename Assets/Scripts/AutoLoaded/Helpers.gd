extends Node;

## Randomly selects a sound from the array and plays it through the given audio player.
func playRandomSoundFromArray(array_of_sounds: Array, audio_player: AudioStreamPlayer, randomize_pitch: bool) -> void:
	randomize();
	var sound_to_play = array_of_sounds[randi_range(0, len(array_of_sounds) - 1)];
	if (randomize_pitch):
		audio_player.pitch_scale = randf_range(0.8, 1.2);
	audio_player.stream = sound_to_play;
	audio_player.play();


## Plays a string representing the material type that the player is currently on.
func get_walk_surface_type(walk_surface_detection: Area3D) -> String:
	var colliders = walk_surface_detection.get_overlapping_bodies();

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


## Returns the collider of the walk surface if it is part of the given surface type. Else returns null
func get_collider_of_walk_surface_type(walk_surface_detection: Area3D, surface_type: String) -> Node3D:
	var colliders = walk_surface_detection.get_overlapping_bodies();

	# Get a list of all the groups that the colliders are in.
	for collider in colliders:
		var collider_groups = collider.get_groups();
		if (collider_groups.has(surface_type)):
			return collider;
	
	return null;
