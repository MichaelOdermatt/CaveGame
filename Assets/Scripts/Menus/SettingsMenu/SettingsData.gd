class_name SettingsData;

var selected_resolution: Vector2;
var selected_window_mode: int;
var selected_anti_aliasing: int;
var render_scale: float;
var look_sensitivity: float;
var fov: float;
## The volume level as a linear value. Make sure to convert this to a db value
## before applying this volume.
var master_volume: float;

func _init(
    selected_resolution_value: Vector2,
    selected_window_mode_value: int,
    selected_anti_aliasing_value: int,
    render_scale_value: float,
    look_sensitivity_value: float,
    fov_value: float,
    master_volume_value: float,
):
    selected_resolution = selected_resolution_value;
    selected_window_mode = selected_window_mode_value;
    selected_anti_aliasing = selected_anti_aliasing_value;
    render_scale = render_scale_value;
    look_sensitivity = look_sensitivity_value;
    fov = fov_value;
    master_volume = master_volume_value;