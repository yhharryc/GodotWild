extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#time+=1
	#$ShaderLayer.material.set_shader_param("player_position",Vector2(sin(OS.get_unix_time())+cos(OS.get_unix_time()),cos(OS.get_unix_time())+sin(OS.get_unix_time())))
	pass


func _on_TitleScreen_visibility_changed():
	$RainParticle.emitting = self.visible
	
	pass # Replace with function body.
