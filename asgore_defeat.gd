extends Node2D
var asgoreText = [
	"Ah . . .",
	"...",
	"So that
	is how
	it is.",
	"...",
	"I remember the day
after my son
died.
",
"The entire underground
was devoid of hope.",
"The future had once
again been taken
from us by the
humans.",
"In a fit of anger,
I declared war.",
"I said that I would
destroy any human
that came here.",
"I would use their
souls to become
godlike...",
"... and free us from
this terrible prison.",
"Then, I would destroy
humanity...",
"And let monsters rule
the surface, in peace.
",
"Soon, the people's
hopes returned.",
"My wife, however,
became disgusted with
my actions.",
"She left this place,
never to be seen
again.",
"Truthfully. . .",
"I do not want power",
"I do not want to
hurt anyone.",
"I just wanted everyone
to have hope...",
"I cannot take this
any longer.",
"I just want to
see my wife.",
"I just want to
see my child.",
"Please...
Young one...",
"This war has gone
on long enough.",
"You have the power",
"Take my soul, and
leave this cursed
place."
]
var spareText = [
"After everything I
have done to
hurt you...",
"You would rather
stay down here
and suffer...",
"Than live happily
on the surface?",
"Human...",
"I promise you...",
"For as long as
you remain here...",
"My wife and I will
take care of you
as best we can.",
"We can sit in
the living room,
telling stories...",
"Eating butterscotch
pie...",
"We could be
like...",
"Like a family..."
]
@onready var face = $Panel/AsgoreBody/LastFaces
@onready var asgoreTextLabel = $AsgoreText
@onready var dialogueBox = $TalkBox
@onready var sndEff = $sndEff
@onready var chokedup: AudioStreamPlayer2D = $ChokedUp
@onready var battleTextBox = $Panel/BattleTextBox
@onready var soul = $Soul
@onready var fightBtn = $Panel/BattleTextBox/FightBtn
@onready var brokenMercyBtn = $Panel/BattleTextBox/BrokenMercyBtn
@onready var stats = $Panel/Stats
@onready var slashAnim = $Slash
var asgDmg = preload("res://snd/snd_effects/dmg.wav")
var slashSnd = preload("res://snd/snd_effects/slash.wav")
var asgoreWeepFace = preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_6.png")
var currently_hovered_button: Area2D = null
const BTN_TEXTURES = {
	"fight": {
		"normal": preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_0.png"),
		"selected": preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_1.png")
	},
	"mercy": {
		"normal": preload("res://BattleMenuSprites/spr_sparebt_bandage/spr_sparebt_bandage_0.png"),
		"selected": preload("res://BattleMenuSprites/spr_sparebt_bandage/spr_sparebt_bandage_1.png")
	}
}
var memory = preload("res://snd/mus/Memory.wav")
var menuStatus = "asgore"
var spareFaces = [
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_0.png"), # Corresponds to "After everything..."**
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_1.png"), # Corresponds to "You would rather..."**
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_2.png"), # Corresponds to "Than live happily..."**
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_3.png"), # ...and so on**
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_4.png"),
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_5.png"),
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_6.png"),
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_7.png"),
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_8.png"),
	preload("res://AsgoreSprites/AfterBattle/lastFaces/spr_asgore_lastface/spr_asgore_lastface_9.png"),
]
var selectSnd = preload("res://snd/snd_effects/select.wav")
var asgoreVoiceSnd = preload("res://snd/snd_effects/asgoreVoice.wav")
var unskippable = true
func displayTextAsgore(text):
	dialogueBox.show()
	asgoreTextLabel.text = ""
	for char in text:
		asgoreTextLabel.text += char
		if char != " ":
			playEffect(asgoreVoiceSnd)
		if Input.is_action_just_pressed("X") and unskippable == false:
			asgoreTextLabel.text = text
			break # Exit the loop, finishing the typing instantly.
		await get_tree().create_timer(0.09).timeout
func playEffect(eff):
	sndEff.stream = eff
	sndEff.play()
func _process(delta):
	pass
func _ready() -> void:
	_play_dialogue_sequence()
func _input(evt:InputEvent):
	if evt.is_action_pressed("Z"):
		if asgoreTextLabel.text == asgoreText[26]:
			fightBtn.show()
			brokenMercyBtn.show()
			dialogueBox.hide()
			asgoreTextLabel.hide()

			# 2. Resize the battle box to the new height.
			battleTextBox.size.y = 127.0

			# 3. Position the soul in the center of the new box and activate it.
			soul.show()
			soul.global_position = battleTextBox.get_global_rect().get_center()
			
			# Call the function in soul_movement.gd to start player control
			soul.start_soul_control(battleTextBox.get_global_rect())
		if currently_hovered_button != null:
			
			# 3. Figure out which button was pressed and act accordingly.
			if currently_hovered_button.name == "FightBtn":
				playEffect(selectSnd)
				battleTextBox.hide()
				stats.hide()
				slashAnim.play()
				soul.stop_soul_control()
				soul.hide()
				playEffect(slashSnd)
				await slashAnim.animation_finished
				playEffect(asgDmg)
				face.texture = asgoreWeepFace
				await get_tree().create_timer(1).timeout
				get_tree().change_scene_to_file("res://difficultySetting.tscn")
				# Add your code here for what happens when you choose FIGHT.
				
			elif currently_hovered_button.name == "BrokenMercyBtn":
				playEffect(selectSnd)
				battleTextBox.hide()
				stats.hide()
				soul.stop_soul_control()
				soul.hide()
				chokedup.stream = memory
				chokedup.play()
				_play_spare_dialogue()
				print("MERCY button was selected!")
func _play_spare_dialogue():
	# Loop through the spare text array
	for i in range(spareText.size()):
		asgoreTextLabel.show()
		# Display each line of the spare dialogue
		face.texture = spareFaces[1]
		await displayTextAsgore(spareText[i])
		
		# Wait for the player to press Z to advance
		while not Input.is_action_just_pressed("Z"):
			await get_tree().process_frame
			
	# After the spare dialogue finishes, you can add what happens next
	await get_tree().create_timer(1)
	get_tree().change_scene_to_file("res://difficultySetting.tscn")
func _play_dialogue_sequence():
	# Loop through every piece of text in the asgoreText array.
	for i in range(asgoreText.size()):
		# It's unskippable for the first 4 texts (indices 0-3) and skippable after.
		if i == 4:
			chokedUp(false)
			unskippable = false
		
		# Display the current line and wait for the typing effect to finish.
		await displayTextAsgore(asgoreText[i])
		
		# After text is displayed, pause here until the player presses "Z" (ui_accept) to continue.
		while not Input.is_action_just_pressed("Z"):
			await get_tree().process_frame
			
	
func chokedUp(stop:bool):
	if stop == false:
		chokedup.play()
	else:
		chokedup.stop()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "FightBtn":
		fightBtn.texture = BTN_TEXTURES.fight.selected
		currently_hovered_button = area
	elif area.name == "BrokenMercyBtn":
		brokenMercyBtn.texture = BTN_TEXTURES.mercy.selected
		currently_hovered_button = area
		
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "FightBtn":
		fightBtn.texture = BTN_TEXTURES.fight.normal
		currently_hovered_button = null
	elif area.name == "BrokenMercyBtn":
		brokenMercyBtn.texture = BTN_TEXTURES.mercy.normal
		currently_hovered_button = null
