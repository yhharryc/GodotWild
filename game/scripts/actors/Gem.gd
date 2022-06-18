extends Area2D

var is_collected = false
signal gem_collected
# Called when the node enters the scene tree for the first time.
func _ready():
	is_collected = false
	owner.connect_gems_to_friends(self)
	$AnimationPlayer.play("idle")
	$AudioStreamPlayer2D.global_position = self.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Gem_body_entered(body):
	if !is_collected:
		emit_signal("gem_collected")
		is_collected = true
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("shatter")
		yield($AnimationPlayer,"animation_finished")
		yield($AudioStreamPlayer2D,"finished")
		queue_free()
	pass # Replace with function body.
