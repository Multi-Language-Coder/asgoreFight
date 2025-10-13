extends Node2D
#Asgore Body
@onready var WholeBody = $AsgoreBody
@onready var Cape = $AsgoreBody/Cape
@onready var leftBall = $AsgoreBody/ArmLeftBall
@onready var rightBall = $AsgoreBody/ArmRightBall
@onready var armLeft =$AsgoreBody/ArmLeft
@onready var armRight = $AsgoreBody/ArmRight
@onready var armor = $AsgoreBody/Armor
@onready var dress = $AsgoreBody/Dress
@onready var legs = $AsgoreBody/Legs
@onready var Face = $AsgoreBody/Face
@onready var Feet = $AsgoreBody/Feet
@onready var RightHand = $AsgoreBody/RightHand
@onready var LeftHand = $AsgoreBody/LeftHand
@onready var referenceOscilator = $OscilatingNode
#Something Else
@onready var asgoreFight = get_node("BackgroundBattle")
@onready var fightBtn = get_node("BackgroundBattle/BattleButtons/FightBtn")
@onready var actBtn = get_node("BackgroundBattle/BattleButtons/ActBtn")
@onready var itemBtn =  $BackgroundBattle/BattleButtons/ItemBtn
@onready var soul: AnimatedSprite2D = get_node("Soul")
@onready var sndEffectPlayer = get_node("BackgroundBattle/SndEffectPlay")
@onready var spear = get_node("AsgoreBody/Spear")
@onready var battleText = get_node("BackgroundBattle/BattleText")
@onready var battleTextBox = get_node("BackgroundBattle/BattleTextBox")
@onready var AsgoreSelect = get_node("BackgroundBattle/AsgoreSelect")
@onready var AsgoreName = get_node("BackgroundBattle/AsgoreSelect/AsgoreName")
@onready var AsgoreHealthBar = get_node("BackgroundBattle/AsgoreSelect/AsgoreHealthBar")
@onready var AttackBox = get_node("BackgroundBattle/AttackBox")
@onready var AttackBar = get_node("BackgroundBattle/AttackBox/AttackBar")
@onready var AttackChoice = get_node("BackgroundBattle/AttackBox/AttackChoice")
@onready var Slash = get_node("BackgroundBattle/AttackBox/Slash")
@onready var VsAsgore = get_node("BackgroundBattle/VsAsgore")
@onready var actOptions = get_node("BackgroundBattle/actOptions")
@onready var checkBtn = get_node("BackgroundBattle/actOptions/checkBtn")
@onready var talkBtn = get_node("BackgroundBattle/actOptions/talkBtn")
@onready var itemPage1 = get_node("BackgroundBattle/ItemSelect/Page1")
@onready var itemPage2 = get_node("BackgroundBattle/ItemSelect/Page2")
@onready var ItemSelect = get_node("BackgroundBattle/ItemSelect")
@onready var hpCount = get_node("Stats/HP")
@onready var AsgoreSwiping = get_node("AsgoreBody/AsgoreSwipe")
@onready var AsgoreTridentSwipe = get_node("AsgoreBody/AsgoreSwipe/TridentSwipe")
@onready var hpBar = get_node("Stats/HPBar")
@onready var healEff = get_node("BackgroundBattle/healEff")
@onready var AttackHealth = get_node("BackgroundBattle/AttackBox/AttackHealth")
@onready var digit3 = get_node("AsgoreBody/Digit3")
@onready var digit2 = get_node("AsgoreBody/Digit2")
@onready var digit1 = get_node("AsgoreBody/Digit1")
@onready var sillohuette = $AsgoreBody/Sillohuette
@onready var rightFlash = $AsgoreBody/Sillohuette/RightEye
@onready var leftFlash = $AsgoreBody/Sillohuette/LeftEye
var dmgTaken = 5
var DURATION:float = 1.5
const SPEED: float = 200.0
var attack_box_rect: Rect2
var fireBallStarts = []
var fightBtnIco = preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_0.png")
var fightBtnSelIco = preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_1.png")
var actBtnIco = preload("res://BattleMenuSprites/spr_talkbt/spr_talkbt_0.png")
var actBtnSelIco = preload("res://BattleMenuSprites/spr_talkbt/spr_talkbt_1.png")
var itemBtnIco = preload("res://BattleMenuSprites/spr_itembt/spr_itembt_0.png")
var itemBtnSelIco = preload("res://BattleMenuSprites/spr_itembt/spr_itembt_1.png")
# Add these lines near the top of your script
const PELLET_SPEED: float = 50.0
@onready var hand_texture: Texture2D = preload("res://AsgoreSprites/BattleSprites/spr_handbullet/spr_handbullet_0.png")
@onready var pellet_texture: Texture2D = preload("res://AsgoreSprites/BattleSprites/spr_firebullet/spr_firebullet_0.png")
var selectSnd = preload("res://snd/snd_effects/select.wav")
var txtSnd = preload("res://snd/snd_effects/battleBoxTxt.wav")
var eyeFlashSnd = preload("res://snd/snd_effects/eyeSignals.wav")
var tridentSwipeSnd = preload("res://snd/snd_effects/tridentShow.wav")
var healSnd = preload("res://snd/snd_effects/heal.wav")
var slashSnd = preload("res://snd/snd_effects/slash.wav")
var dmgSnd = preload("res://snd/snd_effects/dmg.wav")
var dmgPlayerSnd = preload("res://snd/snd_effects/playerHurt.wav")
var zero: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_0.png")
var one: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_1.png")
var two: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_2.png")
var three: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_3.png")
var four: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_4.png")
var five: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_5.png")
var six: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_6.png")
var seven: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_7.png")
var eight: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_8.png")
var nine: Texture2D = preload("res://BattleMenuSprites/spr_dmgnum/spr_dmgnum_9.png")
const PELLET_SCRIPT = preload("res://pellet_behavior.gd")

