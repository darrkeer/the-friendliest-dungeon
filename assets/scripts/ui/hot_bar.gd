extends Node
class_name HotBarController

@export var hotbar_contaiter : HBoxContainer
@export var hotbar_slot : PackedScene

func _ready() -> void:
	GameController.player_ready.connect(_on_player_ready)

func _on_player_ready() -> void:
	for ch in hotbar_contaiter.get_children():
		ch.queue_free()
	for i in range(GameController.player.inventory.size):
		var new_slot = hotbar_slot.instantiate()
		(new_slot as HotBarSlot).index = i
		hotbar_contaiter.add_child(new_slot)
