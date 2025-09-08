extends RichTextLabel

signal text_endedup_showing

@export var TEXT: String = ""
@export var LETTERS_PER_SECOND: float = 0
@export var LETTER_SOUND: AudioStream = null

@onready var actual_index = 0


func _ready() -> void:
	$Timer.wait_time = 1 / LETTERS_PER_SECOND
	if LETTER_SOUND:
		$LetterSound.stream = LETTER_SOUND


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel"):
		text = TEXT
		text_endedup_showing.emit()
		actual_index = TEXT.length()


func restart(p_text: String, p_letters_per_second: int, p_sound: AudioStream = null):
	LETTER_SOUND = p_sound
	$LetterSound.stream = LETTER_SOUND
	TEXT = p_text
	LETTERS_PER_SECOND = p_letters_per_second
	text = ""
	actual_index = 0
	$Timer.wait_time = 1 / LETTERS_PER_SECOND
	$Timer.start()


func _on_timer_timeout() -> void:
	if actual_index != TEXT.length():
		if $LetterSound.stream:
			$LetterSound.play()
		text += TEXT[actual_index]
		actual_index += 1
	else:
		$Timer.stop()
		text_endedup_showing.emit()
