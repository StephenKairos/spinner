extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")
onready var life = get_node("Life_Counter")
onready var score = get_node("Score_Counter")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score.set_text(str(global.player_score))
	life.set_text(str(global.player_life))