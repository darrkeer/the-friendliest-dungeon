extends Node

const ROTATE_DELAY = 0.1
const ROTATE_AMOUNT = 0.7
@export var body : CharacterBody3D
@export var rotate_timer : Timer 

func _ready() -> void:
	rotate_timer.wait_time = ROTATE_DELAY
	rotate_timer.timeout.connect(_on_rotate_timer)

func _on_rotate_timer() -> void:
	var vel = -Vector3(body.velocity.x, 0, body.velocity.z).normalized()
	if vel != Vector3.ZERO:
		var target_angle = atan2(vel.x, vel.z)
		body.rotation.y = lerp_angle(body.rotation.y, target_angle, ROTATE_AMOUNT)
