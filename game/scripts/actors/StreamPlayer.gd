extends AudioStreamPlayer2D

var index
signal stream_finished(index)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AudioStreamPlayer2D_finished():
	emit_signal("stream_finished",index)
	pass # Replace with function body.
