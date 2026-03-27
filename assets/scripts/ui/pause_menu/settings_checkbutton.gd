extends CheckButton

@export var setting_name : String

func _ready() -> void:
	pressed.connect(_on_pressed)
	Settings.settings_changed.connect(_on_settings_changed)
	_on_settings_changed()

func _on_settings_changed() -> void:
	button_pressed = Settings.data[setting_name]

func _on_pressed() -> void:
	Settings.change(setting_name, button_pressed)
