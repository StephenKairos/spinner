extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var music = get_node("level1_music")

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass