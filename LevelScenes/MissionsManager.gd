extends Node2D


enum MissionType{
	KillAllEnemies,
	FindTheBomb,
}
onready var missionText = $"../GUI"
onready var arrpost =[$Position2D1,$Position2D2,$Position2D3,$Position2D4,$Position2D5,$Position2D6,$Position2D7,$Position2D8]

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
#	arrpost =[$Position2D1,$Position2D2,$Position2D3,$Position2D4,$Position2D5,$Position2D6,$Position2D7,$Position2D8]
	randomMission()

func randomMission():

	
	var RamdomPick:int = MissionType.values()[ randi()%MissionType.size() ]
	print("choosing mission")
# Use the randomly chosen value
	for i in 6:
		var item = randi() % arrpost.size()
		print(arrpost[item].name)
		var node = load("res://Objects/Enemy.tscn").instance()
		node.global_position = arrpost[item].global_position
		get_parent().add_child(node)
		arrpost.remove(item)
#		GlobalSignals.ms = "Kill All Enemies"
	if RamdomPick == MissionType.KillAllEnemies:
		print("KillAllEnemies was chosen!")
		
		missionText.setNewMission("Kill All Enemies")
	else: 
		print("FindTheBomb was chosen!")
		missionText.setNewMission("Find The Bomb")
