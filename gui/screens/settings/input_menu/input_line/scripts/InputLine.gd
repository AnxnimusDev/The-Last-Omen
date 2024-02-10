extends HBoxContainer

signal change_button_pressed
onready var change = $Change
# takes three arguments:
# action_name, key, and can_change
func initialize (action_name, key, can_change):
	
	# Set the text of the Action label to the capitalized version
	# of the given action_name
	$Action.text = action_name.capitalize()
	# Set the text of the Key label to the string representation of the given key
	$Key.text = OS.get_scancode_string(key)
	$Change.disabled = not can_change

# takes one argument:
# scancode
func update_key (scancode):
	# Update the text of the Key label to the string representation
	# of the given scancode
	$Key.text = OS.get_scancode_string(scancode)


# is called
# when the Change button is pressed
func _on_Change_pressed():
	# Emit the "change_button_pressed" signal
	emit_signal('change_button_pressed')
