extends Node2D
class_name Level

signal level_cleared(level)

var index
onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("Level "+String(index+1)+" Entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_exited(body):
	if body.name =="Player":
		print_debug("NEXT STAGE")
		emit_signal("level_cleared",self)
	pass # Replace with function body.
