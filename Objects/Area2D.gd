extends Area2D

onready var space_state = get_world_2d().direct_space_state

# Set the player and vision cone references in the editor
onready var player = $"../.."
onready var vision_cone = $".."

func _ready():
	set_process(true)
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")


func _on_Area2D_body_entered(body):
	pass
#	if body.has_method("show") and body.has_method("hide"):
#		if body.get_collision_layer() == 1 << 0:
#			body.hide()  # Hide the enemy by default
#			# Check if the enemy is visible to the player
#			if is_enemy_visible(body):
#				body.show()  # Show the enemy if it's within the vision cone



func _on_Area2D_body_exited(body):
	pass
#	if body is Node2D and body.has_method("show") and body.has_method("hide"):
#		if body.get_collision_layer() & (1 << 0): # Check if the enemy is on the correct layer
#			body.show()

	

func is_enemy_visible(enemy):
	# Get the enemy's position and direction vector
	var enemy_pos = enemy.global_position
	var enemy_dir = (enemy_pos - player.global_position).normalized()

	# Perform a raycast from the player to the enemy
	var result = space_state.intersect_ray(player.global_position, enemy_pos, [3], true, true)
	if result:
		# Check if the ray hit a wall before reaching the enemy
		var wall_pos = result["position"]
		if (wall_pos - player.global_position).length() < (enemy_pos - player.global_position).length():
			return false

	# Check if the enemy is within the vision cone
	var angle = vision_cone.rotation
	var angle_to_enemy = player.global_position.angle_to(enemy_pos)
	var angle_diff = abs(angle_to_enemy - angle)
	if angle_diff > vision_cone.get_texture().get_width() / 2:
		return false

	return true




	




	




