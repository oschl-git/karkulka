class_name QuestionGenerator

#This class is used to get an array of questions


static func get_question_array() -> Array[Question]:
	var new_question_array : Array[Question] = []

	new_question_array.append(Question.new(
		"Framework ASP.NET je určen pro jaký jazyk?",
		"C#",
		"JavaScript",
		"Rust"
	))
	new_question_array.append(Question.new(
		"Který z následujících jazyků je nejmladší?",
		"Rust",
		"JavaScript",
		"Python"
	))
	new_question_array.append(Question.new(
		"Který z následujících jazyků je nejmladší?",
		"TypeScript",
		"Rust",
		"Python"
	))
	new_question_array.append(Question.new(
		"Jaké jazyky oficiálně podporuje Godot Engine?",
		"GDScript a C#",
		"Python a C#",
		"C++ a GDScript"
	))
	new_question_array.append(Question.new(
		"V jaké společnosti byl vyvinut jazyk Java?",
		"Sun Microsystems",
		"Oracle",
		"Microsoft"
	))
	new_question_array.append(Question.new(
		"V jaké společnosti byl vyvinut jazyk C#?",
		"Microsoft",
		"Oracle",
		"Moon Microsystems"
	))
	new_question_array.append(Question.new(
		"Kdo původně vyvinul version control systém Git?",
		"Linus Torvalds",
		"Brian Kernighan",
		"Dennis Ritchie"
	))
	new_question_array.append(Question.new(
		"V jakém jazyku je vyvinut compiler jazyku C?",
		"C",
		"Rust",
		"Basic"
	))
	new_question_array.append(Question.new(
		"Jaký hlavní jazyk dnes používá Apple pro vývoj softwaru?",
		"Swift",
		"Objective-C",
		"C"
	))
	new_question_array.append(Question.new(
		"Jaký jazyk používal Apple pro vývoj softwaru do roku 2014?",
		"Objective-C",
		"C++",
		"C"
	))
	new_question_array.append(Question.new(
		"V jakém jazyku je napsaný Linux Kernel?",
		"C",
		"C++",
		"Assembly"
	))
	new_question_array.append(Question.new(
		"Na co je určený datový typ \"short\" v jazyku C#?",
		"Pro celá čísla mezi -32768 a 32767",
		"Pro stringy s délkou mezi 0 až 16",
		"Pro uložení jednoho ASCII znaku"
	))
	new_question_array.append(Question.new(
		"Co udělá Bash příkaz \"cd ..\"?",
		"Změní wd na nadřazenou",
		"Vysune CD mechaniku",
		"Změní wd na domovskou"
	))
	new_question_array.append(Question.new(
		"Co udělá Bash příkaz \"pwd\"?",
		"Vypíše aktuální složku",
		"Změní heslo uživatele",
		"Napíše chybu"
	))
	new_question_array.append(Question.new(
		"Jaká z následujících možností není Linux shell?",
		"Bich",
		"Bash",
		"Fish"
	))
	new_question_array.append(Question.new(
		"Jaká společnost se nejvíce podílela na vývoji jazyka Rust?",
		"Mozilla",
		"Microsoft",
		"Google"
	))
	new_question_array.append(Question.new(
		"Jaký programovací jazyk je používaný v enginu Unreal?",
		"C++",
		"Java",
		"GDScript"
	))

	return new_question_array