const ATTACK_TIME = 2.0 # Duration of the swipe
const BUTTON_FONT = preload("res://Fonts/determination-mono.otf")
var asgoreStats = {
	"hp":3500,
	"chkDef":80,
	"chkAtk":80,
	"trueDef":-30,
	"trueAtk":10,
	"talkStat":0
}
var battleTexts = [
	"""
 * ASGORE ATTACKS""",
	"""
 * . . .""",
	"""
 * You quietly tell ASGORE you don't want
   to fight him""",
	"""
 * His hands tremble for a moment.""",
"
 * You ate the Pie
 * Your HP was maxed out",
"
 * The smell reminds ASGORE of something...",
"
 * ASGORE' s ATTACK down!
 * ASGORE' s DEFENSE down!",
"""
 * ASGORE """+str(asgoreStats["chkAtk"])+" ATK "+str(asgoreStats["chkDef"])+" DEF",
"
 * You tell ASGORE that you
 don't want to fight him",
"
 * His breathing gets funny
   for a moment",
"
 * You firmly tell ASGORE to
   to STOP fighting.",
"
 * Recollection flashes in his
   eyes . . .",
"
 * ASGORE' s ATTACK dropped!
 * ASGORE' s DEFENSE dropped!",
"
 * Seems talking won't do any
   more good",
"
 * You ate the Face Steak
 * Your HP was maxed out",
'
 * You ate the Legendary Hero
 * Your HP was maxed out',
"
 * You ate the Cinnanom Bunny
 * Your HP was maxed out",
"
 * You tell ASGORE that he's killed you too many times to count.",
"
 * You tell ASGORE that he's
	 killed ",
"
 * He nods "
]

const ATTACK_BOX_SIZE: Vector2 = Vector2(190, 130) 
# Offset: -80 is half of 160 (for X); -60 is half of 120 (for Y). 
# This centers the box relative to the parent (BackgroundBattle at 300, 219).
const ATTACK_BOX_OFFSET: Vector2 = Vector2(-130, -50)
var iteration = 0
var menuStatus = "base"
var itemInv = ["Pie","Face Steak","Leg Hero","Leg Hero1","Leg Hero2","Cinnabun","Cinnabun1", "Cinnabun2"]

const DIRECTION: Vector2 = Vector2(2, 0) # Moves horizontally to the right
var playerHP = 20
const ITEM_POSITIONS: Array[Vector2] = [
	Vector2(50, 10),    # Slot 0: Top Left (Padded from corner)
	Vector2(240, 10),   # Slot 1: Top Right
	Vector2(50, 50),    # Slot 2: Bottom Left
	Vector2(240, 50)    # Slot 3: Bottom Right
]
	
# Track the number of items created for Page 1 slots
var page1_slots_used = 0 
var page1_buttons = [] 
var page2_buttons = []
var page2_first_item: Button = null
var original_pos = Vector2.ZERO
var original_size = Vector2.ZERO
var startingLocation = [Vector2(42.0, 266.5),Vector2(556.0, 266.5)]
var side = false
var deaths = save.load_game()
var turnNum : int = 1
func toWords(num: int):
	match num:
		1:
			return "once"
		2:
			return "twice"
		3:
			return "three times"
		4:
			return "four times"
		5:
			return "five times"
		6:
			return "six times"
		7:
			return "seven times"
		8:
			return "eight times"
		9:
			return "nine times"
func _process(delta:float):
	if playerHP > 20:
		playerHP = 20
	elif playerHP == 0 or playerHP < 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
	AsgoreHealthBar.value = asgoreStats["hp"]
	hpCount.text = str(playerHP)+" / 20"
	hpBar.value = playerHP

	# --- Corrected AttackChoice Logic ---
	if menuStatus == "fight":
		# If the menu status is "fight", MOVE the bar.
		if side == false:
			AttackChoice.global_position += DIRECTION * SPEED * delta
		else: # side == true
			AttackChoice.global_position -= DIRECTION * SPEED * delta
	else:
		# For ALL OTHER statuses, RESET the bar's position.
		if side == false && menuStatus != "flashFight":
			AttackChoice.global_position = startingLocation[0]
		elif side == true && menuStatus != "flashFight":
			AttackChoice.global_position = startingLocation[1]
func _ready():
	VsAsgore.play()
	await get_tree().create_timer(1).timeout
	get_node("stupidPanel").hide()
	animate_body_part($AsgoreBody/Face, 2.0, 1.5)
	animate_body_part($AsgoreBody/Armor, 2.0, 1.5)
	animate_body_part($AsgoreBody/ArmLeft, 2.0, 1.6)
	animate_body_part($AsgoreBody/LeftHand, 2.0, 1.6)
	animate_body_part($AsgoreBody/ArmLeftBall, 2.0, 1.6)
	animate_body_part($AsgoreBody/ArmRight, 2.0, 1.6)
	animate_body_part($AsgoreBody/ArmRightBall, 2.0, 1.6)
	animate_body_part($AsgoreBody/RightHand, 2.0, 1.6)
	animate_body_part($AsgoreBody/Spear, 2.0, 1.6)
	animate_body_part($AsgoreBody/Dress, 2.0,1.6)
	animate_body_part($AsgoreBody/Legs, 2.0,1.6)
	
	AttackChoice.global_position = startingLocation[0]
	original_pos =battleTextBox.global_position
	original_size = battleTextBox.size
	print("Pos:",battleTextBox.global_position)
	print("Size:",battleTextBox.size)
	page1_buttons.clear()
	page2_buttons.clear()
	ItemSelect.position = Vector2(-250, -15) 
	ItemSelect.size = Vector2(500, 100)
	itemPage1.position = Vector2.ZERO
	itemPage2.position = Vector2.ZERO
	itemPage1.size = ItemSelect.size
	itemPage2.size = ItemSelect.size
	"""if page2_first_item and page1_buttons.size() == 4:
		var  top_right_btn = page1_buttons[1]
		top_right_btn.focus_neighbor_right = page2_first_item.get_path()
		var bottom_right_btn = page1_buttons[3]
		bottom_right_btn.focus_neighbor_right = page2_first_item.get_path()"""
	WholeBody.scale = Vector2(1.5, 1.5) 
	
	asgoreFight.play("default")
	Cape.play("default")
	spear.modulate = Color("ff0000")
	fightBtn.connect("focus_entered", Callable(self, "battleButtonsFocusChanged").bind(fightBtn, fightBtnSelIco))
	fightBtn.connect("focus_exited", Callable(self, "battleButtonsFocusChanged").bind(fightBtn, fightBtnIco))
	actBtn.connect("focus_entered", Callable(self, "battleButtonsFocusChanged").bind(actBtn, actBtnSelIco))
	actBtn.connect("focus_exited", Callable(self, "battleButtonsFocusChanged").bind(actBtn, actBtnIco))
	itemBtn.connect("focus_entered", Callable(self, "battleButtonsFocusChanged").bind(itemBtn, itemBtnSelIco))
	itemBtn.connect("focus_exited", Callable(self, "battleButtonsFocusChanged").bind(itemBtn, itemBtnIco))
	AsgoreName.connect("focus_entered",Callable(self,"selectBtns").bind(AsgoreName))
	AsgoreName.connect("focus_exited",Callable(self,"selectBtns").bind(AsgoreName))
	checkBtn.connect("focus_entered",Callable(self,"selectBtns").bind(checkBtn))
	checkBtn.connect("focus_exited",Callable(self,"selectBtns").bind(checkBtn))
	talkBtn.connect("focus_entered",Callable(self,"selectBtns").bind(talkBtn))
	talkBtn.connect("focus_exited",Callable(self,"selectBtns").bind(talkBtn))
	fightBtn.grab_focus()
	fightBtn.focus_neighbor_left = itemBtn.get_path()
	itemBtn.focus_neighbor_right = fightBtn.get_path()
	displayText(battleTexts[0])

