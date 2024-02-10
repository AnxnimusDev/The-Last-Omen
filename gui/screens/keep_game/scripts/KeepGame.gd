class_name KeepGamePopUp
extends Node2D

onready var popup = $PopupPanel
onready var yes = $PopupPanel/VBoxContainer/HBoxContainer/YesBtn
onready var no = $PopupPanel/VBoxContainer/HBoxContainer2/NoBtn
# Called when the node enters the scene tree for the first time.
func _ready():
	popup.popup()
	focus()

func focus():
	yes.grab_focus()
	no.grab_focus()

func _on_YesBtn_pressed():
	GAME.delete_game(GAME.file_root)
	get_tree().change_scene("res://gui/screens/char_select/scenes/Char_select.tscn")
	popup.hide()

func _on_NoBtn_pressed():
	get_node("../LoadNewGame").newBT.disabled = false
	get_node("../LoadNewGame").back.disabled = false
	get_node("../LoadNewGame").loadBT.disabled = false
	popup.hide()
