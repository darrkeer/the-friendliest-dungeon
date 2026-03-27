extends State
class_name StateWithAnimation

@export var animation_player : AnimationPlayer
@export var animation_name : String

func prepare() -> void:
	super()
	if not animation_name:
		animation_name = state_name

func enter(_options := {}) -> void:
	super()
	animation_player.play(animation_name)
