extends UsableItem
class_name Potion

@export var effect : PlayerEffect
@export var duration : float
var empty_bottle_resource = preload("res://assets/resources/items/empty_bottle.tres")

func use() -> void:
	GameController.player.inventory.remove_held_item()
	GameController.player.inventory.add_item(empty_bottle_resource)
	effect.duration = duration
	effect.apply()
	SFXController.play_sound("potion", GameController.player.global_position)
	print("huh")
