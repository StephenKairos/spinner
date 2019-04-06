extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 200 # Pixels/second
const SPIN = 0.13 # radiants

var speed = 200
var spin_velocity = 0 # radians
var force = Vector2()
var shake_amount = 1.0

onready var scythes = get_node("scythes")
onready var center = get_node("center")

func _physics_process(delta):
	speed *= 0.98
	scythes.rotate(spin_velocity)
	
	var motion = Vector2()
	var initial = Vector2(-1, 0).rotated(scythes.rotation)
	
	if Input.is_action_just_pressed("left"):
		spin_velocity = -1 * SPIN
		force = Vector2(0, 0)
	if Input.is_action_just_pressed("right"):
		spin_velocity = SPIN
		force = Vector2(0, 0)
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		center.set_offset(Vector2( \
	        rand_range(-1.0, 1.0) * shake_amount, \
        	rand_range(-1.0, 1.0) * shake_amount \
    	))
	if Input.is_action_just_released("left") and not Input.is_action_just_released("right"):
		force = initial
		speed = MOTION_SPEED
	if Input.is_action_just_released("right") and not Input.is_action_just_released("left"):
		force = initial * (-1)
		speed = MOTION_SPEED
		
	motion += force
	motion = motion.normalized() * speed

	move_and_slide(motion)