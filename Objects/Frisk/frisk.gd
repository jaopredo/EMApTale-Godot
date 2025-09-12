extends CharacterBody2D

## Sinal que é disparado sempre que o player
## muda de direção
signal direction_changed(direction: String)

## Sinal que é disparado sempre que um diálogo/monólogo é acionado
signal trigger_dialogue(text: String, sound: AudioStream, letters_per_second: int)

## Sinal responsável por gerenciar quando o player pega um item no chão
signal pick_item(item)


@onready var SPEED = 100  # Velocidade do player
@onready var previous_direction = "walking_right"
# Estado que o player estava anteriormente (Para controle de animação)

@onready var Z_KEY_TEXTURE = load("res://Sprites/HUD/tecla_z.png")
@onready var F_KEY_TEXTURE = load("res://Sprites/HUD/tecla_f.png")
@onready var MapDialogue = preload("res://Objects/Dialogues/MapDialogue.tscn")
@onready var OpenedDialogue = null

## Variável que diz se o player
## pode ou não se mexer
@onready var can_move = true

## Indica se o diálogo que estava aberto (Se houver um) terminou
@onready var dialogue_ended = false

## Pega a direção que o player está se movendo e
## retorna a string indicando a direção (Para controle de animação)
func get_actual_direction():
	if velocity.x > 0:  # Se o player estiver indo para a direita
		return "walking_right"
	elif velocity.x < 0:  # Se o player estiver indo para a esquerda
		return "walking_left"
	elif velocity.y > 0:  # Se o player estiver indo para baixo
		return "walking_down"
	elif velocity.y < 0:  # Se o player estiver indo para cima
		return "walking_up"
	
	if velocity.length() == 0:  # Se o jogador estiver parado
		if previous_direction == "walking_up":  # E ele ESTAVA indo para cima
			return "idle_up"
		elif previous_direction == "walking_right":  # E ele ESTAVA indo para direita
			return "idle_right"
		elif previous_direction == "walking_left":  # E ele ESTAVA indo para a esquerda
			return "idle_left"
		elif previous_direction == "walking_down":  # E ele ESTAVA indo para baixo
			return "idle_down"


func _physics_process(delta: float) -> void:
	if can_move:  # Se o player pode se mover
		# Checo a direção no eixo Y que ele está indo
		var y_direction = Input.get_axis("up", "down")
		# Checo a direção no eixo X que ele está indo
		var x_direction = Input.get_axis("left", "right")
		
		# Coloco a velocidade do meu player
		velocity = Vector2(
			x_direction,
			y_direction
		).normalized() * SPEED
		
		# Pego a direção atual
		var actual_direction = get_actual_direction()
		# Se a direção atual for diferente da anterior
		if actual_direction != previous_direction:
			# Disparo o sinal que a direção mudou
			direction_changed.emit(actual_direction)
		# Coloco que a direção anterior é a direção atual
		previous_direction = actual_direction
		
		move_and_slide()
	else:
		if Input.is_action_just_pressed("cancel") and dialogue_ended:
			OpenedDialogue.queue_free()
			dialogue_ended = false
			can_move = true


## Função ligada ao sinal de Direção Alterada
func _on_direction_changed(direction: String) -> void:
	# Se tiver uma animação rodando
	if $AnimationPlayer.is_playing():
		# Eu paro a animação
		$AnimationPlayer.stop()
	# Toco a animação com base na direção passada
	$AnimationPlayer.play(direction)


## Função que mostra a tecla de INTERAÇÃO
func show_interaction_key():
	$Keys.texture = Z_KEY_TEXTURE


## Função que esconde a tecla de INTERAÇÃO
func hide_interaction_key():
	$Keys.texture = null


## Função que mostra a tecla de PEGAR ITEM
func show_pick_item_key():
	$Keys.texture = F_KEY_TEXTURE


## Função que esconde a tecla de PEGAR ITEM
func hide_pick_item_key():
	$Keys.texture = null

## Função ligada ao sinal de INICIAR DIÁLOGO
func _on_trigger_dialogue(text: String, sound: AudioStream, letters_per_second: int) -> void:
	OpenedDialogue = MapDialogue.instantiate()
	OpenedDialogue.TEXT = text
	OpenedDialogue.TEXT_SOUND = sound
	OpenedDialogue.LETTERS_PER_SECOND = letters_per_second
	OpenedDialogue.connect("text_endedup_showing", _on_dialogue_text_endedup_showing)
	can_move = false
	$Camera/DialoguePosition.add_child(OpenedDialogue)

func _on_dialogue_text_endedup_showing():
	dialogue_ended = true


func _on_pick_item(item: Variant) -> void:
	GlobalPlayerManager.add_item(item)
