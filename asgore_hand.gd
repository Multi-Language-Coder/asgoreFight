# asgore_hand.gd (Script attached to the hand scene)
extends Node2D

var travel_direction: float # 1.0 for right, -1.0 for left
var timer: Timer
var pellet_scene: PackedScene

# Called by the main script to start the attack sequence
func start_movement_and_spawn(duration: float, direction: float, pellet_scene_ref: PackedScene):
	travel_direction = direction
	pellet_scene = pellet_scene_ref
	
	# The full width of the area the hand moves across (approx 550 units)
	const FULL_WIDTH = 550 
	
	# --- Horizontal Movement (Moves off the opposite side) ---
	var tween_x = create_tween()
	var target_x = position.x + (direction * FULL_WIDTH) 
	tween_x.tween_property(self, "position:x", target_x, duration)
	
	# --- Vertical Movement (The Curve/Wave) ---
	var tween_y = create_tween()
	
	# 🎯 NEW: Use a small deviation for the curve
	const CURVE_DEVIATION = 15.0 # Max vertical movement for the curve
	var current_y = position.y
	
	# The sine transition makes the movement curve smoothly
	tween_y.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# 1. Move slightly up/down (to create the curve)
	tween_y.tween_property(self, "position:y", current_y + (CURVE_DEVIATION * direction), duration / 2.0)
	
	# 2. Return to the original Y position (finishing the curve)
	tween_y.tween_property(self, "position:y", current_y, duration / 2.0)

	# Start the continuous pellet spawning timer
	timer = Timer.new()

# Spawns a single pellet at the hand's current position
func _on_pellet_timer_timeout():
	var pellet = pellet_scene.instantiate()
	get_parent().add_child(pellet)
	pellet.global_position = global_position
	# The pellet's own script handles its rotation and movement (e.g., straight down or outward)
