extends Resource
class_name Hint

@export var hint_name : String
@export var hint_text : String
@export var hint_additional_text : String
@export var show_time : float

func get_key_by_action(action_name : String) -> String:
	var res = []
	for event in InputMap.action_get_events(action_name):
		res.append(OS.get_keycode_string((event as InputEventKey).physical_keycode))
	if res.size() == 0:
		push_error("could not find action key with name '%s'" % action_name)
		return ""
	return " / ".join(res)

func get_actual_hint_text() -> String:
	return _get_actual_text(hint_text)

func get_actual_additional_text() -> String:
	return _get_actual_text(hint_additional_text)

func _get_actual_text(text : String) -> String:
	var msg = ""
	var hint = ""
	var is_keymap = false
	for c in text:
		if c == "{":
			if hint != "":
				push_error("incorrect hint text: '%s'" % text)
				return ""
			is_keymap = true
			hint = ""
		elif c == "}":
			if not is_keymap:
				push_error("incorrect hint text: '%s'" % text)
				return ""
			is_keymap = false
			msg += get_key_by_action(hint)
			hint = ""
		else:
			if is_keymap:
				hint += c
			else:
				msg += c
	return msg
