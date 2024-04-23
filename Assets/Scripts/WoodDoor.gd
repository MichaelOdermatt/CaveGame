extends MeshInstance3D;

@onready var area3D = $Area3D;
@onready var static_body_collider = $StaticBody3D/CollisionShape3D;
@onready var door_brackets = get_node('../DoorBrackets');

var is_door_broken = false;

func _ready():
    _setup_signals();


func _setup_signals():
    area3D.area_entered.connect(self._on_area_entered);


func _on_area_entered(area: Area3D):
    if (area.name == 'PickaxeArea' && !is_door_broken):
        break_door();


func break_door():
    visible = false;
    door_brackets.visible = false;
    static_body_collider.set_deferred('disabled', true);
    is_door_broken = true;
