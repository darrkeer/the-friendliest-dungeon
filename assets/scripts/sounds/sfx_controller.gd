extends Node

const MIN_DB = -30
const MAX_DB = 20
const START_DB = -15

@export var sounds : Dictionary[String, AudioStream]
@export var polyphony = 15
@export var sound_player_scene : PackedScene

var players : Array[SoundPlayer3D]

func _ready() -> void:
	for i in range(polyphony):
		var player = sound_player_scene.instantiate() as SoundPlayer3D
		add_child(player)
		players.append(player)
	Settings.settings_changed.connect(_on_settings_changed)
	_on_settings_changed()

func _on_settings_changed() -> void:
	for p in players:
		p.volume_db = lerp(MIN_DB, MAX_DB, Settings.get_sfx_volume())

func play_sound(sound_name : String, pos : Vector3) -> void:
	if sound_name not in sounds:
		push_error("cant find sfx: '%s'" % sound_name)
		return
	var stream = sounds[sound_name]
	
	var player : SoundPlayer3D
	for p in players:
		if p.can_play():
			player = p
			break
	if player == null:
		push_error("sfx polyphony overload")
		return
	
	print("playing sound '%s'" % sound_name)
	player.play_sound(stream, pos, sound_name)
