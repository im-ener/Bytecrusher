extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn") # change the res://game.tscn to be what the main game is called

func _on_options_pressed():
	get_tree().change_scene_to_file("res://optionsMenu.tscn") # change the res://options_menu.tscn to be what the main game is called


func _on_quit_pressed():
	get_tree().quit()
