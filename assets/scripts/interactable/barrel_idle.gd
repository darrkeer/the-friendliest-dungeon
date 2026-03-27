extends State

@export var interactable : Interactable
@export var barrel_node : Node3D

func prepare() -> void:
	interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	GameController.player.state_machine.change_state("barrel_idle")
	barrel_node.queue_free()

func fixed_update(_delta : float) -> void:
	interactable.fixed_process()
