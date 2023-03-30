extends CanvasLayer


onready var healthBar = $MarginContainer/Rows/BottomRow/HealthSection/HealthBar
onready var currentAmmo = $MarginContainer/Rows/BottomRow/AmmoSection/CurrentAmmo
onready var maxAmmo = $MarginContainer/Rows/BottomRow/AmmoSection/MaxAmmo
onready var healthTween = $MarginContainer/Rows/BottomRow/HealthSection/HealthTween
onready var missions = $MarginContainer/Rows/TopRow/Missions

var player:Player


func setPlayer(player: Player):
	self.player = player
	
	setNewHealthValue(player.healthStat.health)
	setCurrentAmmo(player.weapon.currentAmmo)
	setMaxAmmo(player.weapon.maxAmmo)
	
	player.connect("playerHealthChanged", self, "setNewHealthValue")
	player.weapon.connect("weaponAmmoChanged", self, "setCurrentAmmo")
	
	
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
	
