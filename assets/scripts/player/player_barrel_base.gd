extends StateWithAnimation
class_name PlayerBarrelState

const THROW_BARREL_DISTANCE = 1.5

@export var player : Player
@export var barrel : Node3D
@export var barrel_scene : PackedScene
@export var hint : Hint

func enter(_options := {}) -> void:
	super()
	UIController.hints.show_hint(hint)
	barrel.visible = true

func exit() -> void:
	super()
	barrel.visible = false

func spawn_barrel() -> void:
	var ins = barrel_scene.instantiate()
	get_tree().current_scene.add_child(ins)
	(ins as Node3D).global_position = player.global_position + (Vector3.UP - player.basis.z) * THROW_BARREL_DISTANCE
