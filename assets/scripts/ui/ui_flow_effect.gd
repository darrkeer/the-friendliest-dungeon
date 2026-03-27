extends Control

@export var repeat_time : float
@export var flow_time : float
@export var max_x : int
@export var max_y : int

func _ready() -> void:
	while true:
		await flow()

func flow() -> void:
	var vec = Vector2(randi_range(-max_x, max_x), max_y)

	var tween1 = create_tween()
	tween1.set_trans(Tween.TRANS_SINE)
	tween1.set_ignore_time_scale(true)
	tween1.tween_property(self, "position", position - vec, flow_time / 2)
	await tween1.finished
	
	var tween2 = create_tween()
	tween1.set_trans(Tween.TRANS_SINE)
	tween2.set_ignore_time_scale(true)
	tween2.tween_property(self, "position", position + vec, flow_time / 2)
	await tween2.finished
