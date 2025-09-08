extends TextureRect

signal text_endedup_showing

@export var TEXT = ""
@export var TEXT_SOUND: AudioStream
@export var LETTERS_PER_SECOND: int = 0

func _ready() -> void:
	restart(TEXT, LETTERS_PER_SECOND, TEXT_SOUND)

func restart(p_text: String, p_letters_per_second: int, p_audio: AudioStream):
	$SmartText.restart(p_text, p_letters_per_second, p_audio)

func _on_smart_text_text_endedup_showing() -> void:
	text_endedup_showing.emit()
