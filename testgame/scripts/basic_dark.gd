extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const SPEED = 75 # pixels/second
const delta = 0.016667

var velocity = Vector2(1, 1)

onready var global = get_node("/root/Global")
onready var base = get_node("base")
onready var death = get_node("death")

onready var HUD = preload("res://scenes/HUD.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = velocity.normalized() * SPEED * delta
	base.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
			
func death():
	base.visible = false
	death.visible = true
	velocity = Vector2(0, 0)
	death.play("death")

func _on_death_animation_finished():
	global.player_score += 100
	queue_free()