func animate_body_part(part: Node2D, move_distance: float, duration: float):
	# Get the Tween node we added as a child of the part.
	var tween = create_tween().bind_node(part)
	var start_pos_y = part.position.y
	
	# Set the tween to loop forever.
	tween.set_loops() 
	# Use SINE for a smooth, natural breathing motion.
	tween.set_trans(Tween.TRANS_SINE) 
	
	# 1. Animate the part moving DOWN.
	tween.tween_property(part, "position:y", start_pos_y + move_distance, duration)
	# 2. Animate the part moving back UP to its starting position.
	tween.tween_property(part, "position:y", start_pos_y, duration)

func replace_all_occurrences(input_string: String, target: String, replacement: String) -> String:
	var new_string: String = input_string.replace(target, replacement)
	return new_string


func set_button_style(button: Button, font_resource: Font, new_size: int):
	button.add_theme_font_size_override("font_size",new_size)
	button.add_theme_font_override("font", font_resource)
	
func clearText():
	battleText.text = ""

func displayText(text):
	battleText.show()
	for char in text:
		await get_tree().create_timer(0.02).timeout
		playEffect(txtSnd)
		battleText.text = battleText.text + char
		if Input.is_key_pressed(KEY_X):
			battleText.text = text
			break
		if Input.is_key_pressed(KEY_Z):
			print("Not gonna work")

# In asgore_fight.gd
func battleButtonsFocusChanged(t,e): # <--- Check this name!
	t.icon = e
	soul.global_position = t.global_position + Vector2(20,32)
	playEffect(selectSnd)
func selectBtns(t):
	soul.global_position = t.global_position + Vector2(-25,20)
	playEffect(selectSnd)
func playEffect(effect):
	sndEffectPlayer.stream = effect
	sndEffectPlayer.play()

func healEffSnd():
	healEff.stream = healSnd
	healEff.play()

func check_focused_button():
	# 1. Get the currently focused Control node
	var focused_node = get_tree().get_root().gui_get_focus_owner()
	return focused_node

func returnDigits(dmg) -> Array[Texture2D]:
	var strDmg = str(dmg)
	var resultArray: Array[Texture2D] = []
	for char in strDmg:
		match char:
			"0":
				resultArray.append(zero)
			"1":
				resultArray.append(one)
			"2":
				resultArray.append(two)
			"3":
				resultArray.append(three)
			"4":
				resultArray.append(four)
			"5":
				resultArray.append(five)
			"6":
				resultArray.append(six)
			"7":
				resultArray.append(seven)
			"8":
				resultArray.append(eight)
			"9":
				resultArray.append(nine)
	return resultArray
	
func startAsgoreLoop():
	var did=false
	prepare_attack_box_smooth()
	await get_tree().create_timer(0.4).timeout
	soul.show()
	soul.global_position = Vector2(260,240)
	var global_attack_box_rect = battleTextBox.get_global_rect()
	soul.start_soul_control(global_attack_box_rect)
	var box_center = battleTextBox.get_rect().get_center()
	box_center.x+=130
	box_center.y+=100
	if iteration == 0 && did == false:
		start_hand_swipe_attack()
		
		iteration+=1
		did = true
	if iteration == 1 && did == false:
		start_hand_swipe_side_attack()
		iteration+=1
		did = true
	if iteration == 2 && did == false:
		swipeAtk(3)
		iteration+=1
		did=true
	if iteration == 3 && did == false:
		fire_burst_attack(referenceOscilator, 15, 120.0,0.4,15)
		iteration=0
		did=true
	#if iteration == 4 && did == false:
	#	fire_ring_implosion(30, 150.0, 100.0, box_center)
	#	did=true
	#	iteration = 0
	#start_fire_rain_attack(5)
	#
	#
	
	await get_tree().create_timer(0.3)
	if iteration == 1:
		print("First Attack")
		
func startPlayerTurn():
	turnNum +=1
	for children in battleTextBox.get_children():
		children.queue_free()
	battleTextBox.z_index = 0
	menuStatus = "base"
	fightBtn.grab_focus()
	battleTextBox.global_position = original_pos
	battleTextBox.size = original_size
	battleText.show()
	clearText()
	displayText(battleTexts[1])
	if turnNum >= 19:
		asgoreStats["trueDef"]-=2
