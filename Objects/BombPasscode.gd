extends Node2D

onready var instruction = $Label

var isEnter = false

func _ready():
	instruction.hide()

func _process(delta):
	if Input.is_action_just_pressed("PickUp") and isEnter == true:
		queue_free()
		GlobalSignals.emit_signal("gotPasscode")

func _on_Area2D_body_entered(body):
	instruction.show()
	isEnter = true

func _on_Area2D_body_exited(body):
	instruction.hide()
	isEnter = false
