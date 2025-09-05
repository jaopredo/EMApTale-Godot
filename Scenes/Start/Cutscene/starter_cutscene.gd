extends Control

@onready var cutscene_images = [
	load("res://Sprites/Cutscene/c11.png"),
	load("res://Sprites/Cutscene/c12.png"),
	load("res://Sprites/Cutscene/c16.png"),
	load("res://Sprites/Cutscene/c15.png"),
]

@onready var texts = [
	"Bem vindo a Fundação Getulio Vargas! Após um longo semestre você se encontra em uma situação difícil...",
	"Conseguiu, com muito esforço, conquistar um CR 5.9, mas você precisa mais do que isso!",
	"Buscando a redenção, você pretende encarar as AS para se provar digno de um CR 7+",
	"Mas não tenha otimismo, pois 5 Entidades da EMAp tentarão impedi-lo de conseguir! Boa sorte!",
]

@onready var actual_scene = 0
@onready var letters_per_second = 20
@onready var cutscene_phase = 0
@onready var times_logo_showed = 0


func _ready() -> void:
	$CutsceneText.restart(
		texts[0],
		letters_per_second
	)
	
	StarterScenesMenuMusic.stop()


func _on_cutscene_text_text_endedup_showing() -> void:
	$ChangeTextTimer.start()
	if actual_scene != cutscene_images.size() - 1:
		var tweener = get_tree().create_tween()
		tweener.tween_property($ContextImage, "modulate:a", 0, 2)


func _on_change_text_timer_timeout() -> void:
	actual_scene += 1
	
	if actual_scene == cutscene_images.size():
		$FinalImpactSceneTimer.start()
		return
	
	$CutsceneText.restart(
		texts[actual_scene],
		letters_per_second
	)
	$ContextImage.texture = cutscene_images[actual_scene]
	
	var tweener = get_tree().create_tween()
	tweener.tween_property($ContextImage, "modulate:a", 1, .5)


func _on_final_impact_scene_timer_timeout() -> void:
	var filter_tweener = get_tree().create_tween()
	filter_tweener.tween_property($ContextImage, "modulate:a", 0, 1)
	
	var text_tweener = get_tree().create_tween()
	text_tweener.tween_property($CutsceneText, "modulate:a", 0, 1)
	$BackgroundMusic.volume_linear
	var volume_tweener = get_tree().create_tween()
	volume_tweener.tween_property($BackgroundMusic, "volume_linear", 0, 2)
	
	$FinalSceneTimer.start()


func _on_final_scene_timer_timeout() -> void:
	times_logo_showed += 1
	$IntroNoise.play()
	$Logo.visible = !$Logo.visible

func _on_intro_noise_finished() -> void:
	if times_logo_showed < 2:
		$FinalSceneTimer.start()
	if times_logo_showed >= 2:
		$ChangeSceneTimer.start()


func _on_change_scene_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/EMAp/EMAp.tscn")
