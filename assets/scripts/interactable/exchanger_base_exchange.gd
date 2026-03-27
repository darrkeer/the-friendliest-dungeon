extends StateWithAnimation

const EXCHANGE_TIME = 1.0
@export var base : ExchangerBase

var exchanged = false

func enter(_options := {}) -> void:
	super()
	exchanged = false
	Utils.create_one_shot_timer(EXCHANGE_TIME).timeout.connect(
		func(): exchanged = true
	)
	base.exchange()

func fixed_update(_delta : float) -> void:
	if is_in_state and exchanged:
		state_machine.change_state("idle")

#func _on_animation_finished(_anim_name) -> void:
	#if is_in_state and exchanged:
		#state_machine.change_state("idle")
