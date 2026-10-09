extends Area2D

@export var speed := 350.0

var direction := Vector2.DOWN

func _ready() -> void:
	add_to_group("enemy_bullets")
	direction = direction.normalized()

func _process(delta: float) -> void:
	position += direction * speed * delta

	if position.y > 672 or position.x < -50 or position.x > 770:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("BALA ENEMIGA COLISIONÓ CON: ", body.name)

	if body.is_in_group("player"):
		body.hit_by_enemy()
		queue_free()
