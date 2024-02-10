class_name NoGamePopUp
extends Node2D

onready var popup = $PopupPanel
onready var yes = $PopupPanel/VBoxContainer/HBoxContainer2/YesButton
onready var no = $PopupPanel/VBoxContainer/HBoxContainer/NoButton

# Called when the node enters the scene tree for the first time.
func _ready():
	popup.popup()
	focus()

func focus():
	no.grab_focus()
	yes.grab_focus()
	

func _on_YesButton_pressed():
	get_tree().change_scene("res://gui/screens/char_select/scenes/Char_select.tscn")
	popup.hide()

func _on_NoButton_pressed():
	popup.hide()
