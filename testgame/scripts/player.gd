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

onready var global = get_node("/root/Global")
onready var scythes = get_node("scythes")
onready var center = get_node("center")
onready var ball = get_node("ball_sphere")
onready var laser = get_node("laser")
onready var laser_area = laser.get_node("laser_area")

onready var laser_timer = get_node("laser_timer")
onready var laser_sound = get_node("laser_sound")
onready var onhit = get_node("hit")

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
		#laser.play("predict")
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
		if laser_timer.is_stopped():
			direction.play("idle")
			#laser_idle()
			center.set_offset(Vector2(0, 0))
			force = initial
			speed = MOTION_SPEED
			spin_velocity = -1 * RELEASESPIN
		else:
			laser_sound.play(0)
			laser.play("fire")
	if Input.is_action_just_released("right") and not Input.is_action_just_released("left"):
		if laser_timer.is_stopped():
			direction.play("idle")
			#laser_idle()
			center.set_offset(Vector2(0, 0))
			force = initial * (-1)
			speed = MOTION_SPEED
			spin_velocity = RELEASESPIN
		else:
			laser_sound.play(0)
			laser.play("fire")
	if Input.is_action_just_released("left") and Input.is_action_just_released("right"):
		direction.play("idle")
		center.set_offset(Vector2(0, 0))
		laser_sound.play(0)
		laser.play("fire")
	if (Input.is_action_just_released("right") and Input.is_action_pressed("left")) or (Input.is_action_just_released("left") and Input.is_action_pressed("right")):
		laser_timer.start(0.75)
	for target in targets: # Kill Target Enemy
		if target.has_method("death") and laser.is_playing():
			target.death()
	
	motion += force
	motion = motion.normalized() * speed

	var collision = move_and_slide(motion)
	
func laser_idle():
	laser.play("idle")
	laser.stop()
	laser_sound.stop()
	laser.rotation = scythes.rotation
	
func hit():
	if not center.is_playing():
		global.player_life -= 1
		center.play("hit")
		scythes.play("hit")
		onhit.play(0)

func _on_center_animation_finished():
	onhit.stop()
	center.play("default")
	scythes.play("default")
	center.stop()
	scythes.stop()

func _on_laser_timer_timeout():
	laser_timer.stop()