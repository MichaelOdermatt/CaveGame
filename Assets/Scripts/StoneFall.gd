extends Node3D;

@onready var fallen_stone = $FallenStone;
@onready var fallen_stone_collision_shape = $FallenStone/Icosphere/StaticBody3D/CollisionShape3D;
@onready var suspended_stone = $SuspendedStone;
@onready var drop_stone_trigger_area = $DropStoneTriggerArea;
@onready var player = get_node('../Player');

func _ready():
	drop_stone_trigger_area.body_entered.connect(self._on_drop_stone_trigger_area_entered);


## Hides the suspended stone and shows the fallen one.
func _drop_stone():
	fallen_stone.visible = true;
	suspended_stone.visible = false;
	fallen_stone_collision_shape.set_deferred('disabled', false);
	player.shake_camera(0.5, 0.35);


## Invoked when the player enters the drop stone area.
func _on_drop_stone_trigger_area_entered(body: Node3D):
	if (player.has_pickaxe):
		_drop_stone();
		drop_stone_trigger_area.set_deferred('monitoring', false);