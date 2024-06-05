extends Node3D;

@onready var _animation_player: AnimationPlayer = $AnimationPlayer;
@onready var _splash_particles: GPUParticles3D = $SplashParticles;

func _ready():
    _animation_player.play('ripple');
    _splash_particles.emitting = true;


## Called by at the end of the animation.
func on_animation_end():
    queue_free();