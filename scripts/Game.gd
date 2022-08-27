extends Node

func init_administrators():
	for _i in 1:
		var administrator = Classes.Administrator.new()
		Global.array.administrator.append(administrator)

func init_tournament():
	Global.obj.tournament = Classes.Tournament.new()
	
	for administrator in Global.array.administrator:
		Global.obj.tournament.add_administrator(administrator)
		
	Global.obj.tournament.start()

func _ready():
	init_administrators()
	init_tournament()

func _input(event):
	if event is InputEventMouseButton:
		if Global.flag.click:
			pass
		else:
			Global.flag.click = !Global.flag.click

func _process(delta):
	pass

func _on_Timer_timeout():
	Global.node.TimeBar.value +=1
	
	if Global.node.TimeBar.value >= Global.node.TimeBar.max_value:
		Global.node.TimeBar.value -= Global.node.TimeBar.max_value
