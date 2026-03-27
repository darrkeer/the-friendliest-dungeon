extends Control

@export var back_button : Button
@export var restart_button : Button

var paused = false

func _ready() -> void:
	back_button.pressed.connect(unpause)
	restart_button.pressed.connect(
		func():
			unpause()
			GameController.reload_level()
	)
	unpause()

func pause() -> void: 
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Engine.time_scale = 0
	visible = true
	paused = true

func unpause() -> void:
	Engine.time_scale = 1
	visible = false
	paused = false

func _physics_process(_delta: float) -> void:
	if InputController.is_pausing():
		if paused:
			unpause()
		else:
			pause()
