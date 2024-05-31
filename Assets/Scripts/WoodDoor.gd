extends Node3D;

@onready var mesh = $DoorMesh;
@onready var area3D = $Area3D;
@onready var static_body_collider = $DoorMesh/StaticBody3D/CollisionShape3D;
@onready var door_brackets = get_node('../DoorBrackets');
@onready var wood_particles = $WoodParticles;
@onready var smoke_particles = $SmokeParticles;
@onready var _door_break_audio_player = $DoorBreakAudioPlayer;
@onready var player = get_node('../../Player');

var is_door_broken = false;

func _ready():
	_setup_signals();


func _setup_signals():
	area3D.area_entered.connect(self._on_area_entered);


func _on_area_entered(area: Area3D):
	if (area.name == 'PickaxeArea' && !is_door_broken):
		break_door();


## Breaks the wooden door
func break_door():
	mesh.visible = false;
	door_brackets.visible = false;
	wood_particles.emitting = true;
	smoke_particles.emitting = true;
	player.shake_camera(0.3, 0.15);
	static_body_collider.set_deferred('disabled', true);
	_door_break_audio_player.play();
	is_door_broken = true;
