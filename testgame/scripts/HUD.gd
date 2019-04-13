extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")
onready var lifebar = get_node("Life_Bar")
onready var score = get_node("Score_Counter")
onready var highscore = get_node("HighScore_Counter")

onready var heart_item = preload("res://Units/life.tscn")

var currentlife = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")
	currentlife = global.player_life
	draw_life()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score.set_text(str(global.player_score))
	highscore.set_text(str(global.high_score))
	#life.set_text(str(global.player_life))
	if not currentlife == global.player_life:
		currentlife = global.player_life
		draw_life()
	
func draw_life():
	for i in range(0, lifebar.get_child_count()):
		lifebar.get_child(i).queue_free()
	
	for i in range(1, global.BASE_LIFE + 1):
		var heart = heart_item.instance()
		#print(str(i) + " " + str(currentlife))
		if i < currentlife + 1:
			heart.play("full")
		elif i >= currentlife:
			heart.play("empty")
		heart.position.x += ((i - 1) * 32)
		lifebar.add_child(heart)