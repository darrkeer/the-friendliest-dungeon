extends Area3D
class_name Interactable

@export var hint : Hint

signal interacted

var is_player_near = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body : Node3D) -> void:
	if body.is_in_group("player"):
		is_player_near = true
		UIController.hints.show_hint(hint)

func _on_body_exited(body : Node3D) -> void:
	if body.is_in_group("player"):
		is_player_near = false
		UIController.hints.hide_hint(hint)

func fixed_process() -> void:
	if is_player_near and InputController.is_interact_pressing():
		interacted.emit()
