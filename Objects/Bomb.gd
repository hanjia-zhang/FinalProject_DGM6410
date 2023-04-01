extends Node2D

onready var instructionPickUp = $Label
onready var noPasscode = $Label2
var isEnter = false
var isPickedUp = false


func _ready():
	instructionPickUp.hide()
	noPasscode.hide()
	GlobalSignals.connect("gotPasscode", self, "getPermision")
func _process(delta):
	
	if Input.is_action_just_pressed("PickUp") and isEnter == true and isPickedUp == true:
		queue_free()
		get_tree().change_scene("res://LevelScenes/WinScene.tscn")


func _on_Area2D_body_entered(body):
	if isPickedUp == false: 
		noPasscode.show()
	else:
		instructionPickUp.show()
		isEnter = true


func _on_Area2D_body_exited(body):
	instructionPickUp.hide()
	noPasscode.hide()
	isEnter = false
	
func getPermision():
	isPickedUp = true
