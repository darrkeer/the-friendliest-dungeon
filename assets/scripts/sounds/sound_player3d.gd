extends AudioStreamPlayer3D
class_name SoundPlayer3D

var playing_sound = ""

func _ready() -> void:
	finished.connect(
		func(): playing_sound = ""
	)

func can_play() -> bool:
	return playing_sound == ""

func play_sound(sound : AudioStream, pos : Vector3, sound_name : String) -> bool:
	if not can_play():
		return false
	playing_sound = sound_name
	stream = sound
	global_position = pos
	play()
	return true

func stop_sound() -> void:
	stop()
	playing_sound = ""
