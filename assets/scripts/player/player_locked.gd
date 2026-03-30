extends StateWithAnimation

@export var player : CharacterBody3D

func fixed_update(_delta : float) -> void:
	player.velocity = Vector3.ZERO
	
	player.move_and_slide()
