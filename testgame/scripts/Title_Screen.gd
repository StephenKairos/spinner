extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")
onready var title_music = get_node("title_music")
onready var ball = get_node("ball")

# Called when the node enters the scene tree for the first time.
func _ready():
	title_music.play(0)
	global.reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ball.rotate(0.05)
	if Input.is_action_just_released("left"):
		title_music.stop()
		get_tree().change_scene("res://scenes/level0.tscn")
	if Input.is_action_just_released("right"):
		title_music.stop()
		get_tree().change_scene("res://scenes/countdown.tscn")