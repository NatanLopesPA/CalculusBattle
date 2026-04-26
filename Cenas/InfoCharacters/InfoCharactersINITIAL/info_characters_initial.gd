extends CanvasLayer

@onready var audio_text: AudioStreamPlayer2D = $AudioText
@onready var label: Label = $Story

var letters_left: int = 0

func _ready():
	escrever_texto("Nikola Tesla, o Filho da Luz. 
Ele dedicou sua existência aos estudos;
Conectando o mundo através da Torre de Wardenclyffe.
No entanto, Thomas Edison interferiu.
O vilão roubou a Centelha da Frequência.
Condenando a humanidade ao atraso.

Mas onde outros veriam o fim,
O maior cientista da história viu um desafio. 
Recusando-se a aceitar a Incompletude do vilão; 
Tesla cria o Super Autômato β.
Uma armadura movida a raios e pura esperança.
O único ser capaz de viajar pelas distorções temporais.
Lutando para consertar as linhas do tempo e;
Recuperar a genialidade de seus irmãos intelectuais.", 12.5)

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
		get_tree().change_scene_to_file("res://Cenas/Choose Characters/choose_characterADD.tscn")
