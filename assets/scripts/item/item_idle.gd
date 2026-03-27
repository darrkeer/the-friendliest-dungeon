extends StateWithAnimation

@export var interactable : Interactable

func prepare() -> void:
	interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	state_machine.change_state("pickup")

func fixed_update(_delta : float) -> void:
	interactable.fixed_process()
