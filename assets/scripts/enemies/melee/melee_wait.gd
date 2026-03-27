extends StateWithAnimation

@export var base : EnemyBase
@export var wait_on_point_timer : Timer

func enter(_options := {}) -> void:
	super()
	wait_on_point_timer.start()

func fixed_update(_delta : float) -> void:
	if base.distance_to_player() > base.INACTIVE_DISTANCE:
		return
	
	if base.can_see_player():
		state_machine.change_state("shock")
		return
	
	if base.can_hear_player():
		state_machine.change_state("chase_sound")
		return
	
	if wait_on_point_timer.is_stopped():
		state_machine.change_state("patrol")
		return
	
	base.velocity = Vector3.ZERO
	base.move_and_slide()
