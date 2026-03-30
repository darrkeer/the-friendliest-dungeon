extends Node
class_name HPBarController

@export var heart_scene : PackedScene
@export var heart_container : HBoxContainer

var hearts : Array[UIHeart]

func _ready() -> void:
	GameController.player_ready.connect(_on_player_ready)

func _on_player_ready() -> void:
	var need = GameController.player.MAX_HP - heart_container.get_child_count()
	for i in range(need):
		add_heart()

func add_heart() -> void:
	var new = heart_scene.instantiate()
	heart_container.add_child(new)
	hearts.append(new as UIHeart)
	_restart_animation()

func _restart_animation() -> void:
	for heart in hearts:
		heart.restart_anim()

func remove_heart() -> void:
	if hearts.size() == 0:
		push_error("Could not remove hearts, its already 0 of them!")
		return
	var cur = hearts[-1] as UIHeart
	hearts.remove_at(-1)
	cur.delete()
