extends AnimatedSprite2D

# Movement speed
const SPEED: float = 200.0
@onready var main_game_script = get_tree().get_root().get_node("AsgoreFight")
# Reference to the attack box boundaries
var attack_box_rect: Rect2

# Called by the main scene when the attack starts
func start_soul_control(bounds: Rect2):
	attack_box_rect = bounds
	set_process(true) # Start listening to input

# Called by the main scene when the attack ends
func stop_soul_control():
	set_process(false) # Stop listening to input

func _process(delta: float):
	# 1. Capture Input Direction
	if main_game_script and (main_game_script.menuStatus == "asgore"):
		
		var direction: Vector2 = Input.get_vector(
			"ui_left", "ui_right", "ui_up", "ui_down"
		)
		
		# 2. Calculate new position
		var velocity: Vector2 = direction * SPEED
		var new_position: Vector2 = position + velocity * delta
		
		# 3. Apply Clamping (Keeping the Soul inside the attack box)
		# The clamp ensures new_position stays within the rect.
		# Note: We must convert the local Soul position to the parent's coordinates
		# before clamping, or you need to clamp against global bounds.
		
		# Since the Soul is likely parented to the scene root and the attack box is a child of BackgroundBattle, 
		# we'll use a local position relative to the AttackBox's global coordinates.
		
		# Simple Local Clamping (Assuming the Soul is NOT parented to the attack box, but the root)
		if attack_box_rect:
			# Convert Soul's new global position to local position relative to AttackBox's origin
			var local_pos_in_box = get_parent().to_local(new_position)
			
			# Clamp the position relative to the AttackBox parent:
			new_position.x = clamp(new_position.x, attack_box_rect.position.x, attack_box_rect.end.x)
			new_position.y = clamp(new_position.y, attack_box_rect.position.y, attack_box_rect.end.y)
			
		# 4. Update the position
		position = new_position
