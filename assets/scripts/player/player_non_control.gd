extends StateWithAnimation

@export var player : Player

var just_started = false

func enter(_options := {}) -> void:
	super()
	just_started = true
	Utils.create_one_shot_timer(0.05).timeout.connect(
		func(): just_started = false
	)

func fixed_update(delta : float) -> void:
	if not just_started and player.is_on_floor():
		state_machine.change_state("idle")
	
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
