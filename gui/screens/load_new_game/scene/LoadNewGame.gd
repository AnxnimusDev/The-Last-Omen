class_name SinglePlayer
extends Node2D

const delete_existant_dialog = preload("res://gui/screens/keep_game/scenes/KeepGame.tscn")
const no_existant_dialog = preload("res://gui/screens/no_game/scenes/NoGame.tscn")

onready var newBT =$MarginContainer/VBoxContainer/VBoxContainer/MarginContainer/New_game
onready var loadBT =$MarginContainer/VBoxContainer/VBoxContainer/MarginContainer2/Load_game
onready var back = $MarginContainer/VBoxContainer/VBoxContainer/MarginContainer3/BackBT

onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4


func _ready():
	loadBT.grab_focus()
	back.grab_focus()
	newBT.grab_focus()

func _process(delta):
	move_parallax()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3

func _on_New_game_pressed():
	if GAME.username == "guest":
		# We create the JSON file in order to save the data of the game.
		var file = File.new()
		#If the file already exists. This must go in the KEEP GAME PANEL 
		if file.file_exists(GAME.file_root):
			var dialog = delete_existant_dialog.instance()
			get_parent().add_child(dialog)
			dialog.connect("popup_exited", self, "on_dialog_closed")
			disableButtons(false)
		else:
			get_tree().change_scene("res://gui/screens/char_select/scenes/Char_select.tscn")
	else:
		checkData()
		yield(get_tree().create_timer(3), "timeout")
		print("ESTADO DEL GAME: ", GAME.data)
		if GAME.data == null or GAME.data.size() < 4:
			print("CHARACTER SELECTION")
			get_tree().change_scene("res://gui/screens/char_select/scenes/Char_select.tscn")
		else:
			var dialog = delete_existant_dialog.instance()
			get_parent().add_child(dialog)
			dialog.connect("popup_exited", self, "on_dialog_closed")
			disableButtons(false)

func _on_Load_game_pressed():
	if GAME.username == "guest":
		var file = File.new()
		#In case the file does not exist..
		if !file.file_exists(GAME.file_root):
			var dialog = no_existant_dialog.instance()
			get_parent().add_child(dialog)
			dialog.connect("popup_exited", self, "on_dialog_closed")
			disableButtons(false)
		else:
			GAME.load_game()
	else: 
		checkData()
		yield(get_tree().create_timer(3), "timeout")
		if GAME.data != null and GAME.data.size() > 3:
			GAME.load_game()
		else:
			var dialog = no_existant_dialog.instance()
			get_parent().add_child(dialog)
			dialog.connect("popup_exited", self, "on_dialog_closed")
			disableButtons(false)

func _on_BackBT_pressed():
	get_tree().change_scene("res://gui/screens/main_menu/scenes/MainMenu.tscn")

# Check if there is a game saved in the server
# Waits 3 seconds to receive the data
func checkData():
	GameServer.LoadPlayerData()
	disableButtons(true)

# Disables or enables the buttons depending of the bool in the parameter
func disableButtons(disabled):
	newBT.disabled = disabled
	back.disabled = disabled
	loadBT.disabled = disabled
