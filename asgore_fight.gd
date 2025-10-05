extends Node2D
#Asgore Body
@onready var WholeBody = $AsgoreBody
@onready var Cape = $AsgoreBody/Cape
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
@onready var hpBar = get_node("Stats/HPBar")
@onready var healEff = get_node("BackgroundBattle/healEff")
@onready var AttackHealth = get_node("BackgroundBattle/AttackBox/AttackHealth")
@onready var digit3 = get_node("AsgoreBody/Digit3")
@onready var digit2 = get_node("AsgoreBody/Digit2")
@onready var digit1 = get_node("AsgoreBody/Digit1")
var DURATION:float = 1.5
const SPEED: float = 200.0
var attack_box_rect: Rect2
var fightBtnIco = preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_0.png")
var fightBtnSelIco = preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_1.png")
var actBtnIco = preload("res://BattleMenuSprites/spr_talkbt/spr_talkbt_0.png")
var actBtnSelIco = preload("res://BattleMenuSprites/spr_talkbt/spr_talkbt_1.png")
var itemBtnIco = preload("res://BattleMenuSprites/spr_itembt/spr_itembt_0.png")
var itemBtnSelIco = preload("res://BattleMenuSprites/spr_itembt/spr_itembt_1.png")
var selectSnd = preload("res://snd/snd_effects/select.wav")
var txtSnd = preload("res://snd/snd_effects/battleBoxTxt.wav")
var healSnd = preload("res://snd/snd_effects/heal.wav")
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
const HAND_SCENE = preload("res://asgore_hand.tscn")
const PELLET_SCENE = preload("res://fire_pellet.tscn")
const ATTACK_TIME = 2.0 # Duration of the swipe
const BUTTON_FONT = preload("res://Fonts/determination-mono.otf")
var battleTexts = [
	"""
 * ASGORE ATTACKS""",
	"""
 * . . .""",
	"""
 * You quietly tell ASGORE you don't want
   to fight him""",
	"""
 * His hands tremble for a moment."""
]
var iteration = 1
var menuStatus = "base"
var itemInv = ["Pie","Face Steak","Leg Hero","Leg Hero1","Leg Hero2","Cinnabun","Cinnabun1", "Cinnabun2"]
var asgoreStats = {
	"hp":3500,
	"chkDef":80,
	"chkAtk":80,
	"trueDef":-30,
	"trueAtk":10,
	"talkStat":0
}
const DIRECTION: Vector2 = Vector2(2, 0) # Moves horizontally to the right
var playerHP = 1
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
func _process(delta:float):
	if playerHP > 20:
		playerHP = 20
	AsgoreHealthBar.value = asgoreStats["hp"]
	hpCount.text = str(playerHP)+" / 20"
	hpBar.value = playerHP
	if menuStatus == "fight":
		AttackChoice.global_position += DIRECTION * SPEED * delta

