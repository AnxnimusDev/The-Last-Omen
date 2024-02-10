extends Control


var master_bus = AudioServer.get_bus_index("Master")
onready var test_music = $test_music


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)



func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/main_menu/scenes/MainMenu.tscn")

func _on_Controls_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/settings/scenes/SettingsScreen.tscn")

func _on_HSlider_drag_started():
	test_music.play()


func _on_HSlider_drag_ended(value_changed):
	test_music.stop()
