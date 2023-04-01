extends CanvasLayer


onready var crditPage = $crditBG

func _ready():
	crditPage.hide()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://LevelScenes/MainLevel1.tscn")


func _on_CreditButton2_pressed():
	crditPage.show()


func _on_CloseButton_pressed():
	crditPage.hide()
