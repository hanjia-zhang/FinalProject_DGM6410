extends Node2D


enum MissionType{
	KillAllEnemies,
	FindTheBomb,
}
onready var missionText = $"../GUI"
onready var arrpost =[$Position2D1,$Position2D2,$Position2D3,$Position2D4,$Position2D5,$Position2D6,$Position2D7,$Position2D8,$Position2D9,$Position2D10,$Position2D11,$Position2D12 ]
onready var passcode = [$Passcode,$Passcode2,$Passcode3,$Passcode4]
#onready var killProgress = missionText.get_node("MarginCaontainer/Rows/TopRow/KAEmission")
onready var bomb = $"../Bomb"

var numEnemiesKilled = 0
onready var numEnemiesToSpawn = 10
var RamdomPick:int

func _ready():
	randomize()
	arrpost.append($Position2D1)
	arrpost.append($Position2D2)
	arrpost.append($Position2D3)
	arrpost.append($Position2D4)
	arrpost.append($Position2D5)
	arrpost.append($Position2D6)
	arrpost.append($Position2D7)
	arrpost.append($Position2D8)
	arrpost.append($Position2D9)
	arrpost.append($Position2D10)
	arrpost.append($Position2D11)
	arrpost.append($Position2D12)
	
	passcode.append($Passcode)
	passcode.append($Passcode2)
	passcode.append($Passcode3)
	passcode.append($Passcode4)
#	arrpost =[$Position2D1,$Position2D2,$Position2D3,$Position2D4,$Position2D5,$Position2D6,$Position2D7,$Position2D8]
	randomMission()
	

	
	
func randomMission():
	RamdomPick = MissionType.values()[ randi()%MissionType.size() ]
	print("choosing mission")
# Use the randomly chosen value
	for i in 10:
		var item = randi() % arrpost.size()
		print(arrpost[item].name)
		var node = load("res://Objects/Enemy.tscn").instance()
		node.global_position = arrpost[item].global_position
		get_parent().add_child(node)
		arrpost.remove(item)
		
		node.connect("dead", self, "onEnemyKilled")
#		GlobalSignals.ms = "Kill All Enemies"
	if RamdomPick == MissionType.KillAllEnemies:
		print("KillAllEnemies was chosen!")
		missionText.setNewMission("Kill All Enemies")
		GlobalSignals.emit_signal("closeTimer")
		bomb.hide()

	else: 
		print("FindTheBomb was chosen!")
		missionText.setNewMission("Find The Bomb")
		GlobalSignals.emit_signal("closeKAEui")
		GlobalSignals.emit_signal("countDownStart")
		bomb.show()
		for i in 1:
			var item = randi() % passcode.size()
			print(passcode[item].name)
			var node = load("res://Objects/BombPasscode.tscn").instance()
			node.global_position = passcode[item].global_position
			get_parent().add_child(node)
			passcode.remove(item)
	
func onEnemyKilled():
	numEnemiesKilled += 1
	missionText.setRemainEnemy(str(numEnemiesKilled))
	print("Num enemies killed:", numEnemiesKilled)
	if numEnemiesKilled >= numEnemiesToSpawn and RamdomPick == MissionType.KillAllEnemies:
		get_tree().change_scene("res://LevelScenes/WinScene.tscn")
	
