extends KinematicBody2D

export(NodePath) var targetPath
export(int) var record_num = 3
export(float) var min_speed = 5
var target

var velocity
var accel = Vector2()
var target_velocities=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(targetPath)
	
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
		var temp = sum/target_velocities.size() *1.5
		if temp.distance_to(Vector2())<min_speed:
			temp = Vector2()
			pass
		velocity = temp

func modify_direction(velocity:Vector2):
	velocity.x = abs(velocity.x)*get_direction_to_target().x
	return velocity
	pass

func get_vector_to_target():
	return (target.global_position - self.global_position)
	
func get_direction_to_target():
	return get_vector_to_target().normalized()

func _physics_process(delta):
	record_velocity(target.velocity)
	calculate_velocity()
	move_and_slide(velocity)
