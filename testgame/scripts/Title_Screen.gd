extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var title_music = get_node("title_music")

# Called when the node enters the scene tree for the first time.
func _ready():
	title_music.play(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("left"):
		title_music.stop()
		get_tree().change_scene("res://scenes/level0.tscn")
	if Input.is_action_just_released("right"):
		title_music.stop()
		get_tree().change_scene("res://scenes/level1.tscn")