extends Node3D

@export var next_level : String
@export var interactable : Interactable
@export var item_to_unlock : ItemResource

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	if item_to_unlock == null or GameController.player.inventory.get_held_item() == item_to_unlock:
		SFXController.play_sound("door_open", global_position)
		GameController.load_level(next_level)

func _physics_process(_delta: float) -> void:
	interactable.fixed_process()
