extends Node2D

@export var SCALE_ON_PLAYER_TURN = Vector2(2.93037, 1.54285)
@export var SCALE_ON_BOSS_TURN = Vector2(1.43959, 2.82285)

func rescale(turn: GlobalCombat.Turn):
	var tween = get_tree().create_tween()
	if turn == GlobalCombat.Turn.player:
		tween.tween_property(self, "scale", SCALE_ON_PLAYER_TURN, .7)
	else:
		tween.tween_property(self, "scale", SCALE_ON_BOSS_TURN, .7)
