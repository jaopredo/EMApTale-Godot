extends Node

## ID do item
@export var item_id = ""
## Nome do item
@export var item_name = ""
## Descrição do item
@export var item_description = ""
## Tipo do item
@export var item_type = ""
## Textura do item
@export var item_texture = null
## Propriedades extras do item
@export var item_properties = {}

func _init(p_item_id) -> void:
	item_id = p_item_id
	item_name = GlobalProperties.all_items[item_id]["item_name"]
	item_description = GlobalProperties.all_items[item_id]["item_description"]
	item_type = GlobalProperties.all_items[item_id]["item_type"]
	item_properties = GlobalProperties.all_items[item_id]["item_properties"]
	item_texture = GlobalProperties.all_items[item_id]["item_sprite"]
