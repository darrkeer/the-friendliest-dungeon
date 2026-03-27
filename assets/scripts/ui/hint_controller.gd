extends Node
class_name HintController

@export var name_label : Label
@export var hint_label : Label
@export var hint_add_label : Label

var cur_fade_tween : Tween
var showing_hint : Hint

func _change_opacity(val : float) -> void:
	name_label.modulate.a = val
	hint_label.modulate.a = val
	hint_add_label.modulate.a = val

func _ready() -> void:
	GameController.player_ready.connect(_on_player_ready)
	_change_opacity(0)

func _on_player_ready() -> void:
	GameController.player.inventory.inventory_changed.connect(_update_hint)
	GameController.player.inventory.cur_slot_changed.connect(_update_hint)

func _update_hint() -> void:
	hide_hint(showing_hint)
	if GameController.player.inventory.get_held_item():
		show_hint(GameController.player.inventory.get_held_item().hint)

func hide_hint(hint : Hint) -> void:
	if showing_hint != hint:
		return
	if cur_fade_tween and cur_fade_tween.is_valid():
		cur_fade_tween.kill()
	_change_opacity(0)

func show_hint(hint : Hint) -> void:
	showing_hint = hint
	name_label.text = hint._get_actual_text(hint.hint_name)
	hint_label.text = hint.get_actual_hint_text()
	hint_add_label.text = hint.get_actual_additional_text()
	
	if cur_fade_tween and cur_fade_tween.is_valid():
		cur_fade_tween.kill()
	cur_fade_tween = get_tree().create_tween()
	cur_fade_tween.set_trans(Tween.TRANS_CUBIC)
	cur_fade_tween.tween_method(_change_opacity, 1.0, 0.0, hint.show_time)
