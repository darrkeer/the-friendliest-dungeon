extends StateWithAnimation

@export var base : EnemyBase

func enter(_options := {}) -> void:
	super()
	base.next_point()

func fixed_update(_delta : float) -> void:
	if base.can_see_fav_food():
		state_machine.change_state("chase_food")
		return
	
	if base.can_see_player():
		state_machine.change_state("shock")
		return
	
	if base.can_hear_player():
		state_machine.change_state("chase_sound")
		return
	
	if base.agent.is_navigation_finished():
		state_machine.change_state("patrol_wait")
		return 
	
	base.move_to_and_rotate(base.agent.get_next_path_position())
	
	base.move_and_slide()
