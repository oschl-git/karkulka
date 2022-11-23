extends GridContainer
class_name GameGrid

var dimensions : Vector2 = Vector2(6, 6)

@onready var game_field := preload("res://GameElements/game_field.tscn")
var game_grid_array : Array[Array]


func _enter_tree() -> void:
	GlobalScript.gamegrid = self


func _ready() -> void:
	game_grid_array = generate_grid_items()

	columns = int(dimensions.x)

	get_parent().set_size(
		Vector2(
			(dimensions.y * 16) + ((dimensions.y + 1) * 4),
			(dimensions.x * 16) + ((dimensions.x + 1) * 4)
		)
	)

func generate_grid_items() -> Array[Array]:
	var grid_array_items : Array[GameField] = []
	for n in 36:
		var current_type : GameField.Types
		if n <= 10: current_type = GameField.Types.FOREST
		elif n <= 23: current_type = GameField.Types.OBSTACLE
		elif n <= 30: current_type = GameField.Types.BLUDNY_KOREN
		else: current_type = GameField.Types.ITEM_FIELD
		
		#current_type = GameField.Types.BLUDNY_KOREN

		var new_game_field := game_field.instantiate()
		new_game_field.change_type(current_type)
		grid_array_items.append(new_game_field)
	
	randomize()
	grid_array_items.shuffle()

	var new_grid_array : Array[Array] = []
	for n in dimensions.y:
		new_grid_array.append([])
		for i in dimensions.x:
			new_grid_array[n].append(grid_array_items[0])
			add_child(grid_array_items[0])
			grid_array_items.remove_at(0)
	
	new_grid_array[5][0].change_type(GameField.Types.KARKULKA_HOME)
	new_grid_array[0][5].change_type(GameField.Types.BABICKA_HOME)
	
	return new_grid_array
