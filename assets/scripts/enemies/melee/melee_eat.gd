extends StateWithAnimation

@export var base : EnemyBase
@export var food : Node3D
@export var food_animation_player : AnimationPlayer
@export var sound_timer : Timer

func prepare() -> void:
	sound_timer.timeout.connect(_on_sound_timer_timeout)

func _on_sound_timer_timeout() -> void:
	if is_in_state:
		SFXController.play_sound("chips",  base.global_position)

func enter(options := {}) -> void:
	super()
	
	options["food"].queue_free()
	food.visible = true
	food_animation_player.stop()
	food_animation_player.play("fuck you")
	

func fixed_update(_delta : float) -> void:
	base.velocity = Vector3.ZERO

func exit() -> void:
	super()
	food.visible = false
