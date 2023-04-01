extends Label


var time = 600
var timerOn = false

func _ready():
	GlobalSignals.connect("countDownStart",self,"count")

func _process(delta):
	if(timerOn):
		time -= delta
		if time < 0:
			get_tree().change_scene("res://LevelScenes/LossScene.tscn")
	
	var mils = fmod(time,1)*100	
	var secs = fmod(time, 60)
	var mins = fmod(time,60*60) / 60
	var timePassed = "%02d : %02d : %02d" % [mins,secs,mils]
	text = timePassed
	
func count():
	timerOn = true
