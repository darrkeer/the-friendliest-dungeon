extends StateWithAnimation

@export var base : EnemyBase

var food : Item

func enter(_options := {}) -> void:
	super()
	food = base.get_food_nearby()
	base.agent.target_position = food.global_position

func fixed_update(_delta : float) -> void:
	if not is_instance_valid(food):
		state_machine.change_state("patrol")
		return
	
	if base.agent.is_navigation_finished():
		state_machine.change_state("eat", {"food": food})
		return 
	
	base.move_to_and_rotate(base.agent.get_next_path_position())
	
	base.move_and_slide()
