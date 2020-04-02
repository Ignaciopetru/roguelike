extends KinematicBody2D

const MOTION_SPEED = 160 # Pixels/second.
const DASH_SPEED = 2000
const DASH_LENGTH = 200

var is_dash = false
var dash_end
var motion = Vector2()

func _physics_process(_delta):
	
	if(is_dash):
		if(dash_end.distance_to(self.global_position) < 10 or get_slide_collision(0)):
			is_dash = false
		else:
			motion = (dash_end - self.global_position).normalized() * DASH_SPEED
			print(motion)
	if(Input.is_action_just_pressed("saltar")):
		is_dash = true
		var dir = Vector2()
		dir = get_global_mouse_position() - self.global_position
		dir = dir.normalized()
		dash_end = (dir * DASH_LENGTH) +  self.global_position		 
	else:
		if(not(is_dash)):
			motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
			motion.y *= 0.5
			motion = motion.normalized() * MOTION_SPEED
	#warning-ignore:return_value_discarded
	move_and_slide(motion)
