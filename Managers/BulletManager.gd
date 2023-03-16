extends Node2D


func bulletSpwan(bullet:Bullet, position, direction):
	add_child(bullet)
	bullet.global_position = position
	bullet.setDirection(direction)
