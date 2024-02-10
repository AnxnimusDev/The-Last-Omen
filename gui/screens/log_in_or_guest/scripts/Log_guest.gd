class_name LogGuest
extends Control

onready var playGuest = $VBoxContainer/HBoxContainer/PlayGuest
onready var login = $VBoxContainer/HBoxContainer/VBoxContainer/LoginBtn
onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer2 = $ParallaxBackground/Layer2
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

func _ready():
	focus()

func _process(delta):
	move_parallax()

func focus():
	login.grab_focus()
	playGuest.grab_focus()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3

func _on_PlayGuest_pressed():
	GAME.username = "guest"
	get_tree().change_scene("res://gui/screens/main_menu/scenes/MainMenu.tscn")

func _on_LoginBtn_pressed():
	GameServer.ConnectToServer()
	get_tree().change_scene("res://gui/screens/main_screen/scenes/MainScreen.tscn")
