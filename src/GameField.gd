extends Control
class_name GameField

#This class manages individual game fields


enum Types {
	FOREST,
	KARKULKA_HOME,
	BABICKA_HOME,
	OBSTACLE,
	BLUDNY_KOREN,
	ITEM_FIELD,
}
var type := Types.FOREST
var questions : Array[Question]

var textures := [
	"res://Assets/forest.png",
	"res://Assets/karkulka_home.png",
	"res://Assets/babicka.png",
	"res://Assets/obstacle.png",
	"res://Assets/bludny_koren.png",
	"res://Assets/item_field.png",
]

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	questions = QuestionGenerator.get_question_array()


#Changes field type and texture.
func change_type(new_type : Types) -> void:
	type = new_type
	$Sprite2D.set_texture(load(textures[type]))


#Calls correct interact method depending on type of field.
func interact() -> void:
	match type:
		Types.FOREST:
			forest()
		Types.KARKULKA_HOME:
			karkulka_home()
		Types.BABICKA_HOME:
			babicka_home()
		Types.OBSTACLE:
			obstacle()
		Types.BLUDNY_KOREN:
			bludny_koren()
		Types.ITEM_FIELD:
			item_field()


func forest() -> void: 
	GlobalScript.gamemanager.change_field_info(
		"Forest Path", "A simple forest path with not much going on."
	)
	GlobalScript.gamemanager.change_button_state("", "", "")


func karkulka_home() -> void: 
	GlobalScript.gamemanager.change_field_info(
		"Karkulka's Home", "This is where Karkulka lives."
	)
	GlobalScript.gamemanager.change_button_state("", "", "")


func babicka_home() -> void: 
	GlobalScript.gamemanager.change_field_info(
		"Babicka's Home", "This is where babicka lives. Congratulations, you "
		+ "made it!"
	)
	GlobalScript.gamemanager.change_button_state("", "", "")
	
	GlobalScript.karkulka.can_move = false
	
	await get_tree().create_timer(1).timeout
	
	if GlobalScript.karkulka.inventory.size() >= 3:
		GlobalScript.gamemanager.show_popup(
			"Game Won!",
			"Congratulations, Karkulka reached babicka with "
			+ str(GlobalScript.karkulka.inventory.size()) + " gifts."
		)
	else:
		GlobalScript.gamemanager.show_popup(
			"Game Over!",
			"You've reached babicka, but you only brought "
			+ str(GlobalScript.karkulka.inventory.size()) + " gifts."
			+ " Babicka consumed Karkulka instead."
		)


func obstacle() -> void:
	GlobalScript.karkulka.can_move = false
	randomize()
	questions.shuffle()
	questions[0].answers.shuffle()
	GlobalScript.gamemanager.change_field_info(
		"Obstacle", questions[0].question
	)
	GlobalScript.gamemanager.change_button_state(
			questions[0].answers[0],
			questions[0].answers[1],
			questions[0].answers[2])


func bludny_koren() -> void:
	GlobalScript.gamemanager.change_field_info(
		"Bludny Koren", "Bludny koren transfers you to a random place on the"
		+ " game map."
	)
	GlobalScript.gamemanager.change_button_state("", "", "")
	
	GlobalScript.karkulka.can_move = false
	await get_tree().create_timer(1).timeout
	GlobalScript.karkulka.can_move = true
	GlobalScript.karkulka.change_position(rng.randi_range(0, 5),
			rng.randi_range(0, 5), true)


func item_field() -> void:
	GlobalScript.gamemanager.change_field_info(
		"Mushroom Field", "A field filled with (probably) edible mushrooms."
		+ "Karkulka can refill her supplies for babicka here."
	)
	if GlobalScript.karkulka.inventory.size() < 4:
		GlobalScript.gamemanager.change_button_state(
			"Collect mushrooms", "", ""
		)
	else:
		GlobalScript.gamemanager.change_button_state("Inventory full", "", "")


#Reacts accordingly after receiving a button pressed call.
func on_button_pressed(num : int) -> void:
	match type:
		Types.OBSTACLE:
			if questions.size() == 0:
				questions = QuestionGenerator.get_question_array()

			if GlobalScript.karkulka.stuck_on_obstacle:
				GlobalScript.karkulka.inventory.remove_at(0)
				GlobalScript.gamemanager.update_inventory(
					GlobalScript.karkulka.inventory
				)
				
				GlobalScript.karkulka.can_move = true
				GlobalScript.karkulka.stuck_on_obstacle = false
				GlobalScript.gamemanager.change_field_info(
					"Myslivec helped you", "You've passed the obstacle in"
					+ " exchange for one inventory item."
				)
				GlobalScript.gamemanager.change_button_state("", "", "")
			elif questions[0].answers[num] == questions[0].correct_answer:
				if questions.size() != 0: questions.remove_at(0)
				GlobalScript.karkulka.can_move = true
				GlobalScript.gamemanager.change_field_info(
					"Correct!", "You've successfully passed the obstacle."
				)
				GlobalScript.gamemanager.change_button_state("", "", "")
			else:
				if questions.size() != 0: questions.remove_at(0)
				if GlobalScript.karkulka.inventory.size() <= 0:
					GlobalScript.gamemanager.show_popup(
						"Game Over!",
						"Myslivec refused to help you because you didn't have"
						+ " any items in your inventory."
						+ " Karkulka died of thirst three days later."
					)
					return
				
				GlobalScript.karkulka.move_wolf()
				GlobalScript.karkulka.stuck_on_obstacle = true
				GlobalScript.gamemanager.change_field_info(
					"Get help from Myslivec", "Incorrect. Myslivec found you"
					+ " stuck on this obstacle. He can help you in exchange for"
					+ " one item from your inventory."
				)
				GlobalScript.gamemanager.change_button_state(
					"Use inventory item", "", ""
				)
				
		Types.ITEM_FIELD:
			if GlobalScript.karkulka.inventory.size() >= 4:
				return
			GlobalScript.karkulka.inventory.append("mushroom")
			GlobalScript.gamemanager.update_inventory(
				GlobalScript.karkulka.inventory
			)
			change_type(Types.FOREST)
			GlobalScript.gamemanager.change_field_info(
				"Forest Path", "A simple forest path with not much going on."
			)
			GlobalScript.gamemanager.change_button_state("", "", "")
