extends CanvasLayer
@onready var label: Label = $Panel/Label
@onready var audio_text: AudioStreamPlayer2D = $AudioText
var letters_left: int = 0

func _ready():
	escrever_texto("Nikolas teve todo o conhecimento do mundo roubado por seus inimigo. Agora,
ele inicia uma jornada de duelos mentais para
 recuperar o que foi perdido.
Objetivo:
➢ Derrote 3 inimigos em batalhas de conhecimento até alcançar seu verdadeiro desafio final

Como jogar:
➢ Cada duelo é um quiz de múltipla escolha com 4 alternativas.
➢ Escolha a resposta correta para atacar seu inimigo.
➢ Respostas erradas resultam em dano contra você.

Regras da batalha:
➢ Você e cada inimigo começam com 5 vidas.
➢ Vence quem zerar as vidas do oponente primeiro.
➢ Avance apenas se sobreviver aos duelos.", 12.5)

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

func _on_button_pressed() -> void:
	queue_free()
