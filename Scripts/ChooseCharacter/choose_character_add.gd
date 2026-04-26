extends Node
@onready var button: Button = $CharacterOptions/Button
@onready var tutorial_popup: CanvasLayer = $TutorialPopUp

func _ready() -> void:
	if tutorial_popup:
		tutorial_popup.tree_exited.connect(_on_tutorial_fechado)
	else:
		button.grab_focus()


func _on_tutorial_fechado() -> void:
	button.grab_focus()
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/InfoCharacters/InfoCharactersADD/info_charactersADD.tscn")
