extends CharacterBody2D

enum HeartStates {
	heart,
	pinho_heart,
	soledad_heart,
	walter_heart,
	yuri_heart
}

# Variáveis de sprites possíveis para o coração
@export var SPRITES = {
	HeartStates.heart: load("res://Sprites/Player/hearts/heart.png"),
	HeartStates.pinho_heart: load("res://Sprites/Player/hearts/pinho-heart.png"),
	HeartStates.soledad_heart: load("res://Sprites/Player/hearts/soledad-heart.png"),
	HeartStates.walter_heart: load("res://Sprites/Player/hearts/walter-heart.png"),
	HeartStates.yuri_heart: load("res://Sprites/Player/hearts/yuri-heart.png")
}

# Informações do coração
@export var SPEED = 250
# Qual que é o estado do coração
@export var state: HeartStates = HeartStates.heart

func _physics_process(delta: float) -> void:
	# Movendo o coração
	var y_strengh = Input.get_axis("up", "down")
	var x_strengh = Input.get_axis("left", "right")
	velocity.x = x_strengh
	velocity.y = y_strengh
	velocity = velocity.normalized() * SPEED	
	move_and_slide()
