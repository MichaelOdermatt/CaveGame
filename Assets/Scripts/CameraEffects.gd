class_name CameraEffects;

var _camera: Camera3D;

func _init(camera: Camera3D):
    _camera = camera;


## Shakes the camera.
func shake(shake_time: float, shake_magnitude):
    var initial_transform = _camera.transform 
    var elapsed_time = 0.0

    while elapsed_time < shake_time:
        var offset = Vector3(
    		randf_range(-shake_magnitude, shake_magnitude),
    		randf_range(-shake_magnitude, shake_magnitude),
    		0.0
    	);

        _camera.transform.origin = initial_transform.origin + offset;
        elapsed_time += _camera.get_process_delta_time();
        await _camera.get_tree().process_frame;

    _camera.transform = initial_transform;