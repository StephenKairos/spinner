extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var BASE_LIFE = 5
var BASE_SCORE = 0

var player_life = 5
var player_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_life <= 0:
		get_tree().change_scene("res://scenes/ending.tscn")
		resetLife()
		
func reset():
	resetLife()
	resetScore()
	
func resetLife():
	player_life = BASE_LIFE
	
func resetScore():
	player_score = BASE_SCORE