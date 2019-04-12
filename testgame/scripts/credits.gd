extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var music = get_node("credits_music")
onready var made_time = get_node("made_time")
onready var credits_time = get_node("credits_time")

onready var made = get_node("made_for")
onready var two = get_node("two_button")
onready var credits = get_node("credits")
onready var prompt = get_node("prompt")

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play(0)
	made_time.start(3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not music.is_playing():
		music.play(0)
	if Input.is_action_just_released("right"):
		get_tree().change_scene("res://scenes/title.tscn")

func _on_made_time_timeout():
	made_time.stop()
	made.visible = false
	two.visible = false
	credits.visible = true
	credits_time.start(3)

func _on_credits_time_timeout():
	credits_time.stop()
	credits.visible = false
	prompt.visible = true