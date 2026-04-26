extends CanvasLayer

@onready var audio_text: AudioStreamPlayer2D = $AudioText
@onready var label: Label = $Story
var letters_left: int = 0

func _ready():
	escrever_texto("Fibonacci
Sua Centelha da Ideia foi roubada pelo vilão.
A Harmonia da Proporção Áurea.
Agora, sua mente se corrompe e foca apenas na
Obessão da Expansão infinita.
Ele se torna O Tirano da Espiral.

Usando sua mente para criar Autômatos da Proporção.
Contaminando a realidade, fundindo metal e carne.
Crescendo então uma fortaleza-fábrica descontrolada;
Como um organismo vivo que se enrola sobre si mesmo.
Tesla o encontra no coração dessa estrutura;
Convertendo o mundo em uma grande Espiral de Metal.", 12.5)

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
		get_tree().change_scene_to_file("res://Cenas/main's/MULT/mainMULT.tscn")
