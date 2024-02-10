class_name RegisterScreen
extends Control

onready var create_username_input = get_node("VBoxContainer/Username")
onready var create_userpassword_input = get_node("VBoxContainer/Password")
onready var create_userpassword_repeat_input = get_node("VBoxContainer/Confirm")
onready var confirm_button = get_node("VBoxContainer/RegisterBtn")
onready var back_button = get_node("VBoxContainer/BackBtn")
onready var notification = get_node("VBoxContainer/NotificationLbl")

onready var usernameLB = $VBoxContainer/Username
onready var passLB = $VBoxContainer/Password
onready var confirmLB = $VBoxContainer/Confirm
onready var registerBT = $VBoxContainer/RegisterBtn
onready var backBT = $VBoxContainer/BackBtn

onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

func _ready():
	focus()
	
func focus():
	passLB.grab_focus()
	confirmLB.grab_focus()
	registerBT.grab_focus()
	backBT.grab_focus()
	usernameLB.grab_focus()

func _process(delta):
	move_parallax()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3

func _on_RegisterBtn_pressed():
	notification.modulate = Color(1, 0, 0, 1)
	if create_username_input.get_text() == "":
		notification.text = "Please provide a valid username"
	elif create_userpassword_input.get_text() == "":
		notification.text = "Please provide a valid password"
	elif create_userpassword_repeat_input.get_text() == "":
		notification.text = "Please repeat your password"
	elif create_userpassword_input.get_text() != create_userpassword_repeat_input.get_text():
		notification.text = "Passwords don't match"
	elif create_userpassword_input.get_text().length() <= 5:
		notification.text = "Passwords is too short"
	else:
		confirm_button.disabled = true
		back_button.disabled = true
		var username = create_username_input.get_text()
		var password = create_userpassword_input.get_text()
		notification.modulate = Color(1, 1, 1, 1)
		notification.text = "Verifying..."
		yield(get_tree().create_timer(0.5), "timeout")
		GameServer.registerRequest(username, password)
#		Gateway.is_login = false
#		Gateway.ConnectToServer(username, password, true)

func _on_BackBtn_pressed() -> void:
	get_tree().change_scene("res://gui/screens/main_screen/scenes/MainScreen.tscn")
