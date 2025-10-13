extends Node2D
@onready var soul = $Background/Soul
@onready var sndEffectPlayer = $Background/sndEffectPlayer
@onready var normalSelect = $Background/NormalModeSelect
@onready var HardModeSelect = $Background/HardModeSelect
@onready var togoreSelect = $Background/TogoreSelect
@onready var deleteSave = $Background/DeleteSave
@onready var comingSoon = $Background/ComingSoon
@onready var smallShock = $SmallShock
var selectSnd = preload("res://snd/snd_effects/select.wav")
func selectBtns(t):
	soul.global_position = t.global_position + Vector2(-25,20)
	playEffect(selectSnd)
func playEffect(effect):
	sndEffectPlayer.stream = effect
	sndEffectPlayer.play()
func _ready():
	comingSoon.hide()
	smallShock.play()
	normalSelect.connect("focus_entered",Callable(self,"selectBtns").bind(normalSelect))
	normalSelect.connect("focus_exited",Callable(self,"selectBtns").bind(normalSelect))
	HardModeSelect.connect("focus_entered",Callable(self,"selectBtns").bind(HardModeSelect))
	HardModeSelect.connect("focus_exited",Callable(self,"selectBtns").bind(HardModeSelect))
	togoreSelect.connect("focus_entered",Callable(self,"selectBtns").bind(togoreSelect))
	togoreSelect.connect("focus_exited",Callable(self,"selectBtns").bind(togoreSelect))
	deleteSave.connect("focus_entered",Callable(self,"selectBtns").bind(deleteSave))
	deleteSave.connect("focus_exited",Callable(self,"selectBtns").bind(deleteSave))
	normalSelect.grab_focus()
func hardModeSelectClick():
	comingSoon.show()
	await get_tree().create_timer(3).timeout
	comingSoon.hide()
func togoreSelectClick():
	comingSoon.show()
	await get_tree().create_timer(3).timeout
	comingSoon.hide()
func deleteSaveClick():
	save.delete_save_file()
func _input(evt: InputEvent):
	var focBtn = check_focused_button()
	if evt.is_action_pressed("Z") && focBtn == normalSelect:
		playEffect(selectSnd)
		get_tree().change_scene_to_file("res://bergentruckung.tscn")
	elif evt.is_action_pressed("Z") && focBtn == HardModeSelect:
		playEffect(selectSnd)
		hardModeSelectClick()
	elif evt.is_action_pressed("Z") && focBtn == togoreSelect:
		playEffect(selectSnd)
		togoreSelectClick()
	elif evt.is_action_pressed("Z") && focBtn == deleteSave:
		playEffect(selectSnd)
		deleteSaveClick()
func check_focused_button():
	# 1. Get the currently focused Control node
	var focused_node = get_tree().get_root().gui_get_focus_owner()
	return focused_node
