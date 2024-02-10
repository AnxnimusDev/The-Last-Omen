class_name LoginScreen
extends Control
######################## LOGIN WITH SERVER #############################
onready var username_input = get_node("VBoxContainer/Username")
onready var userpassword_input = get_node("VBoxContainer/Password")
onready var login_button = get_node("VBoxContainer/LoginBtn") 
onready var back_button = get_node("VBoxContainer/BackBtn")
onready var notification = get_node("VBoxContainer/NotificationLbl")

onready var userLB=$VBoxContainer/Username
onready var passLB=$VBoxContainer/Password
onready var loginBT=$VBoxContainer/LoginBtn


onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

func _ready():
	proces()

func proces():
	userLB.grab_focus()
	passLB.grab_focus()
	loginBT.grab_focus()

# warning-ignore:unused_argument
func _process(delta):
	move_parallax()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3


# Method that is called when the button is pressed
func _on_LoginButton_pressed():
		# If username or password are empty, does nothing
	if username_input.text == "" or userpassword_input.text == "":
		#notification.modulate = Color(0, 1, 0, 1) # verde
		notification.modulate = Color(1, 0, 0, 1) # rojo
		notification.text = "Please write username and password !"
	# Else, 
	else:
		# disables the button LOGIN to don't send more than 1 request
		login_button.disabled = true
		back_button.disabled = true
		notification.modulate = Color(1, 1, 1, 1)
		notification.text = "Verifying..."
		yield(get_tree().create_timer(0.5), "timeout")
		# Gets the wrote username
		var username = username_input.get_text()
		# Gets the wrote  password
		var password = userpassword_input.get_text()
		GameServer.loginRequest(username, password)


func _on_BackBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/main_screen/scenes/MainScreen.tscn")
