extends Panel


var is_locked = true
var index
export(Texture) var lock_pic 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_locked and lock_pic:
		$TextureRect.texture = lock_pic
		$Label.visible = false
	else:
		$TextureRect.visible = false
		$Label.visible = true
		$Label.text = "Level "+String(index+1)
	pass
