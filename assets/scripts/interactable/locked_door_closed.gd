extends "res://assets/scripts/interactable/door_closed.gd"

@export var unlocking_item : ItemResource
@export var unlocked_hint : Hint

var unlocked = false

func _on_interacted() -> void:
	if not unlocked:
		if GameController.player.inventory.get_held_item() == unlocking_item:
			unlocked = true
			GameController.player.inventory.remove_held_item()
			interactable.hint = unlocked_hint
		else:
			return
	super()
