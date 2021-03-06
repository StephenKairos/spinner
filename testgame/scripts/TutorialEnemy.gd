extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const SPEED = 100 # pixels/second
const delta = 0.016667

var velocity = Vector2(0, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = velocity.normalized() * SPEED * delta
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()