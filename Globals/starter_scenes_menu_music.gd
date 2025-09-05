extends AudioStreamPlayer

func play_music(from_position: float = 0.0):
	if not playing:
		play(from_position)
