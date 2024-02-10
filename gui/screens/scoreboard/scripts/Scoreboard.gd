extends Control

onready var line = $CenterContainer/Panel/VBoxContainer/Panel/VBoxContainer/ScrollContainer/HighScores/Line
onready var highscores = $CenterContainer/Panel/VBoxContainer/Panel/VBoxContainer/ScrollContainer/HighScores
onready var returnBT = $CenterContainer/Panel/VBoxContainer/Panel/VBoxContainer/Return

onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

var username = "MarinAndreiCatalin"
var sel_char = "FIREMAN"
var kills = 69
var score = 00100
var index = 1
var data

func _ready():
	focus()
	GameServer.GetScores()
	yield(get_tree().create_timer(4), "timeout")
#	print(GAME.data)
#	print("SIZE: ", GAME.data.size())
	if GAME.data != null:
		for i in GAME.data.size():
			var new  = highscores.get_node("Line").duplicate()
			new.get_node("Index").text = str(index)
			new.get_node("Username").text = str(GAME.data[i].username)

			var path = GAME.data[i].selected_character
			var char_name = path.get_file().get_basename().to_lower()
	
			new.get_node("SelectedChar").text = str(char_name)
			new.get_node("MobsKilled").text = str(GAME.data[i].mobs_killed)
			new.get_node("Score").text = str(GAME.data[i].score)
			new.show()
			highscores.add_child(new)
			index += 1

func focus():
	returnBT.grab_focus()
	
func _process(delta):
	move_parallax()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3
	
func _on_Return_pressed():
	get_tree().change_scene("res://gui/screens/main_menu/scenes/MainMenu.tscn")
