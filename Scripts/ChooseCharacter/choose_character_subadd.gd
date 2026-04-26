extends Node
@onready var button: Button = $CharacterOptions/Button2

func _ready() -> void:
	button.grab_focus()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/InfoCharacters/InfoCharactersSUBADD/info_charactersSUBADD.tscn")
