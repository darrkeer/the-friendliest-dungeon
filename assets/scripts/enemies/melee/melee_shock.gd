extends StateWithAnimation

@export var base : EnemyBase
@export var shock_timer : Timer
@export var particles : CPUParticles3D

func enter(_options := {}) -> void:
	super()
	shock_timer.start()
	particles.emitting = true
	base.look_at_player()
	SFXController.play_sound("skeleton_shock", base.global_position)

func fixed_update(_delta : float) -> void:
	if shock_timer.is_stopped():
		state_machine.change_state("chase_player")
		return
	
	base.velocity = Vector3.ZERO
	base.move_and_slide()
