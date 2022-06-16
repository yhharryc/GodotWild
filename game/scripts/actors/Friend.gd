extends KinematicBody2D

export(NodePath) var targetPath
export(int) var record_num = 3
export(float) var min_speed = 15
var target
export(float) var speed_param = 2
var is_fading_in setget set_is_fading_in,get_is_fading_in
var is_fading_out setget set_is_fading_out,get_is_fading_out
var velocity = Vector2()
var accel = Vector2()
var target_velocities=[]
var is_hurtful = true
#export (float ) var current_alpha  setget set_current_alpha, get_current_alpha  

signal fully_shown
signal fully_invisible
signal hit_character(source,character)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$HurtArea/CollisionShape2D.shape = $CollisionShape2D.shape
	#self.current_alpha = 0
	target = get_node(targetPath)
	target.connect("friend_spotted",self,"_on_player_spotted_self")
	target.connect("friend_exited",self,"_on_exited_player_view")
	connect("hit_character",target,"_on_character_hit")
	
	pass # Replace with function body.

func record_velocity(velocity:Vector2):
	if target_velocities.size()<record_num:
		target_velocities.append(velocity)
	else:
		target_velocities.erase(0)
		target_velocities.append(velocity)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func calculate_velocity():
	if target_velocities.size()>0:
		var sum = Vector2()
		for i in range(target_velocities.size()):
			sum+=modify_direction(target_velocities[i])
		var temp = sum/target_velocities.size() *speed_param
		if temp.distance_to(Vector2())<min_speed:
			temp = Vector2()
			pass
		# if accel and velocity are in different direction, adjust to accel
		accel = temp
		if sign(accel.x)!=sign(velocity.x):
			
			self.modulate = Color(1,0,0)
			var adjustion = 0.005
			#lerp(velocity.x,0,adjustion)
			accel= accel*(1+get_vector_to_target().distance_to(Vector2())*adjustion)
		else:
			self_modulate =  Color(0,0,0)
		


func modify_direction(velocity:Vector2):
	velocity.x = abs(velocity.x)*get_direction_to_target().x
	velocity.y = abs(velocity.y)*get_direction_to_target().y
	return velocity
	pass

func get_vector_to_target():
	return (target.global_position - self.global_position)
	
func get_direction_to_target():
	return get_vector_to_target().normalized()

func _physics_process(delta):
	adjust_alpha()
	record_velocity(target.applied_velocity)
	calculate_velocity()
	velocity +=accel*delta
	velocity.y = get_vector_to_target().y
	if accel == Vector2():
		velocity = lerp(velocity,Vector2(),0.5)
	move_and_slide(velocity)

func _on_player_spotted_self(player,friend):
	fade_in()
	yield(self,"fully_shown")
	set_physics_process(false)
	pass
	
func _on_exited_player_view(player,friend):
	set_physics_process(true)
	fade_out()

	pass

#func get_current_alpha():
#	return $Sprite.modulate.a
#	pass
#
#func set_current_alpha(value):
#	current_alpha = value
#	$Sprite.modulate.a = value

func fade_in():
	self.is_fading_in = true
	pass

func fade_out():
	self.is_fading_out = true

func adjust_alpha():
	var alpha = $Sprite.modulate.a8
	if is_fading_in:
		$Sprite.modulate.a8 = lerp($Sprite.modulate.a8,255,0.4)
		if $Sprite.modulate.a8 >=250:
			emit_signal("fully_shown")
	if is_fading_out:
		$Sprite.modulate.a8 = lerp($Sprite.modulate.a8,0,0.5)
		if $Sprite.modulate.a8 <=1:
			emit_signal("fully_invisible")
	
	pass
	
func set_is_fading_in(value):
	if value:
		is_fading_out = false
	is_fading_in = value
	pass
func get_is_fading_in():
	return is_fading_in
	pass

func set_is_fading_out(value):
	if value:
		is_fading_in = false
	is_fading_out = value
	pass
func get_is_fading_out():
	return is_fading_out
	pass


func _on_Friend_fully_shown():
	print("FULLY SHOWN")
	is_fading_in = false
	pass # Replace with function body.


func _on_Friend_fully_invisible():
	print("FULLY INVISIBLE")
	is_fading_out = false
	pass # Replace with function body.


func _on_HurtArea_body_entered(body):
	if body == target&&is_hurtful:
		emit_signal("hit_character",self,body)
		
	pass # Replace with function body.
