class_name PlayerAttack;

var _animation_tree: AnimationTree;
var _pickaxe_raycast: RayCast3D;

func _init(animation_tree: AnimationTree, pickaxe_raycast):
    _animation_tree = animation_tree;
    _pickaxe_raycast = pickaxe_raycast;


## Runs the player attack animation.
func player_attack():
    if (_animation_tree.get("parameters/PlayerAttack/active") == false):
        _animation_tree.set("parameters/PlayerAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE);
