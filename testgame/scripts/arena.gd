extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MAX_ENEMIES = 30

onready var music = get_node("music")

onready var enemies = get_node("enemies")
onready var base_dark = preload("res://Units/basic_dark.tscn")

onready var spawner1 = get_node("Spawner1")
onready var spawner2 = get_node("Spawner2")
onready var spawner3 = get_node("Spawner3")
onready var spawner4 = get_node("Spawner4")

onready var global = get_node("/root/Global")

var current_enemies = 0
var spawn = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	global.reset()
	music.play(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_enemies = enemies.get_child_count()
	if current_enemies <= MAX_ENEMIES:
		#print(current_enemies)
		spawn()
		
func spawn():
	if current_enemies < MAX_ENEMIES:
		var x = rand_range(-50.0, 50.0)
		var y = rand_range(-50.0, 50.0)
		var new_enemy = base_dark.instance()
		
		var spawner = randi() % 5 + 1
		if spawner == 1:
			new_enemy.position = spawner1.position
		elif spawner == 2:
			new_enemy.position = spawner2.position
		elif spawner == 3:
			new_enemy.position = spawner3.position
		else:
			new_enemy.position = spawner4.position
			
		new_enemy.position.x += x
		new_enemy.position.y += y
		enemies.add_child(new_enemy)
		
		#spawn += 1
		#print(current_enemies)
		#print(spawn)