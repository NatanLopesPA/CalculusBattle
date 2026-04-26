extends CanvasLayer

@onready var button_focus: Button = $MarginContainer/HBoxContainer/VBoxContainer/ButtonPlay

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _ready():
	button_focus.grab_focus()

func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/InfoCharacters/InfoCharactersINITIAL/info_charactersINITIAL.tscn")
	
func _on_button_exit_pressed() -> void:
	get_tree().quit()
