extends Sprite2D

@export var item_id = ""
@export var item_name = ""
@export var item_description = ""
@export var item_type = ""
@export var item_properties = {}

## The player class
@onready var Player = preload("res://Objects/Frisk/frisk.gd")
## Checks if the player is inside
@onready var is_player_inside = false

func assign_item(
	p_item_id: String,
	p_item_name: String,
	p_item_description: String,
	p_item_type: String,
	p_item_sprite: String,
	p_item_properties: Dictionary
):
	item_id = p_item_id
	item_name = p_item_name
	item_description = p_item_description
	item_type = p_item_type
	item_properties = p_item_properties
	
	texture = load(p_item_sprite)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Player):  # Se o player entrou
		# Mostro o botão de interação
		is_player_inside = true
		body.show_pick_item_key()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if is_instance_of(body, Player):  # Se o player saiu
		# Escondo o botão de interação
		is_player_inside = false
		body.hide_pick_item_key()

func _process(delta: float) -> void:
	# Se o player pegar o item
	if Input.is_action_just_pressed("pick_item") and is_player_inside:
		# Vou deletar ele do mapa
		queue_free()
		for body in $Area2D.get_overlapping_bodies():
			if is_instance_of(body, Player):
				body.pick_item.emit(self)
