extends Control
class_name GameManager

#This class manages game UI and game elements


func _enter_tree() -> void:
	GlobalScript.gamemanager = self


func _ready() -> void:
	update_inventory(GlobalScript.karkulka.inventory)


#Changes field title and description (on the right side of the screen)
func change_field_info(field_name : String, field_desc : String):
	$BaseGameBg/CurrentFieldLabel.set_text(field_name)
	$BaseGameBg/CurrentFieldDesc.set_text(field_desc)


#Updates inventory with an array of strings
func update_inventory(new_inventory : Array[String]) -> void:
	$BaseGameBg/InventoryLabel/InventoryBg/Inventory/Item1.visible = false
	$BaseGameBg/InventoryLabel/InventoryBg/Inventory/Item2.visible = false
	$BaseGameBg/InventoryLabel/InventoryBg/Inventory/Item3.visible = false
	$BaseGameBg/InventoryLabel/InventoryBg/Inventory/Item4.visible = false
	
	var i := 1
	for item in new_inventory:
		if i > 4: break
		var current_item := "BaseGameBg/InventoryLabel/InventoryBg/Inventory/Item" + str(i)
		get_node(current_item).visible = true
		i += 1
		
		match item:
			"baguette":
				get_node(current_item).texture = load("res://Assets/baguette.png")
			"wine":
				get_node(current_item).texture = load("res://Assets/wine.png")
			"mushroom":
				get_node(current_item).texture = load("res://Assets/item_field.png")


#Changes button text and visibility
func change_button_state(
		button1 : String, button2 : String, button3 : String) -> void:
	if button1 != "":
		$BaseGameBg/Button1.visible = true
		$BaseGameBg/Button1.set_text(button1)
	else: $BaseGameBg/Button1.visible = false
	
	if button2 != "":
		$BaseGameBg/Button2.visible = true
		$BaseGameBg/Button2.set_text(button2)
	else: $BaseGameBg/Button2.visible = false

	if button3 != "":
		$BaseGameBg/Button3.visible = true
		$BaseGameBg/Button3.set_text(button3)
	else: $BaseGameBg/Button3.visible = false


#Calls button press on correct game field
func send_pressed_button(num : int):
	GlobalScript.gamegrid.game_grid_array[
		GlobalScript.karkulka.current_position.y][
		GlobalScript.karkulka.current_position.x].on_button_pressed(num)


func _on_button1_pressed() -> void:
	send_pressed_button(0)


func _on_button2_pressed() -> void:
	send_pressed_button(1)


func _on_button3_pressed() -> void:
	send_pressed_button(2)


#Shows popup that disables the game (game must be restarted after)
func show_popup(popup_title : String, popup_text : String):
	$Popup.visible = true
	$Popup/PopupTitle.text = popup_title
	$Popup/PopupText.text = popup_text
	
	$BaseGameBg/Button1.visible = false
	$BaseGameBg/Button2.visible = false
	$BaseGameBg/Button3.visible = false


func _on_button_1_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	get_tree().reload_current_scene()
