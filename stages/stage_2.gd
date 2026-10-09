extends Node2D

const ENEMY_SCENE := preload("res://enemies/enemy.tscn")

@export var rows := 5
@export var columns := 8
@export var stage_number := 2
@export var attack_interval := 0.8
@export var max_attacks := 3
@export var start_x := 75.0
@export var start_y := 100.0
@export var spacing_x := 43.0
@export var spacing_y := 42.0
@export var entry_group_size := 8
@export var entry_group_delay := 0.35
@export var entry_start_delay := 0.15
var starting_lives := 3
var enemies: Array[Node] = []
var score := 0
var enemies_destroyed := 0
var is_stage_completed := false
signal stage_completed
signal game_over

func _ready() -> void:
	# Configurar las vidas iniciales.
	$Gyaraga.lives = starting_lives
	$HUD.update_lives(starting_lives)
	$HUD.update_score(score)
	$AttackTimer.wait_time = attack_interval
	$AttackTimer.max_simultaneous_attacks = max_attacks

	print("STAGE %d INICIADO" % stage_number)

	$Gyaraga.lives_changed.connect($HUD.update_lives)
	$Gyaraga.player_destroyed.connect(_on_player_destroyed)
	$StageLabel.text = "STAGE %d" % stage_number
	$StageLabel.visible = true

	await get_tree().create_timer(2.0).timeout
	if is_stage_completed or not is_inside_tree():
		return

	$StageLabel.visible = false

	await create_formation()
	if is_stage_completed or not is_inside_tree():
			return
	while not is_stage_completed and is_inside_tree():
			var enemies_still_entering := false

			for enemy in enemies:
				if not is_instance_valid(enemy):
					continue

				if enemy.state == enemy.State.ENTERING:
					enemies_still_entering = true
					break

			if not enemies_still_entering:
				break

			await get_tree().create_timer(0.1).timeout

	if is_stage_completed or not is_inside_tree():
			return

	$AttackTimer.start()
	print("Todos los enemigos llegaron a la formación.")
	print("Temporizador de ataques iniciado.")

func create_formation() -> void:
	var entry_queue: Array[Dictionary] = []
	var group_size := maxi(1, entry_group_size)

	for row in range(rows):
		for column in range(columns):

			var enemy = ENEMY_SCENE.instantiate()
			var formation_pos := Vector2(
				start_x + column * spacing_x,
				start_y + row * spacing_y
			)
			var enemy_type := get_enemy_type(row, column)

			$Enemies.add_child(enemy)

			var enters_from_left := (row + column) % 2 == 0
			var entry_y := (
				90.0
				+ column * 24.0
				+ row * 18.0
			)
			var start_position: Vector2

			if enters_from_left:
				start_position = Vector2(-50.0, entry_y)
			else:
				start_position = Vector2(730.0, entry_y)
			enemy.configure(enemy_type, formation_pos)
			enemy.visible = false
			enemy.enemy_destroyed.connect(_on_enemy_destroyed)
			enemies.append(enemy)
			entry_queue.append({
				"enemy": enemy,
				"start_position": start_position,
				"formation_position": formation_pos
			})

	print("Enemigos creados: ", enemies.size())

	for i in range(entry_queue.size()):
		if is_stage_completed or not is_inside_tree():
			return
		var entry: Dictionary = entry_queue[i]
		var enemy = entry["enemy"]
		if not is_instance_valid(enemy):
			continue
		enemy.start_entry(
			entry["start_position"],
			entry["formation_position"]
		)

		enemy.visible = true

		print(
			"Entrada iniciada: ",
			i + 1,
			"/",
			entry_queue.size()
		)

		if (i + 1) % group_size != 0:
			if i + 1 < entry_queue.size():
				await get_tree().create_timer(
					maxf(0.0, entry_start_delay)
				).timeout

		elif i + 1 < entry_queue.size():
			await get_tree().create_timer(
				maxf(0.0, entry_group_delay)
			).timeout

	print("Entrada de toda la formación iniciada.")

func get_enemy_type(row: int, column: int) -> int:
	if row == 0:
		if column == 3:
			return 0
		return 1

	if row == 1:
		if column % 2 == 0:
			return 4
		return 3

	return 2

func _on_enemy_destroyed(points_value: int) -> void:
	if is_stage_completed:
		return
	score += points_value
	$HUD.update_score(score)

	enemies_destroyed += 1

	print("Score: ", score)
	print(
		"Enemigos destruidos: ",
		enemies_destroyed,
		"/",
		rows * columns
	)

	if enemies_destroyed >= rows * columns:
		complete_stage()

func complete_stage() -> void:
	if is_stage_completed:
		return

	is_stage_completed = true

	print("==============================")
	print("STAGE %d COMPLETADO" % stage_number)
	print("==============================")

	$AttackTimer.stop()

	$StageLabel.text = "STAGE COMPLETE"
	$StageLabel.visible = true

	await get_tree().create_timer(2.0).timeout

	if not is_inside_tree():
		return

	stage_completed.emit()

func _on_player_destroyed() -> void:
	if is_stage_completed:
		return
	is_stage_completed = true
	print("GAME OVER: señal recibida del jugador")
	$AttackTimer.stop()
	$HUD.show_game_over()
	print("GAME OVER: mostrando mensaje")
	await get_tree().create_timer(2.0).timeout
	if not is_inside_tree():
		return

	print("GAME OVER: emitiendo señal hacia Main")

	game_over.emit()
