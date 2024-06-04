class_name PlayerEffects;
extends Node;

var _water_ripple_effect = preload("res://Assets/Effects/WaterRippleEffect.tscn");
var _character: CharacterBody3D;
var _walk_surface_detection: Area3D;


func _init(character: CharacterBody3D, walk_surface_detection: Area3D):
	_character = character;
	_walk_surface_detection = walk_surface_detection;


## Creates the walk surface effect for the surface the player is currently walking on.
func create_walk_surface_effect():
	var collider = Helpers.get_collider_of_walk_surface_type(_walk_surface_detection, 'Water');
	if (collider != null):
		_create_water_ripple_effect(collider);
	pass;


## Creates the water ripple effect.
func _create_water_ripple_effect(water_collider: Node3D):
	var effect = _water_ripple_effect.instantiate();
	_character.get_parent().add_child(effect);
	effect.transform.origin = _character.transform.origin;

	# Give the effect the same height as the water_collider's height. Also Make sure
	# the water's collider object is at the same height as the mesh's surface.
	effect.global_position.y = water_collider.global_position.y;
