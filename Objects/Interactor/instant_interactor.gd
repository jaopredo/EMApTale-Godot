extends Area2D

## This variables indicates the text, the velocity of the text and its sound
@export var TEXT: String = ""
@export var LETTERS_PER_SECOND: int = 10
@export var TEXT_SOUND: AudioStream = load("res://Sounds/text_1.wav")

## The player class
@onready var Player = preload("res://Objects/Frisk/frisk.gd")
## Checks if the player is inside


func _on_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Player):  # Se o player entrou
		body.trigger_dialogue.emit(
			TEXT,
			TEXT_SOUND,
			LETTERS_PER_SECOND,
		)
