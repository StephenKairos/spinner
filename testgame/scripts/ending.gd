extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")
onready var score = get_node("Score")
onready var music = get_node("music")

# Called when the node enters the scene tree for the first time.
func _ready():
	score.set_text(str(global.player_score))
	music.play(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("right"):
		get_tree().change_scene("res://scenes/title.tscn")
