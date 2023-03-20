extends Node2D

export var num_enemies = 10

var enemy_scene = preload("res://Objects/Enemy.tscn")

func _ready():
	randomize()
	spawn_enemy()

func _physics_process(delta):
	if Input.is_action_just_released("spawnTest"):
		spawn_enemy()
		reset_enemies()

func spawn_enemy():
	var shape = $SpawnArea.get_node("CollisionShape2D").shape
	var area_rect = Rect2($SpawnArea.position + $SpawnArea.get_node("CollisionShape2D").position - shape.extents, shape.extents * 2)
	var enemy_count = 0
	
	for i in range(num_enemies):
		var enemy = enemy_scene.instance()
		var enemy_pos = Vector2(rand_range(area_rect.position.x, area_rect.position.x + area_rect.size.x),rand_range(area_rect.position.y, area_rect.position.y + area_rect.size.y))
		enemy.position = enemy_pos
		add_child(enemy)
		enemy_count += 1
		
	print("Spawned ", enemy_count, " enemies.")

func reset_enemies():
	# Delete all enemy nodes
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()

	# Respawn enemies
	spawn_enemy()