func _input(event):
	# Check if the event is a key press event
	if event is InputEventKey:
		# Check if the key was just pressed down (not held or released)
		if event.pressed and not event.is_echo():
			var focBtn = check_focused_button()
			print(focBtn)
			# Check for a specific key (use the KEY_ constant)
			if event.keycode == KEY_Z and focBtn == fightBtn && menuStatus == "base":
				fightBtn.icon = fightBtnSelIco
				AsgoreSelect.show()
				AsgoreName.grab_focus()
				AsgoreHealthBar.show()
				battleText.hide()
				focBtn.release_focus()
				playEffect(selectSnd)
				menuStatus = "fightCheck"
			elif event.keycode == KEY_X and (menuStatus == "fightCheck" or menuStatus == "actCheck"):
				AsgoreSelect.hide()
				AsgoreHealthBar.hide()
				battleText.show()
				if menuStatus == "fightCheck":
					fightBtn.grab_focus()
				elif menuStatus == "actCheck":
					actBtn.grab_focus()
				menuStatus = "base"
			elif event.keycode == KEY_Z and focBtn == actBtn && menuStatus == "base":
				AsgoreSelect.show()
				AsgoreName.grab_focus()
				battleText.hide()
				focBtn.release_focus()
				playEffect(selectSnd)
				menuStatus = "actCheck"
				actBtn.icon = actBtnSelIco
			elif event.keycode == KEY_Z and focBtn == AsgoreName && menuStatus == "fightCheck":
				
				soul.hide()
				AsgoreSelect.hide()
				AttackBox.show()
				menuStatus = "fight"
			elif event.keycode == KEY_Z and focBtn == AsgoreName && menuStatus == "actCheck":
				menuStatus = "actSelect"
				AsgoreSelect.hide()
				actOptions.show()
				checkBtn.grab_focus()
			elif event.keycode == KEY_Z and focBtn == talkBtn && menuStatus == "actSelect" && asgoreStats["talkStat"]  == 0 && deaths == 0:
				actBtn.icon = actBtnIco
				playEffect(selectSnd)
				actOptions.hide()
				battleText.show()
				soul.hide()
				battleText.text = ""
				displayText(battleTexts[2])
				talkBtn.release_focus()
				asgoreStats["talkStat"]+=1
				actBtn.icon = actBtnIco
				menuStatus = "talking1"
			elif event.keycode == KEY_Z and focBtn == talkBtn && menuStatus == "actSelect" && asgoreStats["talkStat"]  == 0 && deaths > 0 && deaths < 10:
				actBtn.icon = actBtnIco
				playEffect(selectSnd)
				actOptions.hide()
				battleText.show()
				soul.hide()
				battleText.text = ""
				displayText(battleTexts[18] + toWords(deaths) + ".")
				talkBtn.release_focus()
				asgoreStats["talkStat"]+=1
				actBtn.icon = actBtnIco
				menuStatus = "talking1"
			elif event.keycode == KEY_Z and focBtn == talkBtn && menuStatus == "actSelect" && asgoreStats["talkStat"]  == 0 && deaths >= 10:
				actBtn.icon = actBtnIco
				playEffect(selectSnd)
				actOptions.hide()
				battleText.show()
				soul.hide()
				battleText.text = ""
				displayText(battleTexts[17])
				talkBtn.release_focus()
				asgoreStats["talkStat"]+=1
				actBtn.icon = actBtnIco
				menuStatus = "talking1"
			elif event.keycode == KEY_X and (focBtn == checkBtn or focBtn == talkBtn) && menuStatus == "actSelect":
				playEffect(selectSnd)
				actOptions.hide()
				AsgoreSelect.show()
				AsgoreName.grab_focus()
				menuStatus = "actCheck"
			elif event.keycode == KEY_Z and focBtn== checkBtn && menuStatus == "actSelect":
				playEffect(selectSnd)
				soul.hide()
				actOptions.hide()
				clearText()
				displayText(battleTexts[7])
				menuStatus = "asgore"
			elif event.keycode == KEY_Z and battleText.text == battleTexts[7]:
				startAsgoreLoop()
				await get_tree().create_timer(7).timeout
				startPlayerTurn()
			elif event.keycode == KEY_Z && asgoreStats["talkStat"] == 1:
				clearText()
				if deaths <= 4 && deaths != 0:
					displayText(battleTexts[19] + "sadly")
				elif deaths <= 9:
					displayText(battleTexts[19] + "grievously")
				elif deaths >= 10:
					displayText(battleTexts[19] + "pitifully")
				elif deaths == 0:
					displayText(battleTexts[3])
				actBtn.icon = actBtnIco
				menuStatus = "asgore"
				asgoreStats["talkStat"]+=1
			elif event.keycode == KEY_Z && asgoreStats["talkStat"]==2:
				startAsgoreLoop()
				await get_tree().create_timer(7).timeout
				startPlayerTurn()
				
			elif event.keycode == KEY_Z && focBtn == talkBtn && asgoreStats["talkStat"] == 2:
				actBtn.icon = actBtnIco
				soul.hide()
				actOptions.hide()
				clearText()
				displayText(battleTexts[8])
				asgoreStats["talkStat"]+=1
			elif event.keycode ==KEY_Z && asgoreStats["talkStat"] == 3:
				clearText()
				displayText(battleTexts[9])
				asgoreStats["talkStat"]+=1
			elif event.keycode == KEY_Z && battleText.text == battleTexts[9]:
				menuStatus = "asgore"
				startAsgoreLoop()
				await get_tree().create_timer(7).timeout
				startPlayerTurn()
			elif event.keycode == KEY_Z && focBtn == talkBtn && asgoreStats["talkStat"] == 4:
				actBtn.icon = actBtnIco
				soul.hide()
				actOptions.hide()
				clearText()
				displayText(battleTexts[10])
				asgoreStats["talkStat"]+=1
			elif event.keycode == KEY_Z && asgoreStats["talkStat"] == 5:
				clearText()
				displayText(battleTexts[11])
				asgoreStats["talkStat"]+=1
			elif event.keycode == KEY_Z && asgoreStats["talkStat"] == 6:
				clearText()
				displayText(battleTexts[12])
				asgoreStats["trueDef"]-=9
				asgoreStats["talkStat"]+=1
			elif event.keycode == KEY_Z && battleText.text == battleTexts[12]:
				menuStatus = "asgore"
				startAsgoreLoop()
				await get_tree().create_timer(7).timeout
				startPlayerTurn()
			elif event.keycode == KEY_Z && battleText.text == battleTexts[13]:
				menuStatus = "asgore"
				startAsgoreLoop()
				await get_tree().create_timer(7).timeout
				startPlayerTurn()
			elif event.keycode == KEY_Z && asgoreStats["talkStat"] == 7:
				actBtn.icon = actBtnIco
				actOptions.hide()
				soul.hide()
				clearText()
				displayText(battleTexts[13])
			elif event.keycode == KEY_Z and menuStatus == "fight":
				menuStatus="flashFight"
				var dmg = getPlayerDamage()
				var dmgDigits: Array[Texture2D] = returnDigits(dmg)
				var is3 = len(dmgDigits) == 3
				print(dmgDigits)
				AttackChoice.play("selected")
				playEffect(slashSnd)
				Slash.play("slash")
				await get_tree().create_timer(1).timeout
				playEffect(dmgSnd)
				AttackChoice.play("default")
				AttackHealth.show()
				var tween = create_tween()
				var newHealth = int(AttackHealth.value)-dmg
				print(newHealth)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.set_ease(Tween.EASE_IN_OUT)
				if is3:
					digit3.show()
					digit2.show()
					digit1.show()
					digit3.texture =dmgDigits[0]
					digit2.texture  = dmgDigits[1]
					digit1.texture  = dmgDigits[2]
					digit1.modulate = Color("ff0000")
					digit2.modulate = Color("ff0000")
					digit3.modulate = Color("ff0000")
					
				else:
					digit2.show()
					digit1.show()
					digit2.texture  = dmgDigits[0]
					digit1.texture  = dmgDigits[1]
					digit1.modulate = Color("ff0000")
					digit2.modulate = Color("ff0000")
				tween.tween_property(AttackHealth, "value", newHealth, DURATION)
				await tween.finished
				AttackBox.hide()
				menuStatus = "asgore"
				if side == false:
					side = true
				elif side == true:
					side = false
				digit1.hide()
				digit2.hide()
				digit3.hide()
				AttackHealth.hide()
				if asgore_is_defeated:
				# If he's defeated, call a function to handle the ending
					start_asgore_defeat_sequence()
				else:
					# Otherwise, continue the battle normally
					menuStatus = "asgore"
					startAsgoreLoop()
					await get_tree().create_timer(7).timeout
					startPlayerTurn()
				
			if menuStatus == "itemSelect":
				# Define button references using safe checks for clarity
				# P1 = Page 1 (current page)
				var p1_top_right = itemPage1.get_child(1) if itemPage1.get_child_count() > 1 else null
				var p1_bottom_right = itemPage1.get_child(3) if itemPage1.get_child_count() > 3 else null
				# P2 = Page 2 (target page)
				var p2_top_left = itemPage2.get_child(0) if itemPage2.get_child_count() > 0 else null
				var p2_bottom_left = itemPage2.get_child(2) if itemPage2.get_child_count() > 2 else null
				
				
				if event.keycode == KEY_RIGHT:
					if focBtn == p1_top_right:
						# Top Right (P1, Index 1) goes to Top Left (P2, Index 0)
						itemPage1.hide()
						itemPage2.show()
						p2_top_left.grab_focus()
						
					elif focBtn == p1_bottom_right:
						# Bottom Right (P1, Index 3) goes to Bottom Left (P2, Index 2)
						itemPage1.hide()
						itemPage2.show()
						p2_bottom_left.grab_focus()
				
				# --- KEY_LEFT: PAGE 2 (LEFT) -> PAGE 1 (RIGHT) ---
				elif event.keycode == KEY_LEFT:
					if focBtn == p2_top_left:
						# Top Left (P2, Index 0) goes to Top Right (P1, Index 1)
						itemPage2.hide()
						itemPage1.show()
						p1_top_right.grab_focus()   
					elif focBtn == p2_bottom_left:
						itemPage2.hide()
						itemPage1.show()
						p1_bottom_right.grab_focus()
				
				elif event.keycode == KEY_Z:
					soul.hide()
					menuStatus = "asgore"
					ItemSelect.hide()
					itemPage1.show()
					itemPage2.hide()
					if focBtn.name == "Pie":
						playerHP+=90
						clearText()
						displayText(battleTexts[4])
						healEffSnd()
						focBtn.release_focus()
						var pieInd = itemInv.find("Pie")
						rebuild_item_menu() 
						itemInv.remove_at(pieInd)
					elif focBtn.name == "Face Steak":
						healEffSnd()
						playerHP+=60
						clearText()
						displayText(battleTexts[14])
						focBtn.release_focus()
					
					elif focBtn.name.contains("Leg Hero"):
						healEffSnd()
						playerHP+=40
						clearText()
						displayText(battleTexts[15])
						focBtn.release_focus()
					elif focBtn.name.contains("Cinnabun"):
						healEffSnd()
						playerHP+=22
						clearText()
						displayText(battleTexts[16])
						focBtn.release_focus()
				elif event.keycode == KEY_X:
					playEffect(selectSnd)
					menuStatus = "base"
					ItemSelect.hide()
					battleText.show()
					itemBtn.grab_focus()
			elif event.keycode == KEY_Z && (battleText.text == battleTexts[14] or battleText.text == battleTexts[15] or battleText.text == battleTexts[16]):
				startAsgoreLoop()
				await get_tree().create_timer(7).timeout
				startPlayerTurn()
				#focBtn.release_focus()
				
			elif event.keycode == KEY_Z and battleText.text == battleTexts[4]:
				clearText()
				displayText(battleTexts[5])
			elif event.keycode == KEY_Z and battleText.text == battleTexts[5]:
				clearText()
				asgoreStats["trueDef"]-=9
				dmgTaken-=1
				dmgTaken-=1
				displayText(battleTexts[6])
			elif event.keycode == KEY_Z and battleText.text == battleTexts[6]:
				startAsgoreLoop()
				await get_tree().create_timer(7).timeout
				startPlayerTurn()
			
			elif event.keycode == KEY_Z and menuStatus == "base" and focBtn == itemBtn:
				print("works")
				rebuild_item_menu()
				await get_tree().create_timer(0.05).timeout
				battleText.hide()
				ItemSelect.show()
				print(itemPage1.get_child(0))
				itemPage1.get_child(0).grab_focus()
				menuStatus = "itemSelect"
			# Check for the Escape key
			if event.keycode == KEY_ESCAPE:
				print("Game menu requested!")
			#print(focBtn.name)
