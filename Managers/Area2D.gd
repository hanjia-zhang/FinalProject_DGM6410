extends Node2D

var numEnemiesSpawned = 0

func _on_SpawnPoint_body_entered(body):
	# Spawn a new enemy when a collision occurs
	# Replace this with your own code to spawn the enemy
	var new_enemy = load("res://Enemy.tscn").instance()
	get_parent().add_child(new_enemy)
	numEnemiesSpawned += 1

