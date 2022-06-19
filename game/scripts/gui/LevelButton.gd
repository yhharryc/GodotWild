extends TextureButton

var is_just_pressed = false
var best_score = null
var is_locked = true
var index
export(Texture) var lock_pic 
signal level_selected(index)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _process(delta):
	if is_locked and lock_pic:
		$TextureRect.texture = lock_pic
		$Label.visible = false
		$RecordLabel.visible = false
	else:
		$TextureRect.visible = false
		$Label.visible = true
		$Label.text = "Level "+String(index+1)
		if best_score!=null:
			$RecordLabel.text  = "Best: " + best_score
	pass




func _on_LevelButton_pressed():
	
	if !is_locked &&! is_just_pressed:
		is_just_pressed = true
		emit_signal("level_selected",index)
		print_debug("Level Selected")
		
	pass # Replace with function body.
