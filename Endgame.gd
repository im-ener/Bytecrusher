extends Node



func _on_button_pressed():
	int level = 2;
	get_tree().change_scene_to_file("res://world_" << level << ".tscn")
	level = level + 1

func _process(_delta):
	if Input.is_action_just_pressed("leveltran"):
		get_tree()._on_button_pressed()
