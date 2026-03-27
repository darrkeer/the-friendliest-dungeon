extends Node

@export var	data : Dictionary

signal settings_changed

func change(setting_name : String, val) -> void:
	data[setting_name] = val
	settings_changed.emit()

func get_camera_distance() -> float:
	return data["camera_distance"]

func set_camera_distance(val : float) -> void:
	_checked_set_01("camera_distance", val)

func get_mouse_sens() -> float:
	return data["mouse_sens"]

func set_mouse_sens(val : float) -> void:
	_checked_set_01("mouse_sens", val)

func _checked_set_01(par : String, val : float) -> void:
	if val < 0 or val > 1:
		push_error("incorrect setting for '%s'" % par)
		return
	data[par] = val
	settings_changed.emit()

func get_invert_mouse_x() -> bool:
	return data["invert_mouse_x"]

func set_invert_mouse_x(val : bool) -> void:
	data["invert_mouse_x"] = val

func get_invert_mouse_y() -> bool:
	return data["invert_mouse_y"]

func set_invert_mouse_y(val : bool) -> void:
	data["invert_mouse_y"] = val

func get_sfx_volume() -> float:
	return data["sfx_volume"]

func set_sfx_volume(val : float) -> void:
	_checked_set_01("sfx_volume", val)

func get_bgm_volume() -> float:
	return data["bgm_volume"]

func set_bgm_volume(val : float) -> void:
	_checked_set_01("bgm_volume", val)

# TODO: everyone is setting settings in begin of scene, and changes erasing
# on start of each scene
