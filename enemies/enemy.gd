extends Area2D

signal enemy_destroyed(points_value: int)

enum State {
	ENTERING,
	FORMATION,
	ATTACKING,
	RETURNING
}

enum EnemyType {
	BOSS,
	GOEI,
	YAKO,
	SCORPION,
	MOMIJI
}

@export var speed := 100.0
@export var points := 100
@export var entry_duration := 0.8
@export var attack_duration := 1.5
@export var return_duration := 1.5

var state: State = State.ENTERING
var enemy_type: EnemyType = EnemyType.GOEI
var formation_position := Vector2.ZERO
var entry_start_position := Vector2.ZERO
var entry_time := 0.0
var attack_time := 0.0
var return_time := 0.0
var return_start_position := Vector2.ZERO
var attack_path: Curve2D
var return_path: Curve2D
var has_shot_during_attack := false
var is_being_hit := false

var enemy_textures: Array[Texture2D] = [
	preload("res://assets/enemies/BossGalaga.png"),
	preload("res://assets/enemies/Goei.png"),
	preload("res://assets/enemies/Yako.png"),
	preload("res://assets/enemies/Scorpion.png"),
	preload("res://assets/enemies/Momiji.png")
]

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	add_to_group("enemies")

	sprite.visible = true
	sprite.hframes = 8
	sprite.vframes = 1
	sprite.frame = 0
	sprite.scale = Vector2(1.5, 1.5)

func configure(type: int, formation_pos: Vector2) -> void:
	enemy_type = type as EnemyType
	formation_position = formation_pos

	global_position = formation_pos

	sprite.texture = enemy_textures[enemy_type]
	sprite.hframes = 8
	sprite.vframes = 1
	sprite.frame = 0

func start_entry(
	start_position: Vector2,
	target_position: Vector2
) -> void:
	entry_start_position = start_position
	formation_position = target_position

	global_position = entry_start_position
	entry_time = 0.0
	state = State.ENTERING

func _process(delta: float) -> void:
	match state:
		State.ENTERING:
			update_entry(delta)

		State.FORMATION:
			pass

		State.ATTACKING:
			update_attack(delta)

		State.RETURNING:
			update_return(delta)

func update_entry(delta: float) -> void:
	entry_time += delta

	var t := clampf(entry_time / entry_duration, 0.0, 1.0)

	var position := entry_start_position.lerp(
		formation_position,
		t
	)

	position.y -= sin(t * PI) * 100.0

	global_position = position

	if t >= 1.0:
		global_position = formation_position
		sprite.rotation = 0.0
		state = State.FORMATION

func get_attack_direction() -> Vector2:
	var viewport_width := get_viewport_rect().size.x
	var center_x := viewport_width / 2.0

	if global_position.x < center_x:
		return Vector2.RIGHT

	return Vector2.LEFT

func create_flight_path(
	start: Vector2,
	control_1: Vector2,
	control_2: Vector2,
	target: Vector2
) -> Curve2D:
	var path := Curve2D.new()
	path.bake_interval = 2.0

	path.add_point(
		start,
		Vector2.ZERO,
		control_1 - start
	)

	path.add_point(
		target,
		control_2 - target,
		Vector2.ZERO
	)

	return path

func start_attack() -> void:
	if state != State.FORMATION:
		return

	state = State.ATTACKING
	attack_time = 0.0
	has_shot_during_attack = false

	var start := global_position
	var side := get_attack_direction().x
	var center_x := get_viewport_rect().size.x / 2.0

	if absf(start.x - center_x) < 30.0:
		side = [-1.0, 1.0][randi_range(0, 1)]

	var horizontal_distance: float
	var vertical_distance: float
	var curve_strength: float

	match randi_range(0, 2):
		0:
			horizontal_distance = 120.0
			vertical_distance = 220.0
			curve_strength = 180.0

		1:
			horizontal_distance = 180.0
			vertical_distance = 250.0
			curve_strength = 100.0

		2:
			horizontal_distance = 100.0
			vertical_distance = 200.0
			curve_strength = 260.0

	var target := start + Vector2(
		side * horizontal_distance,
		vertical_distance
	)

	var control_1 := start + Vector2(
		side * curve_strength,
		40.0
	)

	var control_2 := target + Vector2(
		-side * curve_strength * 0.8,
		-60.0
	)

	attack_path = create_flight_path(
		start,
		control_1,
		control_2,
		target
	)

func update_attack(delta: float) -> void:
	if attack_path == null:
		return

	attack_time += delta

	var t := clampf(
		attack_time / attack_duration,
		0.0,
		1.0
	)

	var path_length := attack_path.get_baked_length()
	var distance := t * path_length

	global_position = attack_path.sample_baked(
		distance,
		true
	)
	orient_sprite(attack_path, distance)

	if t >= 0.5 and not has_shot_during_attack:
		has_shot_during_attack = true
		shoot()

	if t >= 1.0:
		return_start_position = global_position
		return_time = 0.0

		return_path = create_flight_path(
			return_start_position,
			return_start_position + Vector2(0.0, -100.0),
			formation_position + Vector2(0.0, 100.0),
			formation_position
		)

		state = State.RETURNING

func update_return(delta: float) -> void:
	if return_path == null:
		return

	return_time += delta

	var t := clampf(
		return_time / return_duration,
		0.0,
		1.0
	)

	var path_length := return_path.get_baked_length()
	var distance := t * path_length

	global_position = return_path.sample_baked(
		distance,
		true
	)

	orient_sprite(return_path, distance)

	if t >= 1.0:
		global_position = formation_position
		sprite.rotation = 0.0

		attack_path = null
		return_path = null

		state = State.FORMATION


func orient_sprite(path: Curve2D, distance: float) -> void:
	var path_length := path.get_baked_length()

	var behind := path.sample_baked(
		maxf(0.0, distance - 3.0),
		true
	)

	var ahead := path.sample_baked(
		minf(path_length, distance + 3.0),
		true
	)

	var direction := ahead - behind

	if direction.length_squared() > 0.001:
		sprite.rotation = roundf(
			(direction.angle() - PI / 2.0) / (PI / 4.0)
		) * (PI / 4.0)

func shoot() -> void:
	var bullet_scene: PackedScene = load(
		"res://bullets/enemy_bullet.tscn"
	)

	if bullet_scene == null:
		push_warning("No se encontró enemy_bullet.tscn")
		return

	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)

	bullet.global_position = global_position

	# Buscar al jugador.
	var player := get_tree().get_first_node_in_group("player")

	if player == null:
		bullet.direction = Vector2.DOWN
		return

	# Calcular la dirección desde el enemigo hasta el jugador.
	var target_direction: Vector2 = (
		player.global_position - global_position
	).normalized()
	
	var horizontal_variation: float = [-0.20, 0.0, 0.20][
	randi_range(0, 2)
	]

	var shot_direction := Vector2(
		target_direction.x + horizontal_variation,
		target_direction.y
	)

	bullet.direction = shot_direction.normalized()

func hit() -> void:
	if is_being_hit:
		return

	is_being_hit = true
	enemy_destroyed.emit(points)

	$HitSound.play()
	await $HitSound.finished

	queue_free()
