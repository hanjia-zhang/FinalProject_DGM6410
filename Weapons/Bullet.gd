extends Area2D
class_name Bullet

var direction := Vector2.ZERO
var speed = 10

onready var destroyTimer = $DestroyTimer

func _ready():
	destroyTimer.start()

func  _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity
	
	
func setDirection(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func _on_DestroyTimer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.has_method("handleHit"): #Using duck method to check what property it has
		body.handleHit()
		queue_free()
