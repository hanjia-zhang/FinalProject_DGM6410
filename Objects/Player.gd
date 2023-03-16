extends KinematicBody2D
class_name Player


var movespeed = 100 #move speed

onready var weapon = $Weapon
onready var healthStat = $Health


signal shotsFire (bullet, position, direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon.connect("weaponFired", self, "shoot")

func _physics_process(delta): #basic movements
		
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	
	motion = motion.normalized() #aviod the "double" speed when player hit such as "left and up" keys
	motion = move_and_slide(motion * movespeed)
	
	var lookAt = get_global_mouse_position() - global_position
	global_rotation = atan2(lookAt.y, lookAt.x)

func _unhandled_input(event):# setting up the shooting functionablities
	if event.is_action_pressed("shoot"):
		weapon.shoot()
		
		
func shoot(bulletInstace, location: Vector2, direction: Vector2): # instance the bullet
	emit_signal("shotsFire", bulletInstace, location, direction)

func handleHit():
	healthStat.health -= 20
	print("Player hit", healthStat.health)