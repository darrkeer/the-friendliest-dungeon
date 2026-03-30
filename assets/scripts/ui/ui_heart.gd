extends Node
class_name UIHeart

@export var sprite : AnimatedSprite2D

func delete() -> void:
	sprite.play("fall")
	sprite.animation_finished.connect(
		func(): queue_free()
	)

func restart_anim() -> void:
	var anim = sprite.animation
	sprite.stop()
	sprite.play(anim)
