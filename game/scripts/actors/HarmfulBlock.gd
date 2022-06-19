extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HarmfulArea/CollisionShape2D.shape = $CollisionShape2D.shape
	$FriendLockArea/CollisionShape2D.shape = $CollisionShape2D.shape
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HarmfulArea_body_entered(body):
	if body.name =="Player":
		body._on_character_hit(self,body)
	pass # Replace with function body.


func _on_FriendLockArea_body_entered(body):
	if body.name == "Friend":
		print_debug("Play shattered animation, sound")
		$Sprite.visible = false
		$AudioStreamPlayer2D.play()
		$Particles2D.emitting = true
		yield($AudioStreamPlayer2D,"finished")
		queue_free()
	pass
	pass # Replace with function body.
