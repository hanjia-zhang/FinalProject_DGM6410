extends Node2D

signal stateChange(newState)


enum State{ #set state to prepare for enemies to use
	PATROL,
	ENGAGE
}

onready var playerDectectionZone = $PlayerDetectionZone
onready var patrolTimer = $PatrolTimer

var currentState: int = -1 setget setState
var actor:KinematicBody2D = null
var player: Player = null #save off the player
var weapon: Weapon = null

# Partrol state
var origin: Vector2 = Vector2.ZERO #prepare for camping AI
var patrolLocation: Vector2 = Vector2.ZERO
var patrolLocationReached: bool = false
var actorVelocity: Vector2 = Vector2.ZERO

func _ready():
	setState(State.PATROL)
	

func _physics_process(delta):
	match currentState:
		State.PATROL:
			if not patrolLocationReached: # actually move by using distance_to
				actor.move_and_slide(actorVelocity)
				actor.rotateToward(patrolLocation)#rotate actor to actually paltrol location
				print("moveing")
				if actor.global_position.distance_to(patrolLocation) < 5:
					patrolLocationReached = true
					actorVelocity = Vector2.ZERO
					patrolTimer.start()
					print("start patrol")
		State.ENGAGE:
			if player != null and weapon != null:
				var angleToPlayer = actor.global_position.direction_to(player.global_position).angle()
				actor.rotateToward(player.global_position)#get direction from actor to player, and rotate actor to that way 
				if abs(actor.rotation - angleToPlayer) < 0.1:
					weapon.shoot()
			else:
				print("In the engage state but no weapon/player")
			print("Error, state not exist")

func initialize(actor, weapon: Weapon):
	self.actor = actor
	self.weapon = weapon
	weapon.connect("weaponOutOfAmmo", self, "handleReload")


func setState(newState: int): 
	if newState == currentState:
		return
	
	if newState == State.PATROL:
		origin = global_position
		patrolTimer.start()
		patrolLocationReached = true
	
	currentState = newState
	emit_signal("stateChange", currentState)
	
func handleReload():
	weapon.startReload()
	

func _on_PlayerDetectionZone_body_entered(body):#if player inter the zone, then attack
	if body.is_in_group("player"):
		setState(State.ENGAGE)
		player = body


func _on_PlayerDetectionZone_body_exited(body):
	if player and body == player:
		setState(State.PATROL)
		player = null


func _on_PatrolTimer_timeout(): # set up random paltrol directions
	var paltrolRange = 50
	var randomX = rand_range(-paltrolRange, paltrolRange)
	var randomY = rand_range(-paltrolRange, paltrolRange)
	
	patrolLocation = Vector2(randomX, randomY) + origin
	patrolLocationReached = false
	actorVelocity = actor.velocityToward(patrolLocation)
