extends StateWithAnimation

@export var base : EnemyBase
@export var update_path_timer : Timer

var last_player_pos : Vector3

func prepare() -> void:
	super()
	update_path_timer.timeout.connect(_on_update)

func enter(_options := {}) -> void:
	super()
	update_path_timer.start()

func exit() -> void:
	super()
	update_path_timer.stop()

func _on_update() -> void:
	base.agent.set_target_position(last_player_pos)

func fixed_update(_delta : float) -> void:
	if base.can_see_fav_food():
		state_machine.change_state("chase_food")
		return
	
	if base.distance_to_player() <= base.ATTACK_RANGE:
		state_machine.change_state("attack")
		return
	
	if base.can_see_player():
		last_player_pos = GameController.player.global_position
	elif base.can_hear_player():
		state_machine.change_state("chase_sound")
		return
	
	if base.agent.is_navigation_finished():
		state_machine.change_state("patrol")
		return 
	
	base.move_to_and_rotate(base.agent.get_next_path_position())
	
	base.move_and_slide()
