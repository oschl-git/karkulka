extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/game_ui.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
