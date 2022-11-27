extends Node
class_name Question

#This is a class used for storing question data


var question : String
var answers : Array[String]
var correct_answer : String


#Constructor for storing all neeeded data
func _init(new_question : String, answer1 : String, answer2 : String,
		answer3 : String) -> void:
	question = new_question
	answers.append(answer1)
	correct_answer = answer1
	answers.append(answer2)
	answers.append(answer3)
