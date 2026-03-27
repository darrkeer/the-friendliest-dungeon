extends StaticBody3D
class_name ExchangerBase

@export var exchange_item : ItemResource
@export var items : Array[ItemResource]
@export var exchange_delay : float
@export var spawn_point : Node3D
@export var throw_force : float = 3
@export var exchange_sound_name : String

func exchange() -> void:
	for item in items:
		await Utils.create_one_shot_timer(exchange_delay).timeout
		var vec = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
		var new = item.scene.instantiate() as RigidBody3D
		get_tree().current_scene.add_child(new)
		new.global_position = spawn_point.global_position
		new.apply_impulse(vec * throw_force)
	if exchange_sound_name != "":
		SFXController.play_sound(exchange_sound_name, global_position)
	if exchange_item != null:
		GameController.player.inventory.remove_held_item()
