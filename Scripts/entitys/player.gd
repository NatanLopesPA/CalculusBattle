extends CharacterBody2D

var player_hit: int = 0
@onready var heart_1_player: AnimatedSprite2D = $Heart_1Player
@onready var heart_2_player: AnimatedSprite2D = $Heart_2Player
@onready var heart_3_player: AnimatedSprite2D = $Heart_3Player
@onready var heart_4_player: AnimatedSprite2D = $Heart_4Player
@onready var heart_5_player: AnimatedSprite2D = $Heart_5Player


@onready var sprite_2d: Sprite2D = $Sprite2D

@export var enemy_target: Node2D 

var original_position: Vector2

func _ready() -> void:
	original_position = global_position

func attack_tween():
	if not enemy_target:
		return
	
	var after_attack = enemy_target.global_position - Vector2(100, 0) 
	
	var tween = create_tween()
	
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_OUT) 
	
	tween.tween_property(self, "global_position", after_attack, 0.4)
	tween.tween_interval(0.2)
	tween.tween_property(self, "global_position", original_position, 0.3)

func _on_main_add_player_life() -> void:
	player_hit += 1
	if player_hit == 1:
		_tween_red_hit()
		
		await get_tree().create_timer(0.05).timeout
		heart_1_player.play("default")
		
	if player_hit == 2:
		_tween_red_hit()
		
		await get_tree().create_timer(0.05).timeout
		heart_2_player.play("default")
		
	if player_hit == 3:
		_tween_red_hit()
		
		await get_tree().create_timer(0.05).timeout
		heart_3_player.play("default")
		
	if player_hit == 4:
		_tween_red_hit()
		
		await get_tree().create_timer(0.05).timeout
		heart_4_player.play("default")
		
	if player_hit == 5:
		_tween_red_hit()
		
		await get_tree().create_timer(0.05).timeout
		heart_5_player.play("default")
		_tween_death()


func _tween_death():
	var player_sprite = sprite_2d
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(player_sprite, "rotation_degrees", -90.0, 0.7)

func _tween_red_hit():
	var tween = create_tween()
	tween.tween_property(sprite_2d, "modulate", Color(1, 0, 0), 0.1)
	tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1), 0.1)
	tween.set_loops(3)
	
	var tween_shake = create_tween()
	for i in range(6):
		var shake = Vector2(randf_range(-5, 5), randf_range(-5, 5))
		
		tween_shake.tween_property(sprite_2d, "position", shake, 0.05)
	
	tween_shake.tween_property(sprite_2d, "position", Vector2.ZERO, 0.05)
