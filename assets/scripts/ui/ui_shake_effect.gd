extends Control

@export var repeat_time : float
@export var single_move_time : float
@export var min_x : int
@export var max_x : int
@export var min_y : int
@export var max_y : int

func _ready() -> void:
	while true:
		var x = randi_range(min_x, max_x)
		var y = randi_range(min_y, max_y)
		await shake(Vector2(x, y), single_move_time)

func shake(vec : Vector2, speed : float) -> void:
	var initial_pos = position
	
	var tween1 = create_tween()
	tween1.set_ignore_time_scale(true)
	tween1.tween_property(self, "position", position + vec, speed)
	await tween1.finished
	
	var tween2 = create_tween()
	tween2.set_ignore_time_scale(true)
	tween2.tween_property(self, "position", initial_pos, speed)
	await tween2.finished
	
	await Utils.create_one_shot_timer(0.2).timeout
