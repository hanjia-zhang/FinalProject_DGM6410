extends KinematicBody2D


onready var healthStat = $Health

func handleHit():
	healthStat.health -= 20
	print("Enemy hit", healthStat.health)
	if healthStat.health <= 0:
		queue_free()
