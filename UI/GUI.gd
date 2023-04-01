extends CanvasLayer


onready var healthBar = $MarginContainer/Rows/BottomRow/HealthSection/HealthBar
onready var currentAmmo = $MarginContainer/Rows/BottomRow/AmmoSection/CurrentAmmo
onready var maxAmmo = $MarginContainer/Rows/BottomRow/AmmoSection/MaxAmmo
onready var healthTween = $MarginContainer/Rows/BottomRow/HealthSection/HealthTween
onready var missions = $MarginContainer/Rows/TopRow/HBoxContainer/Missions
onready var remain = $MarginContainer/Rows/TopRow/KAEmission2/remain
onready var kiaUI = $MarginContainer/Rows/TopRow/KAEmission2
onready var inGameMenu = $MarginContainer/Rows/MiddleRow/InGameMenuBG
onready var timerGUI = $MarginContainer/Rows/TopRow/timerGUi
var player:Player



func _ready():
	inGameMenu.hide()
	
func _process(delta):
	if Input.is_action_pressed("ESC"):
		inGameMenu.show()
	
func setPlayer(player: Player):
	self.player = player
	
	setNewHealthValue(player.healthStat.health)
	setCurrentAmmo(player.weapon.currentAmmo)
	setMaxAmmo(player.weapon.maxAmmo)
	
	player.connect("playerHealthChanged", self, "setNewHealthValue")
	player.weapon.connect("weaponAmmoChanged", self, "setCurrentAmmo")
	GlobalSignals.connect("closeKAEui", self, "hideKAEUI")
	GlobalSignals.connect("closeTimer",self,"hideTimer")
	
	
func setNewHealthValue(newHealth: int):
	var originalColor = Color("#ff0000")
	var highlightColor = Color("#db9494")
	
	var bar_style = healthBar.get("custom_styles/fg")
	healthTween.interpolate_property(healthBar, "value", healthBar.value, newHealth, 0.4,Tween.TRANS_LINEAR,Tween.EASE_IN)
	healthTween.interpolate_property(bar_style,"bg_color", originalColor, highlightColor, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	healthTween.interpolate_property(bar_style,"bg_color", highlightColor, originalColor, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.2)
	healthTween.start()

func setCurrentAmmo(newAmmo: int):
	currentAmmo.text = str(newAmmo)
	
func setMaxAmmo(newMaxAmmo: int):
	maxAmmo.text = str(newMaxAmmo)
	
func setNewMission(newText: String):
	missions.set_text(newText)
	
func setRemainEnemy(newText: String):
	remain.set_text(newText)

func hideKAEUI():
	kiaUI.visible = false

func hideTimer():
	timerGUI.visible = false

func _on_containuButton_pressed():
	inGameMenu.hide()


func _on_BackButton_pressed():
	get_tree().change_scene("res://LevelScenes/StartScene.tscn")