var basePlayerDmg = 10
var weaponDmg = 99
var totalAtk = basePlayerDmg + weaponDmg
var asgore_is_defeated: bool = false
func getPlayerDamage() -> int:
	var dmg: int = 0
	# --- Damage calculation logic (this part is unchanged) ---
	if AttackChoice.global_position.x > 296 && AttackChoice.global_position.x < 306:
		dmg = round(((basePlayerDmg+weaponDmg)-asgoreStats["trueDef"]+randi_range(1, 2))*2.2)
	else:
		var width: float = AttackBar.get_rect().size.x
		var distanceDifference = abs(AttackChoice.global_position.x-301)
		dmg = round(((basePlayerDmg+weaponDmg)-asgoreStats["trueDef"]+randi_range(1, 2)) * (1 - (distanceDifference/width)) * 2)
	
	# --- NEW LOGIC TO INTERCEPT FATAL DAMAGE ---
	# Check if Asgore's current HP minus the incoming damage would be 1 or less.
	if asgoreStats["hp"] - dmg <= 1 and not asgore_is_defeated:
		# If it's a fatal blow, set his HP to 1 and flag him as defeated.
		asgoreStats["hp"] = 1
		asgore_is_defeated = true
	else:
		# If it's not a fatal blow, subtract damage normally.
		asgoreStats["hp"] -= dmg
		
	return dmg

 
const TWEEN_DURATION: float = 0.4 # Slightly faster transition time

