
extends Node2D

const STAGE_2_SCENE := preload("res://stages/stage_2.tscn")
const STAGE_3_SCENE := preload("res://stages/stage_3.tscn")
const STAGE_4_SCENE := preload("res://stages/stage_4.tscn")

var current_stage := 0
var current_stage_node: Node = null
var game_started := false
var game_over := false

@onready var stage_container: Node2D = $StageContainer
@onready var welcome_ui: CanvasLayer = $UI
@onready var start_label: Label = $UI/StartLabel


func _ready() -> void:
	show_welcome()


func show_welcome() -> void:
	# Nos aseguramos de que el juego no quede pausado
	# al regresar a la pantalla principal.
	get_tree().paused = false
	
	game_started = false
	game_over = false
	
	if current_stage_node != null:
		current_stage_node.queue_free()
		current_stage_node = null
	
	stage_container.hide()
	welcome_ui.show()
	
	var tween := create_tween()
	tween.set_loops()
	tween.tween_property(start_label, "modulate:a", 0.2, 0.6)
	tween.tween_property(start_label, "modulate:a", 1.0, 0.6)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		
		# ENTER -> iniciar partida
		if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
			print("ENTER DETECTADO | game_started = ", game_started)
			
			if not game_started:
				start_game()


func toggle_pause() -> void:
	if not game_started:
		return
	
	get_tree().paused = not get_tree().paused
	
	if get_tree().paused:
		print("JUEGO PAUSADO")
	else:
		print("JUEGO REANUDADO")


func start_game() -> void:
	if game_started:
		return
	
	print("INICIANDO NUEVA PARTIDA")
	
	game_started = true
	game_over = false
	
	# Una nueva partida siempre comienza despausada.
	get_tree().paused = false
	
	current_stage = 2
	
	welcome_ui.hide()
	stage_container.show()
	
	load_stage(current_stage)


func load_stage(stage_number: int, previous_score: int = 0, previous_lives: int = 3) -> void:
	for group in ["player_bullets", "enemy_bullets"]:
		for bullet in get_tree().get_nodes_in_group(group):
			bullet.queue_free()
	if current_stage_node != null:
		current_stage_node.queue_free()
		current_stage_node = null
	
	match stage_number:
		2:
			current_stage_node = STAGE_2_SCENE.instantiate()
		3:
			current_stage_node = STAGE_3_SCENE.instantiate()

		4:
			current_stage_node = STAGE_4_SCENE.instantiate()
		
		_:
			print("STAGE NO DISPONIBLE: ", stage_number)
			return
	
	current_stage_node.score = previous_score
	current_stage_node.starting_lives = previous_lives
	stage_container.add_child(current_stage_node)
	
	# Conectar señal de Stage completado.
	if current_stage_node.has_signal("stage_completed"):
		current_stage_node.stage_completed.connect(_on_stage_completed)
	
	# Conectar señal de Game Over.
	if current_stage_node.has_signal("game_over"):
		current_stage_node.game_over.connect(_on_game_over)
		print("MAIN: señal game_over conectada")


func _on_stage_completed() -> void:
	if current_stage == 4:
		show_welcome()
		return
	var previous_score: int = current_stage_node.score
	var previous_lives: int = current_stage_node.get_node("Gyaraga").lives
	print("STAGE COMPLETADO: ", current_stage)
	
	current_stage += 1
	
	print("SIGUIENTE STAGE: ", current_stage)

	
	load_stage(current_stage)

	load_stage(current_stage, previous_score, previous_lives)



func _on_game_over() -> void:
	print("GAME OVER RECIBIDO POR MAIN")
	
	game_over = true
	game_started = false
	
	# Quitamos cualquier pausa antes de volver al menú.
	get_tree().paused = false
	
	show_welcome()
