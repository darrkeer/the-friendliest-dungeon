extends StateWithAnimation

@export var base : Item

func prepare() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name : String) -> void:
	if GameController.player.inventory.add_item_by_name(base.item_name):
		base.queue_free()
	else:
		state_machine.change_state("idle")
