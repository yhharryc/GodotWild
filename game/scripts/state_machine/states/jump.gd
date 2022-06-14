extends "res://game/scripts/state_machine/states/in_air.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func enter():
	self.velocity += Vector2(0,-400)
	pass

func update(_delta):
	
	.update(_delta)
	pass
