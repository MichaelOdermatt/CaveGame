class_name PlayerAttack;

var _animation_tree: AnimationTree;
var _pickaxe_model: Node3D;
var _pickaxe_area3D: Area3D;

func _init(animation_tree: AnimationTree, pickaxe_model: Node3D, pickaxe_area3D: Area3D):
    _animation_tree = animation_tree;
    _pickaxe_model = pickaxe_model;
    _pickaxe_area3D = pickaxe_area3D;


## Runs the player attack animation.
func player_attack():
    if (_animation_tree.get("parameters/PlayerAttack/active") == false):
        _animation_tree.set("parameters/PlayerAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE);


## Shows the pickaxe and enables monitorable on the area3D.
func equip_pickaxe():
    _pickaxe_model.visible = true;
    _pickaxe_area3D.set_deferred('monitorable', true);
    pass