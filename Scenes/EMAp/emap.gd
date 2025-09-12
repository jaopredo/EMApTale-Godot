extends Node2D

func _ready() -> void:
	# Gerando os itens
	var all_items_slots = $YSort/Items.get_children()
	
	# Para cada slot de item nos slots disponíveis
	for item_slot in all_items_slots:
		# Se for um item miscelâneo
		if item_slot.item_type == "miscellaneous":
			# Eu passo as informações de um item aleatório
			var chosen_item_id = GlobalProperties.miscellaneous_items_ids[
				randi() % GlobalProperties.miscellaneous_items_ids.size()
			]
			var chosen_item = GlobalProperties.all_items[chosen_item_id]
			item_slot.assign_item(
				chosen_item_id,
				chosen_item["item_name"],
				chosen_item["item_description"],
				chosen_item["item_type"],
				chosen_item["item_sprite"],
				chosen_item["item_properties"]
			)
