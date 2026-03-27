extends Node

@export var scenes : Array[LevelResource]
@export var start_scene : String

signal player_ready

var player : Player
var current_scene : String

func _ready() -> void:
	load_level(start_scene)

func reload_level() -> void:
	load_level(current_scene)

func load_level(scene_name : String) -> void:
	var new_scene : PackedScene
	for s in scenes:
		if s.level_name == scene_name:
			new_scene = s.scene
	if new_scene == null:
		push_error("Could not find scene '%s'!" % scene_name)
		return
	
	await UIController.scene_changer.fade_in()
	
	get_tree().change_scene_to_packed(new_scene)
	
	await UIController.scene_changer.fade_out()
	
	current_scene = scene_name
