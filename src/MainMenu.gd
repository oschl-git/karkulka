extends Control

#This class handles the main menu button inputs


#Changes to the game scene
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/game_ui.tscn")


#Exists the game
func _on_exit_button_pressed() -> void:
	get_tree().quit()
