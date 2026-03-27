extends ExchangerBase

@export var first_hint : Hint
@export var second_hint : Hint
@export var interactable : Interactable
var used = false

func _ready() -> void:
	interactable.hint = first_hint

func exchange() -> void:
	if used:
		return
	super()
	used = true
	interactable.hint = second_hint
