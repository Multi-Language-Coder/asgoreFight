# pellet_behavior.gd
extends Area2D

var velocity: Vector2 = Vector2.ZERO
var is_moving: bool = false

func _process(delta: float):
	# Only move if is_moving is true
	if is_moving:
		position += velocity * delta
	else:
		pass
