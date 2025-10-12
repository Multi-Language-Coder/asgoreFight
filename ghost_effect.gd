# after_image_effect.gd
extends Node2D

# (Setup comments and node references are the same)
@onready var sprite: AnimatedSprite2D = $Asgore
@onready var ghost_timer: Timer = $GhostTimer


# (The move_with_trail, start_effect, and stop_effect functions are the same)
func move_with_trail(distance_pixels: float, duration_seconds: float):
	start_effect()
	var move_tween = create_tween()
	move_tween.tween_property(self, "position:x", position.x + distance_pixels, duration_seconds)
	move_tween.finished.connect(stop_effect)

func start_effect():
	ghost_timer.start()

func stop_effect():
	ghost_timer.stop()


# This function runs every time the GhostTimer finishes its countdown.
func _on_ghost_timer_timeout():
	var ghost = Sprite2D.new()

	ghost.texture = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	ghost.global_position = sprite.global_position
	ghost.global_rotation = sprite.global_rotation
	ghost.global_scale = sprite.global_scale
	
	# --- THE FIX IS HERE ---
	# Set the z_index to -1 to force ghosts to draw BEHIND the main sprite.
	ghost.z_index = 5
	
	get_parent().add_child(ghost)

	var tween = ghost.create_tween()
	tween.tween_property(ghost, "modulate:a", 0.0, 0.8)
	tween.finished.connect(ghost.queue_free)
