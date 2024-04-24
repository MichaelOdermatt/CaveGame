class_name PlayerAttack;

var _animation_tree: AnimationTree;

func _init(animation_tree: AnimationTree):
    _animation_tree = animation_tree;


## Runs the player attack animation.
func player_attack():
    if (_animation_tree.get("parameters/PlayerAttack/active") == false):
        _animation_tree.set("parameters/PlayerAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE);
