extends Node2D


var spawn_nodes = []


# Called when the node enters the scene tree for the first time.
func _ready():

	# create an empty list to hold the spawn nodes
	randomize()

	# get all the nodes with the name "spawn"
	for node in get_tree().get_nodes_in_group("PlayerSpawnGroup"):
		spawn_nodes.append(node)
		print(node.name)

	if spawn_nodes.size() == 0:
		return Vector2.ZERO # or any default value you want to return
	spawn_player()	
func _physics_process(delta):
	if Input.is_action_just_released("spawnTest"):
		spawn_player()
# Select a random spawn point and set the player's position to that point
func spawn_player():
	# Randomly choose a spawn spot from the spawn nodes list
	var spawn_node = spawn_nodes[randi() % spawn_nodes.size()]
	
	# Set the player's position to the chosen spawn spot position
	var player = get_node("/root/MainLevel1/Player")
	player.position = spawn_node.position