func prepare_attack_box_smooth():
	battleText.hide()
	var container: Panel = battleTextBox
	
	# 1. Create a new Tween object
	var left = create_tween().bind_node(container)
	var right = create_tween().bind_node(container)
	var top = create_tween().bind_node(container)
	var bottom = create_tween().bind_node(container)
	left.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	right.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	top.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bottom.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# 2. Define the new target offsets (The square dimensions)
	var target_left: float = ATTACK_BOX_OFFSET.x
	var target_top: float = ATTACK_BOX_OFFSET.y
	var target_right: float = ATTACK_BOX_OFFSET.x + ATTACK_BOX_SIZE.x
	var target_bottom: float = ATTACK_BOX_OFFSET.y + ATTACK_BOX_SIZE.y

	# 3. Animate the four offset properties simultaneously
	left.tween_property(container, "offset_left", target_left, TWEEN_DURATION)
	top.tween_property(container, "offset_top", target_top, TWEEN_DURATION)
	right.tween_property(container, "offset_right", target_right, TWEEN_DURATION)
	bottom.tween_property(container, "offset_bottom", target_bottom, TWEEN_DURATION)
	container.z_index = 5
	# IMPORTANT: Ensure the panel remains on top of other UI elements
func start_hand_swipe_attack():
	# Use new LOCAL coordinates. The first hand starts just outside the top-left.
	spawn_hand(Vector2(200,120),20,1.5,false)
	# The second hand starts just outside the bottom-right (box width is 190).
	spawn_hand(Vector2(200,20), 20, 1.5,true)
# Replace your existing spawn_hand function with this one

func start_hand_swipe_side_attack():
	const sides = ["top","bottom","right","left"]
	var finalChoice = []
	for i in 5:
		await spawn_hand_side(sides.pick_random())
		
	#spawn_hand_side("left")

func get_center_top_position(node: CanvasItem) -> Vector2:
	# 1. Get the node's global top-left position
	var top_left_global: Vector2 = node.global_position
	
	# 2. Get the node's width
	var width: float = node.get_rect().size.x
	
	# 3. Add half the width to the X coordinate
	var center_top_x = top_left_global.x + (width / 2.0)
	
	# The Y coordinate is the global Y position (the top edge itself)
	var center_top_y = top_left_global.y
	
	return Vector2(center_top_x, center_top_y)

# How high the wave should be.
const WAVE_HEIGHT = 1.0 # in pixel
# IMPORTANT: This assumes WAVE_HEIGHT is defined as a float (the vertical distance).
# DURATION is the total time for the movement.

# IMPORTANT: This assumes WAVE_HEIGHT is defined as a float (the vertical distance).
# DURATION is the total time for the movement.

func spawn_hand(pos: Vector2, wave_height: float, duration: float, top):
	fireBallStarts.clear()
	var hand = Sprite2D.new()
	hand.texture = hand_texture
	hand.z_index = 10
	hand.scale = Vector2(1.4,1.4)
	# Reparenting and positioning the hand (assuming 'pos' is the desired start position relative to battleTextBox)
	battleTextBox.add_child(hand)
	hand.position = pos 
	var pellets_list = []
	hand.set_meta("pellets", pellets_list)
	var start_y = hand.position.y # Get the starting Y position
	if top == true:
		hand.flip_v = true
	var horiz = create_tween().bind_node(hand)
	var vert = create_tween().bind_node(hand)
	# 2. Set the transition type to SINE for a smooth, natural motion.
	vert.set_trans(Tween.TRANS_SINE)
	vert.set_ease(Tween.EASE_IN_OUT) # Smooths both start and end.
	
	# 3. Chain the two movements together.
	# First, move UP by the wave_height (Y decreases in 2D space)
	if top == true:
		horiz.tween_property(hand, "position:x", pos.x-200, duration)
		vert.tween_property(hand, "position:y", start_y + wave_height, duration / 2.0)
		vert.tween_property(hand, "position:y", start_y, duration / 2.0)
	else:
		horiz.tween_property(hand, "position:x", pos.x-200, duration)
		vert.tween_property(hand, "position:y", start_y - wave_height, duration / 2.0)
		vert.tween_property(hand, "position:y", start_y, duration / 2.0)
	var pellet_timer = Timer.new()
	hand.add_child(pellet_timer) # Parent the timer to the hand
	pellet_timer.wait_time = 0.1 # Set the spawn interval to 0.07 seconds
	pellet_timer.one_shot = false # Ensure it repeats continuously
	
	# Connect the timeout signal to the spawning function
	pellet_timer.connect("timeout", Callable(self, "_on_pellet_timer_timeout").bind(hand))
	pellet_timer.start()
	
	await horiz.finished
	pellet_timer.stop()
	
	# Loop through the hand's own private list of pellets
	for pellet in hand.get_meta("pellets"):
		pellet.is_moving = true
	
	#zzhand.queue_free()
var spawnAgain = false
func spawn_hand_side(side):
	var pos = 0
	if side == "top":
		pos = Vector2(10,10)
	elif side == "bottom":
		pos = Vector2(200,120)
	elif side == "right":
		pos = Vector2(200,0)
	elif side =="left":
		pos = Vector2(10,130)
	fireBallStarts.clear()
	var hand = Sprite2D.new()
	hand.texture = hand_texture
	hand.z_index = 10
	hand.scale = Vector2(1.4,1.4)
	# Reparenting and positioning the hand (assuming 'pos' is the desired start position relative to battleTextBox)
	battleTextBox.add_child(hand)
	hand.position = pos 
	var pellets_list = []
	hand.set_meta("pellets", pellets_list)
	var start_y = hand.position.y # Get the starting Y position
	
	if side == "top":
		hand.flip_v = true
		hand.flip_h = true
	elif side == "right":
		hand.rotate(deg_to_rad(270))
	elif side=="left":
		hand.rotate(deg_to_rad(90))
	var horiz = create_tween().bind_node(hand)
	#var vert = create_tween().bind_node(hand)
	# 2. Set the transition type to SINE for a smooth, natural motion.
	
	# 3. Chain the two movements together.
	# First, move UP by the wave_height (Y decreases in 2D space)
	if side == "top":
		horiz.tween_property(hand, "position:x", pos.x+200, 1)
		#vert.tween_property(hand, "position:y", start_y + wave_height, duration / 2.0)
		#vert.tween_property(hand, "position:y", start_y, duration / 2.0)
	elif side == "bottom":
		horiz.tween_property(hand, "position:x", pos.x-200, 1)
	#	vert.tween_property(hand, "position:y", start_y - wave_height, duration / 2.0)
	#	vert.tween_property(hand, "position:y", start_y, duration / 2.0)
	elif side == "right":
		horiz.tween_property(hand, "position:y", pos.y+160, 1)
	elif side == "left":
		horiz.tween_property(hand, "position:y", pos.y-160, 1)
	var pellet_timer = Timer.new()
	hand.add_child(pellet_timer) # Parent the timer to the hand
	pellet_timer.wait_time = 0.1 # Set the spawn interval to 0.07 seconds
	pellet_timer.one_shot = false # Ensure it repeats continuously
	pellet_timer.connect("timeout", Callable(self, "_on_pellet_timer_timeout").bind(hand))
	pellet_timer.start()
	await horiz.finished
	pellet_timer.stop()
	hand.texture = null
	# Loop through the hand's own private list of pellets
	for pellet in hand.get_meta("pellets"):
		if is_instance_valid(pellet):
			pellet.is_moving = true
