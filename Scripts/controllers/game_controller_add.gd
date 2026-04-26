extends Node

signal enemy_life
signal player_life

@onready var button_go: Button = $CanvasLayer/Control/GameOver/ButtonGO
@onready var button_vic: Button = $CanvasLayer/Control/Victory/ButtonVic

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

@export var player_to_attack: CharacterBody2D
@export var enemy_to_attack: CharacterBody2D

var buttons: Array[Button]
var index: int
var correct: int

var player_hit: int
var enemy_hit: int

var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

@onready var question_text: Label = $CanvasLayer/Control/QuestionInfo/QuestionText
@onready var button_select = $CanvasLayer/Control/QuestionOptions/Button

func _ready() -> void:
	for button in $CanvasLayer/Control/QuestionOptions.get_children():
		buttons.append(button)
		button_select.grab_focus()
		randomize_array(quiz.theme)
	load_quiz()

func load_quiz() -> void:
	if enemy_hit >= 5:
		await get_tree().create_timer(0.5).timeout
		_game_over();
		return
	elif player_hit >= 5:
		await get_tree().create_timer(0.5).timeout
		_victory();
		return
	
	question_text.text = current_quiz.question_info
	
	var options = randomize_array(current_quiz.options)
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))

func _buttons_answer(button) -> void:
	if quiz.theme[index].correct == button.text:
		button.modulate = color_right
		$AudioCorrect.play()
		player_hit += 1
		enemy_life.emit()
		if player_to_attack:
			player_to_attack.attack_tween()
	else:
		button.modulate = color_wrong
		$AudioIncorrect.play(0.5)
		enemy_hit += 1
		player_life.emit()
		if enemy_to_attack:
			enemy_to_attack.attack_tween()
	_next_question()

func _next_question() -> void:
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
	
	await get_tree().create_timer(1).timeout
	$AudioIncorrect.stop()
	$AudioCorrect.stop()
	
	for bt in buttons:
		bt.modulate = Color.WHITE
		
	index += 1
	load_quiz()

func randomize_array(array: Array) -> Array:
	var array_temp := array
	array_temp.shuffle()
	return array_temp

func _game_over() -> void:
	button_go.grab_focus()
	$CanvasLayer/Control/GameOver.show()

func _victory() -> void:
	button_vic.grab_focus()
	$CanvasLayer/Control/Victory.show()

func _on_button_go_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_vic_pressed() -> void:
	var actual_scene = get_tree().current_scene.name
	if actual_scene == "mainADD":
		get_tree().change_scene_to_file("res://Cenas/Choose Characters/choose_characterSUBADD.tscn")
	if actual_scene == "mainSUBADD":
		get_tree().change_scene_to_file("res://Cenas/Choose Characters/choose_characterMULT.tscn")
	if actual_scene == "mainMULT":
		get_tree().change_scene_to_file("res://Cenas/Choose Characters/choose_characterDIVMULT.tscn")
	if actual_scene == "mainDIVMULT":
		get_tree().change_scene_to_file("res://Cenas/victory.tscn")
