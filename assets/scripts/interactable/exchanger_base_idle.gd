extends StateWithAnimation

@export var base : ExchangerBase
@export var interactable : Interactable

func prepare() -> void:
	super()
	interactable.interacted.connect(_on_interact)

func _on_interact() -> void:
	if not is_in_state:
		return
	if base.exchange_item == null or GameController.player.inventory.get_held_item() == base.exchange_item:
		state_machine.change_state("exchange")
	else:
		state_machine.change_state("not_enough")

func fixed_update(_delta : float) -> void:
	interactable.fixed_process()