# New function to rebuild the entire item display
func _on_pellet_timer_timeout(hand_node: Sprite2D):
	# 1. Create the pellet's base, which is an Area2D with the script.
	var pellet_area = PELLET_SCRIPT.new()
	pellet_area.top_level = true
	# 2. Create the visual sprite and add it as a CHILD of the Area2D.
	var pellet_sprite = Sprite2D.new()
	pellet_sprite.texture = pellet_texture
	pellet_sprite.scale = Vector2(1.7, 1.7)
	pellet_area.add_child(pellet_sprite)
	# 3. Create the collision shape and add it as a CHILD of the Area2D.
	var pellet_collision = CollisionShape2D.new()
	pellet_collision.shape = RectangleShape2D.new()
	pellet_collision.shape.size = Vector2(17, 17)
	pellet_area.add_child(pellet_collision)

	# 4. Set the Area2D's properties
	pellet_area.global_position = hand_node.global_position
	pellet_area.z_index = 10
	
	# THIS IS THE FIX: Set the pellet's physics layer to 2 ("enemy_hazards")
	pellet_area.collision_layer = 2 
	
	var direction_to_soul = pellet_area.global_position.direction_to(soul.global_position)
	pellet_area.velocity = direction_to_soul * PELLET_SPEED * 2
	
	var notifier = VisibleOnScreenNotifier2D.new()
	notifier.screen_exited.connect(pellet_area.queue_free)
	pellet_area.add_child(notifier)
	
	# THIS IS THE FIX: Add the Area2D (the actual physics body) to the group.
	pellet_area.add_to_group("asgoreAttacks")
	
	hand_node.add_child(pellet_area)
	hand_node.get_meta("pellets").append(pellet_area)

func rebuild_item_menu():
	for child in itemPage1.get_children():
		child.queue_free()
	for child in itemPage2.get_children():
		child.queue_free()
	ItemSelect.position = Vector2(-250, -15) 
	ItemSelect.size = Vector2(500, 100)
	itemPage1.position = Vector2.ZERO
	itemPage2.position = Vector2.ZERO
	itemPage1.size = ItemSelect.size
	itemPage2.size = ItemSelect.size
	for i in range(len(itemInv)):
		var item = Button.new()
		item.text = " * "+itemInv[i].replace("1","").replace("2","")
		item.name = replace_all_occurrences(itemInv[i],""," ")
		set_button_style(item,BUTTON_FONT, 25)
		item.connect("focus_entered",Callable(self,"selectBtns").bind(item))
		item.connect("focus_exited",Callable(self,"selectBtns").bind(item))
		var pos_index = i % ITEM_POSITIONS.size() 
		if i <= 3:
			item.position=ITEM_POSITIONS[pos_index]
			itemPage1.add_child(item)
			page1_buttons.append(item)
		else:
			item.position = ITEM_POSITIONS[pos_index]
			itemPage2.add_child(item)
			page2_buttons.append(item)
			#if i == 4:
			#	page2_first_item = item
		item.size = Vector2(150,30)
func spawn_fire_pellets():
	print("")

var invincible = false
func _on_soul_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("asgoreAttacks") && invincible == false:
		
		# Apply damage
		handle_player_hit()
		area.queue_free()
		# Delete the pellet that hit the soul
	elif area.is_in_group("asgoreAttacks") && invincible == true:
		area.queue_free()
# Add these two functions to your asgore_fight.gd script
var tridentColor = ""
# This function creates one of the large fireballs that RAINS pellets.
func swipeAtk(numSwipes:int):
	var choices = ["blue","orange"]
	var finalChoices = []
	for i in numSwipes:
		var choice = choices.pick_random()
		finalChoices.append(choice)
	print(finalChoices)
	loadSwipeAtk(finalChoices)
func loadSwipeAtk(choices):
	hideBody()
	sillohuette.show()
	
	# --- Part 1: Eye Flashes (This part was mostly correct) ---
	var is_right_eye = true
	for choice in choices:
		var eye_flash = rightFlash if is_right_eye else leftFlash
		
		if choice == "blue":
			eye_flash.modulate = Color("42e2ff")
		elif choice == "orange":
			eye_flash.modulate = Color("ffa040")
			
		playEffect(eyeFlashSnd)
		eye_flash.play("flash")
		await eye_flash.animation_finished
		eye_flash.play("default")
		
		is_right_eye = not is_right_eye # Flip to the other eye for the next loop

	# --- Part 2: Trident Swipes (This part has been fixed) ---
	sillohuette.hide()
	AsgoreSwiping.show()
	AsgoreTridentSwipe.show()
	
	var is_forward_swipe = true
	for choice in choices:
		# Set the trident color
		if choice == "blue":
			AsgoreTridentSwipe.modulate = Color("42e2ff")
			tridentColor = "blue"
		elif choice == "orange":
			AsgoreTridentSwipe.modulate = Color("ffa040")
			tridentColor = "orange"
		
		playEffect(tridentSwipeSnd)
		
		# Use a simple if/else for the animation direction
		if is_forward_swipe:
			AsgoreSwiping.play("Swiping")
			AsgoreTridentSwipe.play("TridentSwipe")
		else:
			AsgoreSwiping.play_backwards("Swiping")
			AsgoreTridentSwipe.play_backwards("TridentSwipe")
			
		await AsgoreSwiping.animation_finished
		
		is_forward_swipe = not is_forward_swipe # Flip the direction for the next swipe

	# --- Part 3: Cleanup (Moved outside the loop) ---
	# This code now runs AFTER all swipes are finished.
	AsgoreSwiping.hide()
	AsgoreTridentSwipe.hide()
	showBody()
