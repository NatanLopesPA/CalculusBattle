extends CanvasLayer

@onready var audio_text: AudioStreamPlayer2D = $AudioText
@onready var label: Label = $Story
var letters_left: int = 0

func _ready():
	escrever_texto("Thomas Edison
O imperador tirânico por trás de tudo.
Ele não teve sua Centelha roubada;
Ele que roubou as Centelhas.
Ele acredita que toda ordem é uma farsa.
Acreditando ser o único ser supremo;
Em um universo de lógica falsa.

Ele se torna O Imperador da Incompletude.
Viajando pelas linhas temporais;
Tratando os outros gênios como fantoches. 
Ele rouba suas Centelhas da Ideia apenas;
Para provar que elas são inúteis.
Tesla o encontra em seu trono flutuante.
Onde as próprias leis da matemática parecem falhar.", 12.5)

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
		get_tree().change_scene_to_file("res://Cenas/main's/DIVMULT/mainDIVMULT.tscn")
