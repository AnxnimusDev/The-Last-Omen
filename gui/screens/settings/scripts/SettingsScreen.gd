extends Control



onready var _action_list = get_node("Column/ScrollContainer/ActionList")
onready var volume = $Volume
onready var close = $Column/Button

onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

# This function is called when the node is ready to be used
func _ready():
	focus()
	# Connect the "profile_changed" signal of the InputMapper to the "rebuild" function of this node.
# warning-ignore:return_value_discarded
	$InputMapper.connect('profile_changed', self, 'rebuild')
	# Initialize the ProfilesMenu node with the InputMapper node
	$Column/ProfilesMenu.initialize($InputMapper)
	# Change the input profile to the currently selected profile in the ProfilesMenu node
	$InputMapper.change_profile($Column/ProfilesMenu.selected)
	
	
func focus():
	close.grab_focus()
	volume.grab_focus()
# rebuilds the list of input actions based on the given input profile
# If is_customizable is true, the lines are also made clickable and can be changed
func rebuild(input_profile, is_customizable=false):
	# Clear the current list of input actions
	_action_list.clear()
	# For each input action in the input profile...
	for input_action in input_profile.keys():
		# Create a new input line with the action name and key scancod
		var line = _action_list.add_input_line(input_action, \
			input_profile[input_action], is_customizable)
		if is_customizable:
			# Connect its "change_button_pressed" signal to the "_on_InputLine_change_button_pressed" function of this node
			line.connect('change_button_pressed', self, \
				'_on_InputLine_change_button_pressed', [input_action, line])
				
				
# This function is called when the "change_button_pressed" signal is emitted by an input line.
# It opens the KeySelectMenu and waits for the user to select a new key scancode
# Then it changes the input mapper's action key and updates the input line
func _on_InputLine_change_button_pressed(action_name, line):
	# Disable processing of input events
	set_process_input(false)
	# Open the KeySelectMenu and wait for the user to select a new key scancode
	$KeySelectMenu.open()
	# using the yield keyword to pause the execution of the function 
	# until a signal is emitted by the $KeySelectMenu node with the name "key_selected"
	var key_scancode = yield($KeySelectMenu, "key_selected")
	# Change the action key in the input mapper and update the input line
	$InputMapper.change_action_key(action_name, key_scancode)
	line.update_key(key_scancode)
	# Enable processing of input events
	set_process_input(true)

# This function is called when an input event occurs.
# If the "ui_cancel" action is pressed, the main menu scene is loaded.
func _input(event):
	if event.is_action_pressed('ui_cancel'):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://gui/screens/main_menu/scenes/MainMenu.tscn")

# This function is called when the "Button" node is pressed.
# It loads the main menu scene.
func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/main_menu/scenes/MainMenu.tscn")




func _on_Volume_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://gui/screens/settings/scenes/Audio Settings.tscn")
	
func _process(delta):
	move_parallax()

func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3
