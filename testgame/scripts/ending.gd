extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")
onready var score = get_node("Score")
onready var highscore = get_node("HighScore")

onready var music = get_node("music")
onready var game_over = get_node("game_over")

onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	score.set_text(str(global.player_score))
	highscore.set_text(str(global.high_score))
	game_over.play(0)
	timer.start(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.is_stopped() and Input.is_action_just_released("right"):
		get_tree().change_scene("res://scenes/title.tscn")


func _on_Timer_timeout():
	timer.stop()

func _on_game_over_finished():
	music.play(0)
