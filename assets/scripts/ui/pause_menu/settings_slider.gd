extends Slider

@export var setting_name : String

func _ready() -> void:
	value_changed.connect(_on_value_changed)
	Settings.settings_changed.connect(_on_settings_changed)
	_on_settings_changed()

func _on_settings_changed() -> void:
	value = lerp(min_value, max_value, Settings.data[setting_name])

func _on_value_changed(val : float) -> void:
	var t = inverse_lerp(min_value, max_value, val)
	Settings.change(setting_name, t)
