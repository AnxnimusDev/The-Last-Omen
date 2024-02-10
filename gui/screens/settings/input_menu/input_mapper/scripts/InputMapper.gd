extends Node
# signal that takes two arguments:
# new_profile and is_customizable
signal profile_changed(new_profile, is_customizable)
# Set the initial value of the "current_profile_id" variable to 0
var current_profile_id = 0
# Define a dictionary called "profiles" that maps profile IDs to profile names
var profiles = {
	0: 'profile_normal',
	1: 'profile_alternate',
	2: 'profile_custom'
}
# Define dictionaries for the three profiles
var profile_normal = {
	'jump' : KEY_W,
	'crouch' : KEY_S,
	'run_right' : KEY_D,
	'run_left' : KEY_A,
	'dash' : KEY_SHIFT,
	'primary_attack' : KEY_K, 
	'secondary_attack' : KEY_L, 
	'transform' : KEY_X
}

var profile_alternate = {
	'jump' : KEY_UP,
	'crouch' : KEY_DOWN,
	'run_right' : KEY_RIGHT,
	'run_left' : KEY_LEFT,
	'dash' : KEY_SHIFT,
	'primary_attack' : KEY_K, 
	'secondary_attack' : KEY_L, 
	'transform' : KEY_X
}
# ulti CICULO
# R2 CORRER
# L2 dash
# R1 L1 transform
# cube combo
# triangulo fuego

#var joystick_custom = {
#	'ulty' : JOY_BUTTON_0,
#	'jump' : JOY_BUTTON_1,
#	'crouch' : JOY_DPAD_DOWN,
#	'run_right' : JOY_DPAD_RIGHT,
#	'run_left' : JOY_DPAD_LEFT,
#	'dash' : JOY_BUTTON_0,
#	'primary_attack' : JOY_BUTTON_2,
#	'secondary_attack' : JOY_BUTTON_3
#}
# Set the initial value of "profile_custom" to be the same as "profile_normal"
var profile_custom = profile_normal

# takes one argument:
# id (the ID of the new profile to switch to)
func change_profile(id):
	# Update the value of "current_profile_id"
	current_profile_id = id
	# Get the dictionary for the new profile
	var profile = get(profiles[id])
	# Set "is_customizable" to true if the profile is "profile_custom", false otherwise
	var is_customizable = true if id == 2 else false
	# Loop through all the actions in the new profile and update their key mappings
	for action_name in profile.keys():
		change_action_key(action_name, profile[action_name])
	# Emit the "profile_changed" signal with the new profile and is_customizable values
	emit_signal('profile_changed', profile, is_customizable)
	# Return the new profile.
	return profile
	
	
# takes two arguments:
# action_name and key_scancode.
func change_action_key(action_name, key_scancode):
	# Remove all events associated with the given action_name
	erase_action_events(action_name)

	var new_event = InputEventKey.new()
	new_event.set_scancode(key_scancode)
	InputMap.action_add_event(action_name, new_event)
	get_selected_profile()[action_name] = key_scancode
#takes one argument:
# action_name.
func erase_action_events(action_name):
	# Get the list of input events associated with the given action
	var input_events = InputMap.get_action_list(action_name)
	# Loop through all the input events and remove them from the InputMap
	for event in input_events:
		InputMap.action_erase_event(action_name, event)

# returns the dictionary
# for the currently selected profile
func get_selected_profile():
	return get(profiles[current_profile_id])

# is called
# when a new profile is selected from the ProfilesMenu node
func _on_ProfilesMenu_item_selected(ID):
	change_profile(ID)
