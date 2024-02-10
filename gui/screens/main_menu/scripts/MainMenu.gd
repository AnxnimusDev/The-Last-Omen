extends Node2D
############################################### SCENES ###############################################
onready var main_screen = "res://gui/screens/main_screen/scenes/MainScreen.tscn"
onready var settings_screen = "res://gui/screens/settings/scenes/SettingsScreen.tscn"
onready var level_to_load = "res://gui/screens/load_new_game/scene/LoadNewGame.tscn"
onready var about = "res://gui/screens/credits/scenes/credits.tscn"
onready var leaderboard = "res://gui/screens/scoreboard/scenes/Scoreboard.tscn"
onready var pvp = "res://worlds/local_pvp/char_select_pvp/scenes/CharSelectPVP.tscn"
const DIALOG = preload("res://gui/screens/exit_dialog/scenes/ExitDialog.tscn")

onready  var singleBT= $MarginContainer/VBoxContainer/VBoxContainer/MarginContainer/LocalCampaignBtn
onready  var pvpBT=$MarginContainer/VBoxContainer/VBoxContainer/MarginContainer3/PlayerVsPlayerBtn
onready  var leaderboardBT = $MarginContainer/VBoxContainer/VBoxContainer/MarginContainer8/Leaderboard
onready  var settingsBT = $MarginContainer/VBoxContainer/VBoxContainer/MarginContainer4/SettingsBtn
onready var aboutBT = $MarginContainer/VBoxContainer/VBoxContainer/MarginContainer5/AboutBtn
onready  var exitBT= $MarginContainer/VBoxContainer/VBoxContainer/MarginContainer6/ExitBtn
onready var twitter = $MarginContainer/VBoxContainer/HBoxContainer/Twitter
onready var instagram = $MarginContainer/VBoxContainer/HBoxContainer/Instagram
onready var tiktok = $MarginContainer/VBoxContainer/HBoxContainer/TikTok

onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

# Show the dialog
export var mainGameScene : PackedScene

func _ready():
	focus()
	get_tree().paused = false

func focus():
	pvpBT.grab_focus()
	leaderboardBT.grab_focus()
	settingsBT.grab_focus()
	aboutBT.grab_focus()
	exitBT.grab_focus()
	twitter.grab_focus()
	tiktok.grab_focus()
	instagram.grab_focus()
	singleBT.grab_focus()

# warning-ignore:unused_argument
func _process(delta):
	move_parallax()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3
	
func _on_LocalCampaignBtn_button_up():
	#yield(get_tree().create_timer(2), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene(level_to_load)

func _on_ExitBtn_pressed():
	var dialog = DIALOG.instance()
	get_parent().add_child(dialog)
	dialog.connect("popup_exited", self, "on_dialog_closed")

func _on_LogOutBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(main_screen)


func _on_SettingsBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(settings_screen)

func _on_AboutBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(about)

func _on_PlayerVsPlayerBtn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(pvp)

func _on_Leaderboard_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(leaderboard)

func _on_AboutBtn2_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://twitter.com/TLOTheGame")

func _on_Instagram_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://www.instagram.com/thelastomenproject/")

func _on_TikTok_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://www.tiktok.com/@thelastomengame")

func _on_QUIT_pressed():
	get_tree().quit()
