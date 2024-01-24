extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://world.tscn") # change the res://game.tscn to be what the main game is called
