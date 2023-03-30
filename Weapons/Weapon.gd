extends Node2D
class_name Weapon

signal weaponAmmoChanged(newAmmoCount)
signal weaponOutOfAmmo

export (PackedScene) var Bullet # which can keep the data of other scenes

var maxAmmo: int = 10 
var currentAmmo: int = maxAmmo setget setCurrentAmmo

onready var gunBarrel = $GunBarrel #get reference of the bullet start position
onready var gunDirection = $GunDirection
onready var shotCoolDown = $ShotCoolDown
onready var flashAnimation = $FlashAnimation
onready var muzzleFlash = $MuzzleFlash

func _ready():
	muzzleFlash.hide()

func startReload():
	flashAnimation.play("reload")
	
func stopReload():
	currentAmmo = maxAmmo
	emit_signal("weaponAmmoChanged", currentAmmo)

func setCurrentAmmo(newAmmo: int):
	var actualAmmo = clamp(newAmmo, 0, maxAmmo)
	if actualAmmo != currentAmmo:
		currentAmmo = actualAmmo
		if currentAmmo == 0:
			emit_signal("weaponOutOfAmmo")
		
		emit_signal("weaponAmmoChanged", currentAmmo)
			

func shoot():
	if currentAmmo != 0 and shotCoolDown.is_stopped() and Bullet != null:
		print("shot's fire")
		var bulletInstace = Bullet.instance()
		var direction = (gunDirection.global_position - gunBarrel.global_position).normalized()
		GlobalSignals.emit_signal("bulletFired", bulletInstace, gunBarrel.global_position, direction)
		shotCoolDown.start()# Set up limitation of "shots per second"
		flashAnimation.play("muzzleFlash")
		setCurrentAmmo(currentAmmo - 1)
		
