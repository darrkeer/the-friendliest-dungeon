extends StateWithAnimation

@export var door : Node3D

func prepare() -> void:
	super()
	animation_player.animation_finished.connect(_on_animation_finished)

func enter(_options := {}) -> void:
	super()
	SFXController.play_sound("door_close", door.global_position)

func _on_animation_finished(_anim_name) -> void:
	if is_in_state:
		state_machine.change_state("closed")
