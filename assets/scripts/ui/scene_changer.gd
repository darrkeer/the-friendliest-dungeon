extends ColorRect
class_name SceneChanger

const MAX_CIRCLE_SIZE = 2000
const DURATION = 1.0

func process(from, to : float) -> void:
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	await tween.tween_method(
		func(x): material.set_shader_parameter("size", x),
		from, to, DURATION
	).finished

func fade_out() -> void:
	await process(0, MAX_CIRCLE_SIZE)

func fade_in() -> void:
	await process(MAX_CIRCLE_SIZE, 0)
