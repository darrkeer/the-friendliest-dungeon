extends StateWithAnimation

func fixed_update(_delta : float) -> void:
	state_machine.change_state("idle")
