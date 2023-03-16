extends Node2D


export (int) var health = 100 setget setHealth


func setHealth(newHealth: int):
	health = clamp(newHealth, 0 , 100)
	
