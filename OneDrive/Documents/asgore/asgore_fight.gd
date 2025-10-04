extends Node2D
#Asgore Body
@onready var WholeBody = $AsgoreBody
@onready var Cape = $AsgoreBody/Cape
#Something Else
@onready var asgoreFight = get_node("BackgroundBattle")
@onready var fightBtn = get_node("BackgroundBattle/BattleButtons/FightBtn")
@onready var actBtn = get_node("BackgroundBattle/BattleButtons/ActBtn")
@onready var itemBtn = get_node("BackgroundBattle/BattleButtons/ItemBtn")
@onready var soul = get_node("Soul")
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
@onready var VsAsgore = get_node("BackgroundBattle/VsAsgore")
var fightBtnIco = preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_0.png")
var fightBtnSelIco = preload("res://BattleMenuSprites/spr_fightbt/spr_fightbt_1.png")
var actBtnIco = preload("res://BattleMenuSprites/spr_talkbt/spr_talkbt_0.png")
var actBtnSelIco = preload("res://BattleMenuSprites/spr_talkbt/spr_talkbt_1.png")
var itemBtnIco = preload("res://BattleMenuSprites/spr_itembt/spr_itembt_0.png")
var itemBtnSelIco = preload("res://BattleMenuSprites/spr_itembt/spr_itembt_1.png")
var selectSnd = preload("res://snd/snd_effects/select.wav")
var txtSnd = preload("res://snd/snd_effects/battleBoxTxt.wav")
var battleTexts = [
	"
 * ASGORE ATTACKS"
]
var menuStatus = "base"
var asgoreStats = {
	"hp":3500,
	"chkDef":80,
	"chkAtk":80,
	"trueDef":-30,
	"trueAtk":10
}
var playerHP = 20
func _process(d):
	getPlayerDamage()
func _ready():
	WholeBody.scale = Vector2(1.3, 1.3) 
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
	fightBtn.grab_focus()
	fightBtn.focus_neighbor_left = itemBtn.get_path()
	itemBtn.focus_neighbor_right = fightBtn.get_path()
	displayText(battleTexts[0])

func displayText(text):
	for char in text:
		await get_tree().create_timer(0.02).timeout
		playEffect(txtSnd)
		battleText.text = battleText.text + char

# In asgore_fight.gd
func battleButtonsFocusChanged(t,e): # <--- Check this name!
	t.icon = e
	soul.global_position = t.global_position + Vector2(20,25)
	playEffect(selectSnd)
func selectBtns(t):
	soul.global_position = t.global_position + Vector2(-25,17)
	playEffect(selectSnd)
func playEffect(effect):
	sndEffectPlayer.stream = effect
	sndEffectPlayer.play()

func check_focused_button():
	# 1. Get the currently focused Control node
	var focused_node = get_tree().get_root().gui_get_focus_owner()
	return focused_node

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
			# Check for the Escape key
			if event.keycode == KEY_ESCAPE:
				print("Game menu requested!")

func getPlayerDamage():
	if AttackChoice.global_position  Vector2(301,218):
		print(true)
