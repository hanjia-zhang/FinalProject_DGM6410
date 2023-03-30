extends KinematicBody2D
class_name Player

signal playerHealthChanged(newHealth)

var movespeed = 100 #move speed

onready var weapon = $Weapon
onready var healthStat = $Health

var old_arr = []
func _physics_process(delta): #basic movements
	
	var arr = $VisionCone/Area2D.get_overlapping_bodies()

	var pzdao = false
	for i in old_arr:
		if is_instance_valid(i) and  i is Enemy:
			i.visible = false
	for i in arr:
		if i is Enemy:
			var space_rid = get_world_2d().space
			var space_state = Physics2DServer.space_get_direct_state(space_rid)
			var result = space_state.intersect_ray(global_position , i.global_position  )
			if not result.empty():
#				print(result.collider)
				result.collider.visible = true
	old_arr = arr
	
	
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
	elif event.is_action_pressed("reload"):
		weapon.startReload()

func handleHit():
	healthStat.health -= 20
	emit_signal("playerHealthChanged", healthStat.health)
	print("Player hit", healthStat.health)

func reload():
	weapon.startReload()
