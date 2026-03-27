extends AudioStreamPlayer

const MIN_DB = -40
const MAX_DB = 20

@export var music : Dictionary[String, AudioStream]

func _ready() -> void:
	Settings.settings_changed.connect(_on_settings_changed)
	_on_settings_changed()

func _on_settings_changed() -> void:
	volume_db = lerp(MIN_DB, MAX_DB, Settings.get_bgm_volume())

func play_music(song_name : String) -> void:
	if song_name not in music:
		push_error("cant find bgm: '%s'" % song_name)
		return
	stream = music[song_name]
	play()

func stop_music() -> void:
	stop()
