extends Node2D
@onready var startupTextBox = $StartupText
@onready var face = $MovingBody/Asgore/Face
@onready var asgoreBody = $MovingBody/Asgore
@onready var bergentruckung = $Background/Bergentruckung
@onready var asgoreTextLabel = $AsgoreText
@onready var textContainer = $DialogueBoxAsgore
@onready var asgoreVoice = $asgoreVoice
@onready var wholeBody =$MovingBody
@onready var backgroundColor = $Background
@onready var spear = $MovingBody/Asgore/Spear
@onready var mercyButton = $Background/BattleUIHolder/Mercy
@onready var battleUI = $Background/BattleUIHolder
var scene = "res://asgore_fight.tscn"
var startupText = [
	" * (A strange light fills the
   room)",
	" * (Twilight is shining through
   the barrier)",
	" * (It seems your journey is
   finally over.)",
	" * (You're filled with
			  DETERMINATION.)"
]
var asgoreText = [
	"Human . . .",
	"It was
nice to
meet
you.",
"Goodbye."
]
var sadFace = preload("res://Bergentruckung/spr_asgore_bface/spr_asgore_bface_0.png")
var regretFace = preload("res://Bergentruckung/spr_asgore_bface/spr_asgore_bface_1.png")
var focusedFace = preload("res://Bergentruckung/spr_asgore_bface/spr_asgore_bface_2.png")
var shadowFigure = preload("res://AsgoreSprites/BattleSprites/spr_asgore_flashsilhouette.png")
var asgoreVoiceSnd = preload("res://snd/snd_effects/asgoreVoice.wav")
var asgoreSlide = preload("res://snd/snd_effects/slide.wav")
var asgoreUnleash = preload("res://snd/snd_effects/tridentShow.wav")
var buttonShatter = preload("res://snd/snd_effects/heartShatter.wav")
var shatter_pieces = [
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_0.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_1.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_2.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_3.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_4.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_5.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_6.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_7.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_8.png"),
	preload("res://BattleMenuSprites/spr_mercybutton_shatter/spr_mercybutton_shatter_9.png")
]
func displayTextNone(text):
	startupTextBox.text = ""
	print(len(text))
	for char in text:
		startupTextBox.text += char
		await get_tree().create_timer(0.05).timeout # Using a slightly faster speed

func displayTextAsgore(text):
	textContainer.show()
	asgoreTextLabel.text = ""
	for char in text:
		asgoreTextLabel.text += char
		if char != " ":
			playEffect(asgoreVoiceSnd)
		await get_tree().create_timer(0.09).timeout

func _ready():
	var deaths = save.load_game()
	if deaths == 0:
		spear.modulate = Color(255,0,0,1)
		spear.hide()
		bergentruckung.play()
		textContainer.hide()
		# Add the "await" keyword before each call
		await displayTextNone(startupText[0])
		await get_tree().create_timer(2.35).timeout # Using a shorter wait time
		
		await displayTextNone(startupText[1])
		await get_tree().create_timer(1.9).timeout
		
		await displayTextNone(startupText[2])
		await get_tree().create_timer(1.0).timeout
		
		await displayTextNone(startupText[3])
		await get_tree().create_timer(0.4)
		await get_tree().create_timer(1)
		displayTextAsgore(asgoreText[0])
	elif deaths != 0:
		spear.modulate = Color(255,0,0,1)
		spear.hide()
		goGoGO()

func _input(inp: InputEvent):
	if inp.is_action_pressed("Z") && asgoreTextLabel.text == asgoreText[0]:
		startupTextBox.text = ""
		face.texture = regretFace
		displayTextAsgore(asgoreText[1])
	elif inp.is_action_pressed("Z") && asgoreTextLabel.text == asgoreText[1]:
		face.texture = sadFace
		displayTextAsgore(asgoreText[2])
	elif inp.is_action_pressed("Z") && asgoreTextLabel.text == asgoreText[2]:
		goGoGO()
func playEffect(eff):
	asgoreVoice.stream = eff
	asgoreVoice.play()
	await asgoreVoice.finished
func rotate_node(final_angle_degrees: float, duration: float, node:Node2D):
	# 1. Create a new Tween.
	var tween = create_tween()
	var moveToLeft = create_tween()
	var moveToTop = create_tween()
	tween.tween_property(node, "rotation_degrees", final_angle_degrees, duration)
	moveToLeft.tween_property(node,"position:x", 25, duration)
	moveToTop.tween_property(node,"position:y", -80.0, duration)
	await get_tree().create_timer(2).timeout
	goDownAndDestroy()
func goDownAndDestroy():
	var goDown = create_tween()
	goDown.tween_property(spear,"position:y", 550, 1)
	await get_tree().create_timer(0.8).timeout
	playEffect(buttonShatter)
	shatter_mercy_button()
	await get_tree().create_timer(0.8).timeout
	backgroundColor.z_index=10
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(scene)
	
func shatter_mercy_button():
	var start_pos = mercyButton.global_position
	mercyButton.hide()
	
	# Loop through each of the piece textures we preloaded
	for piece_texture in shatter_pieces:
		var piece = Sprite2D.new()
		piece.texture = piece_texture
		piece.global_position = start_pos
		# Add the piece to the same container as the buttons
		$Background/BattleUIHolder.add_child(piece)
		
		# Create a tween to animate the piece
		var tween = create_tween()
		
		# 1. Animate Movement
		var random_x = randf_range(-120, 120) # Random horizontal direction
		var random_y = randf_range(-150, 50)  # Mostly upward/outward vertical direction
		var end_pos = start_pos + Vector2(random_x, random_y)
		tween.tween_property(piece, "global_position", end_pos, 1.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		
		# 2. Animate Rotation (in parallel)
		var random_rot = randf_range(-220, 220)
		tween.parallel().tween_property(piece, "rotation_degrees", random_rot, 1.2)

		# 3. Animate Fade Out (in parallel)
		# Start fading a little after the movement begins
		tween.parallel().tween_property(piece, "modulate:a", 0.0, 0.8).set_delay(0.4)
		
		# 4. Clean up the piece after the animation is done
		tween.finished.connect(piece.queue_free)
func goGoGO():
	face.hide()
	textContainer.hide()
	asgoreBody.play("focused")
	playEffect(asgoreSlide)
	wholeBody.move_with_trail(-90,0.5)
	await get_tree().create_timer(0.8).timeout
	asgoreBody.play("spearUnleash")
	await playEffect(asgoreUnleash)
	await get_tree().create_timer(0.5).timeout
	var style_box = StyleBoxFlat.new()
	
# 2. Set its background color. Colors are (Red, Green, Blue, Alpha).
# This example sets it to a semi-transparent blue.
	style_box.bg_color = Color(255,255,255, 1)

# 3. Apply this new stylebox to the "panel" property of your Panel node.
	backgroundColor.add_theme_stylebox_override("panel", style_box)
	asgoreBody.play("sillohuete")
	spear.show()
	playEffect(asgoreSlide)
	wholeBody.move_with_trail(320,1)
	rotate_node(90, 1, spear)
