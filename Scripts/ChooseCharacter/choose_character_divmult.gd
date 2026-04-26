extends Node
@onready var button: Button = $CharacterOptions/Button4

func _ready() -> void:
	button.grab_focus()

func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/InfoCharacters/InfoCharactersDIVMULT/info_charactersDIVMULT.tscn")
