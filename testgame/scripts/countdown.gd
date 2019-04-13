extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ready = get_node("ready")
onready var three = get_node("3")
onready var two = get_node("2")
onready var one = get_node("1")

onready var ready_fx = get_node("ready_fx")
onready var three_fx = get_node("3_fx")
onready var two_fx = get_node("2_fx")
onready var one_fx = get_node("1_fx")

# Called when the node enters the scene tree for the first time.
func _ready():
	ready_fx.play(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ready_fx_finished():
	three_fx.play(0)
	ready.visible = false
	three.visible = true

func _on_3_fx_finished():
	two_fx.play(0)
	three.visible = false
	two.visible = true
	
func _on_2_fx_finished():
	one_fx.play(0)
	two.visible = false
	one.visible = true


func _on_1_fx_finished():
	get_tree().change_scene("res://scenes/arena.tscn")
