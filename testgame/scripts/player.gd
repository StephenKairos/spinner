extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 200 # Pixels/second
const FIRESPIN = 0.07 # radians
const BUILDSPIN = 0.10 # radians
const RELEASESPIN = 0.30 # radiants
const FRICTION = 0.98
const BUILD_FRICTION = 0.98

var speed = 200
var spin_velocity = 0 # radians
var force = Vector2()
var shake_amount = 1.0

onready var scythes = get_node("scythes")
onready var center = get_node("center")
onready var ball = get_node("ball_sphere")
onready var laser = get_node("laser")
onready var laser_area = laser.get_node("laser_area")
onready var laser_sound = get_node("laser_sound")
onready var direction = get_node("direction")

func _ready():
	pass # ball.play("idle")

func _physics_process(delta):
	var targets = laser_area.get_overlapping_bodies()
	
	speed *= FRICTION
	
	if abs(spin_velocity) > BUILDSPIN:
		spin_velocity *= 0.99
	
	scythes.rotate(spin_velocity)
	direction.rotate(spin_velocity)
	ball.rotate(spin_velocity)
	if not laser.is_playing():
		laser.rotate(spin_velocity)
	
	var motion = Vector2()
	var initial = Vector2(-1, 0).rotated(scythes.rotation)
	
	if Input.is_action_just_pressed("left"):
		direction.play("left")
		spin_velocity = -1 * BUILDSPIN
		#force = Vector2(0, 0)
	if Input.is_action_just_pressed("right"):
		direction.play("right")
		spin_velocity = BUILDSPIN
		#force = Vector2(0, 0)
	if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		if spin_velocity < 0:
			spin_velocity = -1 * FIRESPIN
		else:
			spin_velocity = FIRESPIN
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		speed *= BUILD_FRICTION
		center.set_offset(Vector2( \
	        rand_range(-1.0, 1.0) * shake_amount, \
        	rand_range(-1.0, 1.0) * shake_amount \
    	))
	if Input.is_action_just_released("left") and not Input.is_action_just_released("right"):
		direction.play("idle")
		center.set_offset(Vector2(0, 0))
		force = initial
		speed = MOTION_SPEED
		spin_velocity = -1 * RELEASESPIN
	if Input.is_action_just_released("right") and not Input.is_action_just_released("left"):
		direction.play("idle")
		center.set_offset(Vector2(0, 0))
		force = initial * (-1)
		speed = MOTION_SPEED
		spin_velocity = RELEASESPIN
	if Input.is_action_just_released("left") and Input.is_action_just_released("right"):
		direction.play("idle")
		center.set_offset(Vector2(0, 0))
		laser_sound.play(0)
		laser.play("fire")
		
	for target in targets:
		if target.has_method("death") and laser.is_playing():
			target.death()
	
	motion += force
	motion = motion.normalized() * speed

	move_and_slide(motion)
	
func laser_idle():
	laser.play("idle")
	laser.stop()
	laser_sound.stop()
	laser.rotation = scythes.rotation

func _on_laser_sound_finished():
	print("done")

func _on_laser_area_body_entered(body):
	pass #delete_enemy(body)

func _on_laser_area_body_exited(body):
	pass #delete_enemy(body)

func delete_enemy(body):
	if body.has_method("death") and laser.is_playing():
		body.death()