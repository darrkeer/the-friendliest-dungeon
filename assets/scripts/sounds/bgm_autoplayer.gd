extends Node

@export var song_name : String

func _ready() -> void:
	BGMController.play_music(song_name)
