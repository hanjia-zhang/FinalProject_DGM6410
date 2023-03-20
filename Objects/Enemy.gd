extends KinematicBody2D


onready var healthStat = $Health
onready var ai = $AI
onready var weapon = $Weapon

export (int) var speed = 100

func _ready():
	ai.initialize(self, weapon)

func rotateToward(location: Vector2):
	rotation = lerp(rotation, global_position.direction_to(location).angle(), 0.1)#rotate actor to actually paltrol location

func velocityToward(location: Vector2):
	return global_position.direction_to(location) * 100

func handleHit():
	healthStat.health -= 20
	print("Enemy hit", healthStat.health)
	if healthStat.health <= 0:
		queue_free()
