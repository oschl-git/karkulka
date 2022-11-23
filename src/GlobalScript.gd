extends Node

var karkulka : Karkulka
var gamegrid
var gamemanager : GameManager


func _ready() -> void:
	set_window_parameters()


#Sets correct starting window parameters.
func set_window_parameters() -> void:
	DisplayServer.window_set_size(Vector2(1280, 720))

	var screen_size : Vector2 = DisplayServer.screen_get_size()
	var window_size : Vector2 = DisplayServer.window_get_size()
	DisplayServer.window_set_position(screen_size * 0.5 - window_size * 0.5)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_fullscreen"):
		if (DisplayServer.window_get_mode() == 
				DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN):
			DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_WINDOWED)
		else: DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		
