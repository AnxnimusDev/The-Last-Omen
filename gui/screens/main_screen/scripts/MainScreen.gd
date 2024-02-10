class_name MainScreen
extends Control

onready var registerBT = $VBoxContainer/HBoxContainer/RegisterBtn
onready var loginBT = $VBoxContainer/HBoxContainer/LoginBtn

onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

func _ready():
	focus()

# warning-ignore:unused_argument
func _process(delta):
	move_parallax()

func focus():
#	guest.grab_focus()
	registerBT.grab_focus()
	loginBT.grab_focus()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3

func _on_RegisterBtn_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/register/scenes/RegisterScreen.tscn")

	#Change scene to Login
func _on_LoginBtn_pressed() -> void:	
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/login/scenes/LoginScreen.tscn")


func _on_Button_pressed():
	GAME.username = "guest"
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/main_menu/scenes/MainMenu.tscn")
