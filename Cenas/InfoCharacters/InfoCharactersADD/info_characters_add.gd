extends CanvasLayer

@onready var audio_text: AudioStreamPlayer2D = $AudioText
@onready var label: Label = $Story

var letters_left: int = 0

func _ready():
	escrever_texto("Pitágoras
Sua Centelha da Ideia, foi roubada pelo vilão.
Sem a ideia do Teorema, a sua mente colapsa.
Se tornando o Tirano dos Ângulos, vendo apenas o caos.

Uma armadura divina e tecnológica se manifesta.
Porém ela é feita de geometria instável;
Trazendo consigo uma maldição.
Além de distorcer a realidade ao seu redor.
Ela também machuca o usuário que está usando.
Nikola Tesla chega para confrontá-lo através da lógica.
Lutando para trazer de volta a mente do matemático;
E salvá-lo da própria armadura.", 12.5)

func escrever_texto(new_text: String, duration: float = 2.0):
	
	label.text = new_text
	
	letters_left = 0
	
	label.visible_ratio = 0.0
	
	var tween = create_tween()
	
	tween.tween_property(label, "visible_ratio", 1.0, duration)

func _process(delta):
	var letters_now = label.visible_characters
	
	if letters_now > letters_left:
		if letters_now % 4 == 0:
			audio_text.pitch_scale = randf_range(0.9, 1.1)
			audio_text.play(2.39)
		
		letters_left = letters_now
	if letters_now < letters_left:
		audio_text.stop()

func _input(event):
	if event.is_action_pressed("continuar"):
		get_tree().change_scene_to_file("res://Cenas/main's/ADD/mainADD.tscn")
