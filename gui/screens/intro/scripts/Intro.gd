class_name Intro
extends Node2D
onready var intro = $"."

onready var parallax_background = $ParallaxBackground
onready var parallax_layer1 = $ParallaxBackground/Layer1
onready var parallax_layer2 = $ParallaxBackground/Layer2
onready var parallax_layer3 = $ParallaxBackground/Layer3
onready var parallax_layer4 = $ParallaxBackground/Layer4

onready var animation = $ScreenAnimations
onready var screen_animations = $ScreenAnimations
onready var title = $OnScreenTextControl/Title
onready var start_message = $OnScreenTextControl/StartMessage
onready var angel = $OnScreenTextControl/Angel

onready var main_screen = "res://gui/screens/log_in_or_guest/scenes/Log_guest.tscn"
var can_pass = false

func _ready():
	screen_animations.play("angel_slide_in")
	can_pass = true
	
# warning-ignore:unused_argument
func _process(delta):
	move_parallax()
	if Input.is_action_just_pressed("ui_accept") and can_pass:
		screen_animations.play("screen_out")
		yield(get_tree().create_timer(1.5), "timeout")
# warning-ignore:return_value_discarded
		get_tree().change_scene(main_screen)
		
func move_parallax():
	parallax_layer1.motion_offset.x += 0.1
	parallax_layer3.motion_offset.x += 0.2
	parallax_layer4.motion_offset.x += 0.3

func _on_ScreenAnimations_animation_finished(anim_name):
	match anim_name:
		"angel_slide_in":
#			title.visible = true
			screen_animations.play("title_fade_in")
		"title_fade_in":
#			start_message.visible = true
			screen_animations.play("blink_text")

# warning-ignore:unused_argument
func _on_ScreenAnimations_animation_started(anim_name):
	pass # Replace with function body.