func _on_soul_hitbox_area_exited(area: Area2D) -> void:
	if area.name == "Enemy":
		print("Enemy has left the range.")
func hideBody():
	Cape.hide()
	leftBall.hide()
	armLeft.hide()
	armRight.hide()
	armor.hide()
	dress.hide()
	legs.hide()
	Face.hide()
	Feet.hide()
	rightBall.hide()
	spear.hide()
	RightHand.hide()
	LeftHand.hide()
func showBody():
	Cape.show()
	leftBall.show()
	armLeft.show()
	armRight.show()
	armor.show()
	dress.show()
	legs.show()
	Face.show()
	Feet.show()
	rightBall.show()
	spear.show()
	RightHand.show()
	LeftHand.show()


func _on_asgore_swipe_frame_changed() -> void:
	#print(AsgoreSwiping.frame == 5 or AsgoreSwiping.frame == 6)
	var is_damage_frame = AsgoreSwiping.frame in [5, 6]
	if not is_damage_frame:
		return

	# Determine if the player should take damage based on the color and movement.
	var should_take_damage = (
		(soul.velocity != Vector2.ZERO and tridentColor == "blue") or
		(soul.velocity == Vector2.ZERO and tridentColor == "orange")
	)

	if should_take_damage:
		handle_player_hit()
func oscilatingFireBalls(fireSpeed):
	var oscilatingNodeBase = Node2D.new()
	oscilatingNodeBase.position=Vector2(0,0)
func fire_burst_attack(emitter_node: Node2D, num_projectiles: int, speed: float, timeBetween:float, numTimes:int):
	# TAU is a built-in Godot constant for a full circle (2 * PI).
	# We divide the circle by the number of projectiles to find the angle between each one.
	var angle_step = TAU / num_projectiles
	var oscilator = get_tree().create_tween()
	oscilator.finished.connect(returnOscilator)
	oscilator.tween_property(referenceOscilator,"position:x",300,6)
	# Loop to create each projectile.
	for j in numTimes:
		for i in range(num_projectiles):
			# Calculate the angle for this specific projectile.
			var current_angle = i * angle_step

			# Create a direction vector by rotating a base vector (Vector2.RIGHT).
			var direction = Vector2.RIGHT.rotated(current_angle)

			# --- Pellet Creation (Copied and adapted from your _on_pellet_timer_timeout) ---

			# 1. Create the pellet's base from your script.
			var pellet_area = PELLET_SCRIPT.new()

			# 2. Create the visual sprite.
			var pellet_sprite = Sprite2D.new()
			pellet_sprite.texture = pellet_texture
			pellet_sprite.scale = Vector2(1.7, 1.7)
			pellet_area.add_child(pellet_sprite)

			# 3. Create the collision shape.
			var pellet_collision = CollisionShape2D.new()
			pellet_collision.shape = RectangleShape2D.new()
			pellet_collision.shape.size = Vector2(17, 17)
			pellet_area.add_child(pellet_collision)

			# 4. Set the pellet's properties.
			pellet_area.global_position = emitter_node.global_position # Start at the emitter's position
			pellet_area.velocity = direction * speed # Use the calculated direction and speed
			pellet_area.is_moving = true # Make sure it starts moving immediately
			pellet_area.z_index = 10
			pellet_area.collision_layer = 2
			pellet_area.add_to_group("asgoreAttacks")

			# 5. Add the cleanup notifier.
			var notifier = VisibleOnScreenNotifier2D.new()
			notifier.screen_exited.connect(pellet_area.queue_free)
			pellet_area.add_child(notifier)
			
			# 6. Add the pellet to the battle area.
			battleTextBox.add_child(pellet_area)
		await get_tree().create_timer(timeBetween).timeout
func returnOscilator():
	referenceOscilator.position = Vector2(-107,-107)
func fire_ring_implosion(num_projectiles: int, radius: float, speed: float, center_point: Vector2):
	# TAU is a full circle in radians. We divide it to space the pellets evenly.
	var box_center = battleTextBox.get_rect().get_center()
	var angle_step = TAU / num_projectiles

	for i in range(num_projectiles):
		# 1. Calculate the spawn position for this pellet
		var angle = i * angle_step
		# Get a direction vector pointing OUT from the center
		var outward_direction = Vector2.RIGHT.rotated(angle)
		var spawn_position = center_point + (outward_direction * radius)

		# 2. Calculate the velocity
		# The direction is simply from the spawn position TOWARDS the center point
		var inward_direction = spawn_position.direction_to(center_point)
		
		# --- Create and Configure the Pellet (based on your existing code) ---
		var pellet_area = PELLET_SCRIPT.new()
		var pellet_sprite = Sprite2D.new()
		pellet_sprite.texture = pellet_texture
		pellet_sprite.scale = Vector2(1.7, 1.7)
		pellet_area.add_child(pellet_sprite)

		var pellet_collision = CollisionShape2D.new()
		pellet_collision.shape = RectangleShape2D.new()
		pellet_collision.shape.size = Vector2(17, 17)
		pellet_area.add_child(pellet_collision)

		pellet_area.global_position = spawn_position
		pellet_area.velocity = inward_direction * speed # Set its inward velocity
		pellet_area.is_moving = true # Start moving immediately
		pellet_area.z_index = 10
		pellet_area.collision_layer = 2
		pellet_area.add_to_group("asgoreAttacks")

		var notifier = VisibleOnScreenNotifier2D.new()
		notifier.screen_exited.connect(pellet_area.queue_free)
		pellet_area.add_child(notifier)
		
		battleTextBox.add_child(pellet_area)
func handle_player_hit():
	# 1. Don't do anything if the player is already invincible.
	if invincible:
		return

	# 2. If player HP is 1, the next hit is fatal.
	if playerHP == 1:
		playerHP = 0
		# Your _process function will now handle the game over.
		return

	# 3. Calculate the potential HP after taking damage.
	var potential_hp = playerHP - dmgTaken

	# 4. Check if the hit would be fatal.
	if potential_hp <= 0:
		# If so, set HP to 1 instead of killing the player.
		playerHP = 1
	else:
		# Otherwise, take damage normally.
		playerHP -= dmgTaken

	# 5. Play sound and start invincibility frames.
	playEffect(dmgPlayerSnd)
	invincible = true
	soul.play("InvincibilityFrames")
	await get_tree().create_timer(1).timeout
	soul.play('default')
	invincible = false
func start_asgore_defeat_sequence():
	get_tree().change_scene_to_file("res://asgore_defeat.tscn")
