extends Control
class_name Karkulka

#This class handles the Karkulka (player) character


var current_position : Vector2
var can_move := true
var stuck_on_obstacle := false
var inventory := ["baguette", "wine"]


func _enter_tree() -> void:
	GlobalScript.karkulka = self


func _ready() -> void:
	current_position = Vector2(
		0,
		GlobalScript.gamegrid.dimensions.y - 1,
	)
	GlobalScript.gamegrid.game_grid_array[current_position.y][current_position.x].interact()


#Smoothly changes global (actual) position
func _physics_process(_delta: float) -> void:
	global_position = lerp(
		global_position,
		GlobalScript.gamegrid.game_grid_array
				[current_position.y][current_position.x].global_position,
		.5
	)


#Handles player movement
func _input(event) -> void:
	if event.is_action_pressed("move_up"):
		change_position(current_position.x, current_position.y-1)
	elif event.is_action_pressed("move_down"):
		change_position(current_position.x, current_position.y+1)
	elif event.is_action_pressed("move_left"):
		change_position(current_position.x-1, current_position.y)
	elif event.is_action_pressed("move_right"):
		change_position(current_position.x+1, current_position.y)


#Changes current position, doesn't allow going out of bounds, calls wolf and
#interacts with game fields
func change_position(x : float, y : float, force := false) -> void:
	if !can_move and !force: return
	
	current_position.x = x
	current_position.y = y

	if current_position.x > GlobalScript.gamegrid.dimensions.x - 1:
		current_position.x = GlobalScript.gamegrid.dimensions.x - 1
		return
	elif current_position.y > GlobalScript.gamegrid.dimensions.y - 1:
		current_position.y = GlobalScript.gamegrid.dimensions.y - 1
		return
	elif current_position.x < 0:
		current_position.x = 0
		return
	elif current_position.y < 0:
		current_position.y = 0
		return

	move_wolf()
	GlobalScript.gamegrid.game_grid_array[current_position.y][current_position.x].interact()


#Checks if Karkulka was devoured by The Wolf
func check_wolf_death() -> void:
	var wolf_position : Vector2 = GlobalScript.wolf.current_position
	if wolf_position == current_position:
		GlobalScript.gamemanager.show_popup(
			"Game Over!",
			"The Wolf devoured Karkulka."
		)
		can_move = false


#Moves the wolf, checks for Karkulka death
func move_wolf() -> void:
	check_wolf_death()
	GlobalScript.wolf.move()
	check_wolf_death()