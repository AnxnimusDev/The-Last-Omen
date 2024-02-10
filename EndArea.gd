class_name LevelEnd
extends Node2D

################################  NODE REFERENCE ###############################
onready var sprite = $Sprite
onready var area = $End
onready var animation = $AnimationPlayer
onready var end_collision = $End/EndCollision

export var active : bool = true

#func _ready():
#	animation.play("idle")

func _process(_delta):
	if active:
		visible = true
		animation.play("idle")
		end_collision.disabled = false
	else:
		visible = false
		end_collision.disabled = true

# Function that detects when a body enters the area
func _on_End_body_entered(body):
	if body.is_in_group("Player"):
		GAME.advance_level()
		print("YOU HAVE INTERACTED WITH THE END OF THE MAP")
