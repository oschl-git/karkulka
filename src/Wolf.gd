extends Control
class_name Wolf

#This class controls the wolf


var current_position : Vector2


func _enter_tree() -> void:
	GlobalScript.wolf = self


func _ready() -> void:
	get_starting_position()


func get_starting_position() -> void:
	current_position = Vector2(
		0,
		GlobalScript.gamegrid.dimensions.y - 1,
	)

	current_position.x = randi_range(1, 3)
	current_position.y -= 4 - current_position.x
	
	global_position = current_position




func move() -> void:
	var karkulka_position : Vector2 = GlobalScript.karkulka.current_position
	var x_difference := karkulka_position.x - current_position.x
	var y_difference := karkulka_position.y - current_position.y

	if (randi() % 2 == 0 and x_difference != 0) || y_difference == 0:
		current_position.x += 1 if x_difference > 0 else -1 
	else:
		current_position.y += 1 if y_difference > 0 else -1 


func _physics_process(_delta: float) -> void:
	global_position = lerp(
		global_position,
		GlobalScript.gamegrid.game_grid_array
				[current_position.y][current_position.x].global_position,
		.5
	)


func change_position(x : float, y : float) -> void:
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