extends Node3D;

func _ready():
    _setup_up_down_tween();
    _setup_spin_tween();


func _setup_up_down_tween():
    var initial_position = self.transform.origin;
    var final_position = initial_position - Vector3(0, -0.5, 0);
    var up_down_tween = get_tree().create_tween().set_loops();
    up_down_tween.tween_property(self, 'position', final_position, 2).from(initial_position).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT);
    up_down_tween.tween_property(self, 'position', initial_position, 2).from(final_position).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT);


func _setup_spin_tween():
    var spin_tween = get_tree().create_tween().set_loops();
    spin_tween.tween_property(self, 'rotation_degrees', Vector3(0, 360, 0), 5).as_relative();