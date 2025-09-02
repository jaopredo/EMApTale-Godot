extends CharacterBody2D

@export var SPRITES = {
	"heart": load("res://Sprites/Player/hearts/heart.png"),
	"pinho_heart": load("res://Sprites/Player/hearts/pinho-heart.png"),
	"soledad_heart": load("res://Sprites/Player/hearts/soledad-heart.png"),
	"walter_heart": load("res://Sprites/Player/hearts/walter-heart.png"),
	"yuri_heart": load("res://Sprites/Player/hearts/yuri-heart.png")
}

@export var SPEED = 250
@export var state = "heart"

func _physics_process(delta: float) -> void:
	# Movendo o coração
	var y_strengh = Input.get_axis("up", "down")
	var x_strengh = Input.get_axis("left", "right")
	velocity.x = x_strengh
	velocity.y = y_strengh
	velocity = velocity.normalized() * SPEED	
	move_and_slide()
