extends StateWithAnimation

const SLOW_SPEED = 2

@export var player : Player

func prepare() -> void:
	animation_player.animation_finished.connect(_on_animation_finish)

func _on_animation_finish(_name):
	if is_in_state:
		GameController.reload_level()

func enter(_options := {}) -> void:
	super()
	SFXController.play_sound("death", player.global_position)

func fixed_update(delta : float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	
	player.velocity.x = move_toward(player.velocity.x, 0, delta * SLOW_SPEED)
	player.velocity.z = move_toward(player.velocity.z, 0, delta * SLOW_SPEED)
	player.move_and_slide()
