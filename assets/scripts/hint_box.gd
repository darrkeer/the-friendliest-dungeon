extends Area3D

@export var hint : Hint

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body : Node3D) -> void:
	if body.is_in_group("player"):
		UIController.hints.show_hint(hint)
