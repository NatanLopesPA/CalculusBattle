extends CanvasLayer

@onready var button_focus: Button = $MarginContainer/HBoxContainer/VBoxContainer/ButtonPlay
@onready var label: Label = $Label
@onready var audio_text: AudioStreamPlayer2D = $AudioText

var letters_left: int = 0

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	var letters_now = label.visible_characters
	
	if letters_now > letters_left:
		if letters_now % 4 == 0:
			audio_text.pitch_scale = randf_range(0.9, 1.1)
			audio_text.play(2.39)
			
		letters_left = letters_now
	if letters_now < letters_left:
		audio_text.stop()

func _ready():
	button_focus.grab_focus()
	escrever_texto("PARABÉNS!!
GRAÇAS A SUA AJUDA,
THOMAS EDISON FOI DERROTADO;
NIKOLA TESLA ESTA ORGULHOSO,
PELO SEU DESEMPENHO!!", 5.0)

func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/main_menu.tscn")
	
func _on_button_exit_pressed() -> void:
	get_tree().quit()

func escrever_texto(new_text: String, duration: float = 2.0):
	
	label.text = new_text
	
	letters_left = 0
	
	label.visible_ratio = 0.0
	
	var tween = create_tween()
	
	tween.tween_property(label, "visible_ratio", 1.0, duration)