func _ready():
	page1_buttons.clear()
	page2_buttons.clear()
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
	"""if page2_first_item and page1_buttons.size() == 4:
		var  top_right_btn = page1_buttons[1]
		top_right_btn.focus_neighbor_right = page2_first_item.get_path()
		var bottom_right_btn = page1_buttons[3]
		bottom_right_btn.focus_neighbor_right = page2_first_item.get_path()"""
	WholeBody.scale = Vector2(1.5, 1.5) 
	VsAsgore.play()
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
func _input(event):
	# Check if the event is a key press event
	if event is InputEventKey:
		# Check if the key was just pressed down (not held or released)
		if event.pressed and not event.is_echo():
			var focBtn = check_focused_button()
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
			elif event.keycode == KEY_Z and focBtn == talkBtn && menuStatus == "actSelect" && asgoreStats["talkStat"]  == 0:
				playEffect(selectSnd)
				actOptions.hide()
				battleText.show()
				battleText.text = ""
				displayText(battleTexts[2])
				talkBtn.release_focus()
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
				displayText("""
				 * ASGORE """+str(asgoreStats["chkAtk"])+" ATK "+str(asgoreStats["chkDef"])+" DEF")
				menuStatus = "asgoreCheck"
			elif event.keycode == KEY_Z && menuStatus == "talking1":
				clearText()
				displayText(battleTexts[3])
				actBtn.icon = actBtnIco
				menuStatus = "asgore"
			elif event.keycode == KEY_Z and menuStatus == "fight":
				menuStatus = "asgore"
				var dmg = getPlayerDamage()
				var dmgDigits: Array[Texture2D] = returnDigits(dmg)
				var is3 = len(dmgDigits) == 3
				print(dmgDigits)
				AttackChoice.play("selected")
				Slash.play("slash")
				await get_tree().create_timer(1).timeout
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
				digit1.hide()
				digit2.hide()
				digit3.hide()
				AttackHealth.hide()
				soul.show()
				soul.global_position = Vector2(250,250)
				prepare_attack_box_smooth()
				const BOX_X = ATTACK_BOX_OFFSET.x
				const BOX_Y = ATTACK_BOX_OFFSET.y
				const BOX_WIDTH = ATTACK_BOX_SIZE.x
				const BOX_HEIGHT = ATTACK_BOX_SIZE.y
				var global_attack_box_rect = battleTextBox.get_global_rect()
				var attack_rect: Rect2 = Rect2(
					BOX_X,
					BOX_Y,
					BOX_WIDTH,
					BOX_HEIGHT
				)
				await get_tree().create_timer(2).timeout
				soul.start_soul_control(global_attack_box_rect)
				soul.global_position = global_attack_box_rect.get_center()
				start_hand_swipe_attack()
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
					itemPage1.hide()
					itemPage2.hide()
					if focBtn.name == "Pie":
						playerHP+=90
						clearText()
						displayText("
						 * You ate the Pie
						 * Your HP was maxed out")
						healEffSnd()
					elif focBtn.name == "Face Steak":
						healEffSnd()
						playerHP+=60
						clearText()
						displayText("
						 * You ate the Faces Steak
						 * Your HP was maxed out")
					elif focBtn.name.contains("Leg Hero"):
						healEffSnd()
						playerHP+=40
						clearText()
						displayText("
						 * You ate the Legendary Hero
						 * Your HP was maxed out")
					elif focBtn.name.contains("Cinnabun"):
						healEffSnd()
						playerHP+=22
						clearText()
						displayText("
						 * You ate the Cinnanom Bunny
						 * Your HP was maxed out")
					#elif focBtn
				
				elif event.keycode == KEY_X:
					playEffect(selectSnd)
					menuStatus = "base"
					ItemSelect.hide()
					battleText.show()
					itemBtn.grab_focus()
			elif event.keycode == KEY_Z and menuStatus == "base" and focBtn== itemBtn:
				print("works")
				battleText.hide()
				ItemSelect.show()
				itemPage1.get_child(0).grab_focus()
				menuStatus = "itemSelect"				
			# Check for the Escape key
			if event.keycode == KEY_ESCAPE:
				print("Game menu requested!")
			#print(focBtn.name)
func getPlayerDamage() -> int:
	var dmg: int = 0
	if AttackChoice.global_position.x > 296 && AttackChoice.global_position.x < 306:
		dmg = round((25-asgoreStats["trueDef"]+randi_range(1, 2))*2.2)
		asgoreStats["hp"]-=dmg
	else:
		var width: float = AttackBar.get_rect().size.x
		var distanceDifference = abs(AttackChoice.global_position.x-301)
		dmg = round((25-asgoreStats["trueDef"]+randi_range(1, 2)) * (1 - (distanceDifference/width)) * 2)
		asgoreStats["hp"]-=dmg
	return dmg

const ATTACK_BOX_SIZE: Vector2 = Vector2(190, 130) 
# Offset: -80 is half of 160 (for X); -60 is half of 120 (for Y). 
# This centers the box relative to the parent (BackgroundBattle at 300, 219).
const ATTACK_BOX_OFFSET: Vector2 = Vector2(-130, -50) 
const TWEEN_DURATION: float = 0.4 # Slightly faster transition time

func prepare_attack_box_smooth():
	battleText.hide()
	var container: PanelContainer = battleTextBox
	
	# 1. Create a new Tween object
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# 2. Define the new target offsets (The square dimensions)
	var target_left: float = ATTACK_BOX_OFFSET.x
	var target_top: float = ATTACK_BOX_OFFSET.y
	var target_right: float = ATTACK_BOX_OFFSET.x + ATTACK_BOX_SIZE.x
	var target_bottom: float = ATTACK_BOX_OFFSET.y + ATTACK_BOX_SIZE.y

	# 3. Animate the four offset properties simultaneously
	tween.tween_property(container, "offset_left", target_left, TWEEN_DURATION)
	tween.tween_property(container, "offset_top", target_top, TWEEN_DURATION)
	tween.tween_property(container, "offset_right", target_right, TWEEN_DURATION)
	tween.tween_property(container, "offset_bottom", target_bottom, TWEEN_DURATION)
	
	# IMPORTANT: Ensure the panel remains on top of other UI elements
	container.z_index = 5 

func start_hand_swipe_attack():
	spawn_hand(Vector2(-100,-100),1)
	await get_tree().create_timer(0.2).timeout
	spawn_hand(Vector2(460, 150), -1)	
func spawn_hand(start_pos: Vector2, direction: float):
	var hand = HAND_SCENE.instantiate()
	$BackgroundBattle/AttackBox.add_child(hand)
	hand.global_position = start_pos
	hand.start_movement_and_spawn(ATTACK_TIME, direction, PELLET_SCENE)
