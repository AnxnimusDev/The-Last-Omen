class_name SinglePlayerIntro
extends NPC
#################################  NODE REFERENCE ##############################
onready var omi = $Omi
onready var omi_animator = $OmiAnimator
onready var screen_animator = $ScreenAnimator
onready var parallax = $ParallaxBackground
onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer2 = $ParallaxBackground/Layer2
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4
onready var parallax_layer5 = $ParallaxBackground/Layer5
onready var skip_button = $SkipButton

#################################### VARIABLES #################################
onready var skipped : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_animator.play("fade_in")
	focus()

func _process(_delta):
	move_parallax()

func focus():
	skip_button.grab_focus()

func start_dialog(timeline_name : String):
	character_dialog = Dialogic.start(timeline_name)
	character_dialog.pause_mode = PAUSE_MODE_PROCESS
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_parent().add_child(character_dialog)
	set_needed_definition_values()
	connect_needed_signals()
	skip_button.visible = false

## Function that sets the values needed for the course of the dialog timeline.
func set_needed_definition_values():
	pass

## Function called by the dialogic_signal emitted from the different character timelines.
# It gets as a parameter the one described in the timelines
# @param event_to_do the changes we wanna do in-game
func dialogic_signal_event(event_to_do : String):
	match event_to_do:
		#TODO: here is the moment were the game is created
		"create_and_start_game":
			pass
		"show_omi":
			omi_animator.play("show_omi")
		"hide_omi":
			omi_animator.play("hide_omi")

func connect_needed_signals():
	character_dialog.connect("dialogic_signal", self, "dialogic_signal_event")
	character_dialog.connect("timeline_end", self, "close_dialog")
	
func move_parallax():
	parallax_layer2.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3
	parallax_layer5.motion_offset.x += 0.4

func _on_ScreenAnimator_animation_finished(anim_name):
	match anim_name:
		## When the fade in animation ends, we start the dialog.
		"fade_in":
			yield(get_tree().create_timer(3), "timeout")
			skip_button.disabled = true
			if !skipped:
				start_dialog("introduction_timeline")
		## When the fade out animation ends, we create the game.
		"fade_out":
			GAME.create_game()

func _on_OmiAnimator_animation_finished(anim_name):
	match anim_name:
		"show_omi":
			omi_animator.play("omi_idle")
		"hide_omi":
			screen_animator.play("fade_out")

func _on_LocalCampaignBtn_pressed():
	skipped = true
	screen_animator.play("fade_out")
