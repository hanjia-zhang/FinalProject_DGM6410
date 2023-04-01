extends Node2D



onready var bulletManager = $BulletManager
onready var player: Player = $Player
onready var gui = $GUI
onready var missionsManager = $MissionsManager

var spawn_points = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	GlobalSignals.connect("bulletFired", bulletManager, "bulletSpwan")
	gui.setPlayer(player)
	missionsManager.randomMission()
	
	
#	for child in get_children():
#		if child is EnemySpawnPoint:
#			spawnPoints.append(child)
	
	# Spawn enemies at random spawn points
#	var numEnemiesToSpawn = 6
#	while numEnemiesToSpawn > 0:
#		var randomIndex = randi() % spawnPoints.size()
#		var spawnPoint = spawnPoints[randomIndex]
#		spawnPoint.emit_signal("spawn_enemy")
#		numEnemiesToSpawn -= 1
