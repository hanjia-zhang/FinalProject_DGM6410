extends Node2D


onready var bulletManager = $BulletManager
onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("shotsFire", bulletManager, "bulletSpwan")
