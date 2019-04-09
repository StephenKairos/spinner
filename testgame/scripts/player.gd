extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 200 # Pixels/second
# const FIRESPIN = 0.07 # radians
const BUILDSPIN = 0.10 # radians
const RELEASESPIN = 0.30 # radiants

var speed = 200
var spin_velocity = 0 # radians
var force = Vector2()
var shake_amount = 1.0

onready var scythes = get_node("scythes")
onready var center = get_node("center")
onready var ball = get_node("ball_sphere")
onready var laser = get_node("laser")

func _ready():
	ball.play("idle")

func _physics_process(delta):
	speed *= 0.99
	
	if abs(spin_velocity) > BUILDSPIN:
		spin_velocity *= 0.99
	
	scythes.rotate(spin_velocity)
	ball.rotate(spin_velocity)
	#if not laser.is_playing():
	laser.rotate(spin_velocity)
	
	var motion = Vector2()
	var initial = Vector2(-1, 0).rotated(scythes.rotation)
	
	if Input.is_action_just_pressed("left"):
		spin_velocity = -1 * BUILDSPIN
		force = Vector2(0, 0)
	if Input.is_action_just_pressed("right"):
		spin_velocity = BUILDSPIN
		force = Vector2(0, 0)
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		center.set_offset(Vector2( \
	        rand_range(-1.0, 1.0) * shake_amount, \
        	rand_range(-1.0, 1.0) * shake_amount \
    	))
	if Input.is_action_just_released("left") and not Input.is_action_just_released("right"):
		center.set_offset(Vector2(0, 0))
		force = initial
		speed = MOTION_SPEED
		spin_velocity = -1 * RELEASESPIN
	if Input.is_action_just_released("right") and not Input.is_action_just_released("left"):
		center.set_offset(Vector2(0, 0))
		force = initial * (-1)
		speed = MOTION_SPEED
		spin_velocity = RELEASESPIN
	if Input.is_action_just_released("left") and Input.is_action_just_released("right"):
		center.set_offset(Vector2(0, 0))
		laser.play("fire")
		
	motion += force
	motion = motion.normalized() * speed

	move_and_slide(motion)
	
func laser_idle():
	laser.play("idle")
	laser.rotation = scythes.rotation