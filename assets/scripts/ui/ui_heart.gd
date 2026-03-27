extends Node
class_name UIHeart

@export var sprite : AnimatedSprite2D

func delete() -> void:
	sprite.play("fall")
	sprite.animation_finished.connect(
		func(): queue_free()
	)
