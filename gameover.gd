extends Node2D
@onready var asgoreTalk = $Background/AsgoreText
@onready var asgoreVoiceSpeech = $Background/asgoreVoiceSpeech
@onready var determination = $Background/Determination
@onready var gameoverSprite = $Background/GameOverSprite
@onready var soul = $Background/Soul
var asgoreVoice = preload("res://snd/snd_effects/asgoreVoice.wav")
var heartBreak = preload("res://Extras/spr_heartbreak.png")
var heartBreakSnd = preload("res://snd/snd_effects/heartBreak.wav")
var heartShatterSnd = preload("res://snd/snd_effects/heartShatter.wav")
var shard1 = preload("res://Extras/spr_heartshards/spr_heartshards_0.png")
var shard2 = preload("res://Extras/spr_heartshards/spr_heartshards_1.png")
var shard3 = preload("res://Extras/spr_heartshards/spr_heartshards_2.png")
var shard4 = preload("res://Extras/spr_heartshards/spr_heartshards_3.png")
const GRAVITY = 980.0
var shards = []
var shard_textures = []
var asgoreTexts = [
	"You cannot give
up just yet . . .",
"Chara!                
Stay determined . . ."
]
func create_heart_shatter():
	# Store all the shard textures in an array for easy access
	shard_textures = [shard1, shard2, shard3, shard4]
	
	# Get the soul's position before hiding it
	var spawn_position = soul.position
	soul.hide() # Hide the original soul sprite

	# Create a burst of fragments
	for i in range(10): # Spawn 10 fragments
		var shard = Sprite2D.new()
		# Pick a random texture for this shard
		shard.texture = shard_textures.pick_random()
		shard.position = spawn_position
		
		# Give each shard a random starting velocity and store it
		var random_x = randf_range(-300.0, 300.0)
		var random_y = randf_range(-400.0, -100.0)
		shard.set_meta("velocity", Vector2(random_x, random_y))
		
		# Add the shard to the scene and our array
		$Background.add_child(shard)
		shards.append(shard)
func displayText(text):
	asgoreTalk.text = ""
	for char in text:
		await get_tree().create_timer(0.04).timeout
		if (char != " "):
			playEffect(asgoreVoice)
		asgoreTalk.text = asgoreTalk.text + char
		
func playEffect(effect):
	asgoreVoiceSpeech.stream = effect
	asgoreVoiceSpeech.play()
	
func _ready():
	var newDeaths: int = save.load_game() + 1
	save.save_game(newDeaths)
	gameoverSprite.hide()
	await get_tree().create_timer(0.3).timeout
	soul.texture = heartBreak
	playEffect(heartBreakSnd)
	await get_tree().create_timer(1).timeout
	create_heart_shatter()
	playEffect(heartShatterSnd)
	await get_tree().create_timer(2).timeout
	gameoverSprite.show()
	determination.play()
	displayText(asgoreTexts[0])

func _process(delta):
	if Input.is_action_just_pressed("Z") && asgoreTalk.text == asgoreTexts[0]:
		displayText(asgoreTexts[1])
	elif Input.is_action_just_pressed("Z") && asgoreTalk.text == asgoreTexts[1]:
		displayText("")
	elif Input.is_action_just_pressed("Z") && asgoreTalk.text == "":
		get_tree().change_scene_to_file("res://bergentruckung.tscn")
	for shard in shards:
		# Get the shard's current velocity
		var velocity = shard.get_meta("velocity")
		
		# Apply gravity
		velocity.y += GRAVITY * delta
		
		# Update the shard's position
		shard.position += velocity * delta
		
		# Save the new velocity for the next frame
		shard.set_meta("velocity", velocity)
