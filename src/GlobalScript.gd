extends Node

#This is a globally loaded and accessible script used for various needs


#Globally accessible instances of currently used scripts
var karkulka : Karkulka
var gamegrid : GameGrid
var gamemanager : GameManager
var wolf : Wolf


#Allows fullscreen to be toggled with F11
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_fullscreen"):
		if (DisplayServer.window_get_mode() == 
				DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN):
			DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_WINDOWED)
		else: DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		
