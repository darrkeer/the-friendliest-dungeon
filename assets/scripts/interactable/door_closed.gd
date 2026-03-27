extends StateWithAnimation

@export var interactable : Interactable

func prepare() -> void:
	super()
	interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	if is_in_state:
		state_machine.change_state("open")

func fixed_update(_delta : float) -> void:
	interactable.fixed_process()
