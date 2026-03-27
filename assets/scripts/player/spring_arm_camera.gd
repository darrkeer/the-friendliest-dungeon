extends Node3D

const MAX_X_ROTATION : float = 45
const MIN_X_ROTATION : float = -70

const MAX_DISTANCE : float = 7.5
const MIN_DISTANCE : float = 1.5

const INITIAL_MOUSE_SENS : float = 0.001
const MIN_MOUSE_SENS : float = 0.0002
const MAX_MOUSE_SENS : float = 0.005

@export var player : Player
@export var arm : SpringArm3D

var mouse_sens = 0.001
var invert_x = false
var invert_y = false

func _ready() -> void:
	Settings.settings_changed.connect(_on_settings_changed)
	_on_settings_changed()
	
func _on_settings_changed() -> void:
	arm.spring_length = lerp(MIN_DISTANCE, MAX_DISTANCE, Settings.get_camera_distance())
	mouse_sens = lerp(MIN_MOUSE_SENS, MAX_MOUSE_SENS, Settings.get_mouse_sens())
	invert_x = Settings.get_invert_mouse_x()
	invert_y = Settings.get_invert_mouse_y()

func _physics_process(_delta: float) -> void:
	global_position = player.global_position

func _input(event: InputEvent) -> void:
	if Engine.time_scale == 0:
		return
	
	if event is InputEventMouseMotion:
		var delta_x = event.screen_relative.x
		var delta_y = event.screen_relative.y
		if invert_x:
			delta_x *= -1
		if invert_y:
			delta_y *= -1
		
		
		rotation.x -= delta_y * mouse_sens
		rotation.y -= delta_x * mouse_sens
		
		var min_angle = deg_to_rad(MIN_X_ROTATION)
		var max_angle = deg_to_rad(MAX_X_ROTATION)
		
		rotation.x = clamp(rotation.x, min_angle, max_angle)
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed() and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
