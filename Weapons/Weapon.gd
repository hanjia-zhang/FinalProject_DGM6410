extends Node2D

signal weaponFired(bullet, location, direction)

export (PackedScene) var Bullet # which can keep the data of other scenes

onready var gunBarrel = $GunBarrel #get reference of the bullet start position
onready var gunDirection = $GunDirection
onready var shotCoolDown = $ShotCoolDown
onready var flashAnimation = $FlashAnimation



func shoot():
	if shotCoolDown.is_stopped() and Bullet != null:
		print("shot's fire")
		var bulletInstace = Bullet.instance()
		var direction = (gunDirection.global_position - gunBarrel.global_position).normalized()
		emit_signal("weaponFired", bulletInstace, gunBarrel.global_position, direction)
		shotCoolDown.start()# Set up limitation of "shots per second"
		flashAnimation.play("muzzleFlash")