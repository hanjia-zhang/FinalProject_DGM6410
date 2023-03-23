extends Node2D
class_name Weapon

signal weaponOutOfAmmo

export (PackedScene) var Bullet # which can keep the data of other scenes

var maxAmmo: int = 10 
var currentAmmo: int = maxAmmo

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


func shoot():
	if currentAmmo != 0 and shotCoolDown.is_stopped() and Bullet != null:
		print("shot's fire")
		var bulletInstace = Bullet.instance()
		var direction = (gunDirection.global_position - gunBarrel.global_position).normalized()
		GlobalSignals.emit_signal("bulletFired", bulletInstace, gunBarrel.global_position, direction)
		shotCoolDown.start()# Set up limitation of "shots per second"
		flashAnimation.play("muzzleFlash")
		currentAmmo -= 1
		if currentAmmo == 0:
			emit_signal("weaponOutOfAmmo")
