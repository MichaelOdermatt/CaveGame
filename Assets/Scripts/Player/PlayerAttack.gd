class_name PlayerAttack;

var _animation_player: AnimationPlayer;

func _init(animation_player: AnimationPlayer):
    _animation_player = animation_player;
    _setup_signals();

func player_attack():
    _animation_player.play('attack');

func _setup_signals() -> void:
    _animation_player.animation_finished.connect(self._on_animation_finished);

func _on_animation_finished(anim_name: String) -> void:
    if anim_name == 'attack':
        _animation_player.play('idle');
