extends Area2D

## This variables indicates the text, the velocity of the text and its sound
@export var TEXT: String = ""
@export var LETTERS_PER_SECOND: int = 10
@export var TEXT_SOUND: AudioStream = load("res://Sounds/text_1.wav")

## The player class
@onready var Player = preload("res://Objects/Frisk/frisk.gd")
## Checks if the player is inside
@onready var is_player_inside = false


func _on_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Player):  # Se o player entrou
		# Mostro o botão de interação
		is_player_inside = true
		body.show_interaction_key()


func _on_body_exited(body: Node2D) -> void:
	if is_instance_of(body, Player):  # Se o player saiu
		# Escondo o botão de interação
		is_player_inside = false
		body.hide_interaction_key()


func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		# Se o player está dentro, eu apertei o botão de interação e o player ainda pode se mover
		if is_instance_of(body, Player) and Input.is_action_just_pressed("accept") and body.can_move:
			# Eu disparo o sinal de iniciar diálogo
			body.trigger_dialogue.emit(
				TEXT,
				TEXT_SOUND,
				LETTERS_PER_SECOND,
			)
