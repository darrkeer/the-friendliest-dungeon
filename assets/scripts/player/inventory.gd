extends Node
class_name Inventory

@export var all_items : Array[ItemResource]

@export var size : int = 4
@export var items : Array[ItemResource]

signal cur_slot_changed
signal inventory_changed

var cur_slot = 0

func get_item_resource_by_name(item_name : String) -> ItemResource:
	for i in all_items:
		if i.item_name == item_name:
			return i
	return null

func _get_free_item_slot() -> int:
	if items[cur_slot] == null:
		return cur_slot
	for i in range(size):
		if items[i] == null:
			return i
	return -1

func get_held_item() -> ItemResource:
	return get_item(cur_slot)
	
func get_item(slot : int) -> ItemResource:
	return items[slot]

func has_free_space() -> bool:
	return _get_free_item_slot() != -1

func add_item_by_name(item_name : String) -> bool:
	var res = get_item_resource_by_name(item_name)
	if res == null:
		push_error("unknown item's name: %s" % item_name)
	return add_item(res)

func add_item(item : ItemResource) -> bool:
	var slot = _get_free_item_slot()
	if slot == -1:
		return false
	
	items[slot] = item
	inventory_changed.emit()
	SFXController.play_sound("pickup", GameController.player.global_position)
	return true

func use_item() -> void:
	var res = get_held_item()
	if res is UsableItem:
		res.use()

func remove_held_item() -> bool:
	return remove_item(cur_slot)

func remove_item(slot : int) -> bool:
	if items[slot] == null:
		return false
	items[slot] = null
	inventory_changed.emit()
	return true

func change_slot(slot : int) -> bool:
	if slot < 0 or slot >= size:
		return false
	cur_slot = slot
	cur_slot_changed.emit()
	if get_held_item():
		SFXController.play_sound(get_held_item().hover_sound_name, GameController.player.global_position)
	return true

func _ready() -> void:
	change_slot(0)
	items.clear()
	for i in range(size):
		items.append(null)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
		change_slot((cur_slot + 1) % size)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed():
		if cur_slot == 0:
			change_slot(size - 1)
		else:
			change_slot(cur_slot - 1)
