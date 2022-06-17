extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.shape = $CollisionShape2D.shape
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "Friend":
		print_debug("Play shattered animation, sound")
		queue_free()
		pass
	pass # Replace with function body.
