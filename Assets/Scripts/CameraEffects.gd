class_name CameraEffects;

const _SHAKE_MAGNITUDE = 0.4

var _camera: Camera3D;

func _init(camera: Camera3D):
    _camera = camera;


## Shakes the camera.
func shake(shake_time: float):
    var initial_transform = _camera.transform 
    var elapsed_time = 0.0

    while elapsed_time < shake_time:
        var offset = Vector3(
    		randf_range(-_SHAKE_MAGNITUDE, _SHAKE_MAGNITUDE),
    		randf_range(-_SHAKE_MAGNITUDE, _SHAKE_MAGNITUDE),
    		0.0
    	);

        _camera.transform.origin = initial_transform.origin + offset;
        print_debug(elapsed_time);
        elapsed_time += _camera.get_process_delta_time();
        await _camera.get_tree().process_frame;

    _camera.transform = initial_transform;