extends State

func enter(_options := {}) -> void:
	super()
	var item = GameController.player.inventory.get_held_item()
	print(item)
	if item != null:
		var dir = (GameController.player.get_look_dir() + Vector3.UP).normalized()
		var obj = item.scene.instantiate() as RigidBody3D
		add_child(obj)
		obj.global_position = GameController.player.global_position
		obj.apply_impulse(dir * GameController.player.throw_velocity)
		GameController.player.inventory.remove_held_item()

func fixed_update(_delta : float) -> void:
	state_machine.change_state("idle")
