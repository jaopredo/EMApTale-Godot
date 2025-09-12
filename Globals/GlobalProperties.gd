extends Node

## O dia atual que o jogo está se passando
@export var day = 1

## ID's das variáveis miscelâneas
@export var miscellaneous_items_ids = [
	"carrot-cake",
	"cheese-bread",
	"coffee",
	"chocolate-bar"
]

## Todos os itens do meu jogo
@export var all_items = {
	"carrot-cake":{
		"item_name": "Bolo de Cenoura",
		"item_description": "Ninguém do hotel te viu saindo com isso, ainda bem!",
		"item_type": "miscellaneous",
		"item_sprite": "res://Sprites/Items/cake.png",
		"item_properties": {
			"effect": "heal",
			"after_effect_text": "O Bolo do hotel sempre está seco, isso não te impressiona mais. Você curou 8 de vida",
			"value": 8
		}
	},
	"cheese-bread": {
		"item_name": "Pão de Queijo",
		"item_description": "Ninguém do hotel te viu saindo com isso, ainda bem!",
		"item_type": "miscellaneous",
		"item_sprite": "res://Sprites/Items/queijo.png",
		"item_properties": {
			"effect": "heal",
			"after_effect_text": "A fama desse negócio na EMAp tem motivo! Você curou 10 de vida",
			"value": 10
		}
	},
	"coffee": {
		"item_name": "Café",
		"item_description": "Um café frio e ruim",
		"item_type": "miscellaneous",
		"item_sprite": "res://Sprites/Items/coffe.png",
		"item_properties": {
			"effect": "heal",
			"after_effect_text": "O café está frio e ruim, que surpresa... Você curou 4 de vida",
			"value": 4
		}
	},
	"chocolate-bar": {
		"item_name": "Barra de Chocolate",
		"item_description": "Estava na sessão dos 'Quase Vencendo' do Pão de Açúcar",
		"item_type": "miscellaneous",
		"item_sprite": "res://Sprites/Items/chocolate-bar.png",
		"item_properties": {
			"effect": "heal",
			"after_effect_text": "Não estava vencido, que sorte! Você curou 15 de vida",
			"value": 15
		}
	},
	
	
	"pencil": {
		"item_name": "Lápis",
		"item_description": "É o que eu tinha na mochila",
		"item_type": "weapon",
		"item_sprite": "res://Sprites/Items/pencil.png",
		"item_properties": {
			"damage": 5
		}
	},
	"pen": {
		"item_name": "Caneta",
		"item_description": "Uma caneta bem afiada. Agora posso pedir revisão da prova",
		"item_type": "weapon",
		"item_sprite": "res://Sprites/Items/pen.png",
		"item_properties": {
			"damage": 7
		}
	},
	"test": {
		"item_name": "Simulado",
		"item_description": "Finalmente um simulado que tá no nível da prova",
		"item_type": "weapon",
		"item_sprite": "res://Sprites/Items/test.png",
		"item_properties": {
			"damage": 9
		}
	},
	"book": {
		"item_name": "Livro",
		"item_description": "Alguém pegou emprestado na biblioteca e esqueceu aqui",
		"item_type": "weapon",
		"item_sprite": "res://Sprites/Items/book.png",
		"item_properties": {
			"damage": 11
		}
	},
}
