extends Node


onready var fade_ins= {
	$BlackBackGround : ["color_rect_fade_in","scenescolor_rect_fade_out"],
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func fade_in(node:Control):
	##node.modulate(0,0,0,1)
	node.visible = true
	if(fade_ins.has(node)):
		$AnimationPlayer.play(fade_ins[node][0])
		return true
		pass
	
	return false
	pass
	
func fade_out(node:Control):
	node.visible = false
	if (fade_ins.has(node)):
		$AnimationPlayer.play(fade_ins[node][1])
		return true	
	
	return false

func show_pop_label(message,time = 1.0):
	fade_in($BlackBackGround)
	$PopLabel.text = message
	if not(fade_in($PopLabel)):
		yield(get_tree().create_timer(time),"timeout")
	fade_out($BlackBackGround)
	fade_out($PopLabel)
