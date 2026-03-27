extends StateWithAnimation

@export var base : EnemyBase
@export var attack_timer : Timer

func enter(_options := {}) -> void:
	super()
	GameController.player.state_machine.change_state("hit", {"origin": base.global_position})
	attack_timer.start()

func exit() -> void:
	super()
	SFXController.play_sound("damage", base.global_position)

func fixed_update(_delta : float) -> void:
	if attack_timer.is_stopped():
		state_machine.change_state("patrol")
		return
	
	base.velocity = Vector3.ZERO
	base.move_and_slide()
