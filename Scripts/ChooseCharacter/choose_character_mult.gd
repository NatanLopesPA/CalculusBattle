extends Node
@onready var button: Button = $CharacterOptions/Button3

func _ready() -> void:
	button.grab_focus()

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/InfoCharacters/InfoCharactersMULT/info_charactersMULT.tscn")
