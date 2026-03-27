extends Node
class_name HPBarController

@export var heart : PackedScene
@export var heart_container : HBoxContainer

func _ready() -> void:
	GameController.player_ready.connect(_on_player_ready)

func _on_player_ready() -> void:
	var need = GameController.player.HP - heart_container.get_child_count()
	for i in range(need):
		add_heart()

func add_heart() -> void:
	var new = heart.instantiate()
	heart_container.add_child(new)

func remove_heart() -> void:
	var children = heart_container.get_children()
	if children.size() == 0:
		push_error("Could not remove hearts, its already 0 of them!")
		return
	if children[-1] is not UIHeart:
		push_error("First object is not a UIHeart")
		return
	var cur = children[-1] as UIHeart
	cur.delete()
