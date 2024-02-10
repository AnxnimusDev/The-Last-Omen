extends Control

const InputLine = preload("res://gui/screens/settings/input_menu/input_line/Scenes/InputLine.tscn")

# clears all child nodes
# by calling the "free" method on each child.
func clear():
	for child in get_children():
		child.free()

#takes three arguments:
# action_name, key, and is_customizable (with a default value of false)
func add_input_line(action_name, key, is_customizable = false):
	# Create a new instance of an InputLine node and initialize it
	# with the given action_name, key, and is_customizable values.
	var line = InputLine.instance()
	line.initialize(action_name, key, is_customizable)
	# Add the new InputLine node as a child of the current node.
	add_child(line)
	# Return the newly created InputLine node.
	return line
