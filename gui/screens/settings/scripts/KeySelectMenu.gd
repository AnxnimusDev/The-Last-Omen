extends Panel
# signal that takes one argument: scancode
signal key_selected(scancode)

# This function is called when the node is ready to be used
func _ready():
	# Disable processing of input events by default
	set_process_input(false)

# This function is called when an input event occurs
func _input(event):
	# If the event is not a button press event, exit the function
	if not event.is_pressed():
		return
	# Emit the "key_selected" signal with the scancode of the pressed key
	emit_signal("key_selected", event.scancode)
	# Close the dialog box
	close()
	
# This function shows the dialog box and enables input event processing
func open():
	show()
	set_process_input(true)
	
# This function hides the dialog box and disables input event processing
func close():
	hide()
	set_process_input(false)
