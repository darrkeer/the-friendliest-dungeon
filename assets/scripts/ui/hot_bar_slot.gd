extends Control
class_name HotBarSlot

@export var index : int
@export var small_size_px : int = 40
@export var big_size_px : int = 80
@export var item_sprite : TextureRect

var big_mode = false
var resource : ItemResource

func _ready() -> void:
	GameController.player.inventory.cur_slot_changed.connect(_on_cur_slot_changed)
	GameController.player.inventory.inventory_changed.connect(_on_inventory_changed)
	_switch_to_small()

func _switch_to_small() -> void:
	big_mode = false
	custom_minimum_size = Vector2(small_size_px, small_size_px)

func _switch_to_big() -> void:
	big_mode = true
	custom_minimum_size = Vector2(big_size_px, big_size_px)

func _on_inventory_changed() -> void:
	resource = GameController.player.inventory.get_item(index)
	if resource == null:
		item_sprite.texture = null
	else:
		item_sprite.texture = resource.sprite


func _on_cur_slot_changed() -> void:
	var new_slot = GameController.player.inventory.cur_slot
	if big_mode and new_slot != index:
		_switch_to_small()
	elif new_slot == index:
		_switch_to_big()
