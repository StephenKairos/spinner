extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body. 

func _on_Finish_body_entered(body):
	print(body.get_name())
	if body.get_name() == "player":
		var next = get_tree().current_scene.name
		var scene = "res://scenes/level0.tscn"
		if next == "level0":
			scene = "res://scenes/level1.tscn"
		elif next == "level1":
			scene = "res://scenes/ending.tscn"
		get_tree().change_scene(scene)