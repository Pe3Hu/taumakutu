extends Node


class Administrator:
	var num = {}
	var arr = {}
	var obj = {}

	func _init():
		num.index = Global.num.primary_key.administrator
		Global.num.primary_key.administrator += 1
		arr.pack = []
		arr.goal = []
		obj.tournament = null
		obj.lap = null
		num.grade = 1
		set_result()

	func set_result():
		var input = {}
		input.administrator = self
		obj.result = Classes.Result.new(input)

	func add_goal():
		var input = {}
		input.administrator = self
		input.grade = num.grade
		var goal = Classes.Goal.new(input)
		arr.goal.append(goal)

	func remove_goal(goal_):
		arr.goal.remove(goal_)

class Result:
	var num = {}
	var obj = {}

	func _init(input_):
		num.value = 0
		obj.administrator = input_.administrator

	func calc_value():
		pass

	func get_value():
		calc_value()
		return num.value

class Card:
	var string = {}
	
	func _init(input_):
		string.name = ""

class Content:
	var string = {}
	var obj = {}

	func _init(input_):
		string.value = str(input_.value)
		string.type = input_.type#digit or operation
		obj.owner = null

	func add_to_value(value_):
		string.value = str(int(string.value)+value_)

	func set_owner(owner_):
		obj.owner = owner_

class Lap:
	var arr = {}
	var obj = {}

	func _init(input_):
		obj.tournament = input_.owner
		arr.administrator = input_.administrator
	
	func start():
		set_goals()
		print(arr.administrator[0].arr.pack.size())
		pass

	func set_goals():
		for administrator in arr.administrator: 
			administrator.add_goal()

class Tournament:
	var arr = {}
	var num = {}

	func _init():
		arr.administrator = []
		arr.lap = []
		num.lap = 1

	func add_administrator(administrator_):
		arr.administrator.append(administrator_)
		administrator_.obj.tournament = self

	func start_preparation():
		for administrator in arr.administrator:
			var input = {}
			input.tournament = self
			input.administrator = administrator
			var preparation = Classes.Preparation.new(input)

	func start_laps():
		for _i in num.lap:
			var input = {}
			input.owner = self
			input.administrator = arr.administrator.duplicate(true) 
			var lap = Classes.Lap.new(input)
			arr.lap.append(lap)
			lap.start()

	func start():
		start_preparation()
		start_laps()

class Preparation:
	var arr = {}
	var obj = {}
	var num = {}

	func _init(input_):
		obj.tournament = input_.tournament
		obj.administrator = input_.administrator
		num.total = Global.num.pack.total
		create_packs()

	func create_packs():
		obj.administrator.arr.pack = []
		
		while num.total > 0:
			var total = num.total
			
			if total > Global.num.pack.avg + Global.arr.pack.shift.back():
				total = Global.num.pack.avg 
				var options = []
				
				for _i in Global.arr.pack.shift.size():
					for _j in Global.arr.pack.rarity[_i]:
						options.append(Global.arr.pack.shift[_i])
				
				Global.rng.randomize()
				var index_r = Global.rng.randi_range(0, options.size()-1)
				total += options[index_r]
			
			var packs = []
			
			for _i in Global.num.pack.pool:
				packs.append([])
				
				for _j in Global.num.pack.size:
					var input = {}
					input.total = total
					input.type = "digit"
					var pack = Classes.Pack.new(input)
					packs[_i].append(pack)
			
			choose_pack(packs)
			num.total -= total

	func choose_pack(packs_):
		var pack = packs_[0]
		obj.administrator.arr.pack.append_array(pack)

class Pack:
	var num = {}
	var arr = {}
	var string = {}
	
	func _init(input_):
		num.total = input_.total
		num.current = input_.total
		string.type = input_.type
		arr.content = []
		generate()
		calc_dispersion()
	
	func generate():
		match string.type:
			"digit":
				for _i in Global.num.pack.size:
					var input = {}
					input.value = 1
					input.type = string.type
					var content = Classes.Content.new(input)
					arr.content.append(content)
					num.current -= input.value
				
				var step = 1
				
				while num.current > 0:
					var options = []
					for content in arr.content:
						if int(content.string.value) < Global.num.pack.max:
							options.append(content)
					
					Global.rng.randomize()
					var index_r = Global.rng.randi_range(0, options.size()-1)
					options[index_r].add_to_value(step)
					num.current -= step
				
				if num.current != 0:
					print("pack error -> generate() -> current != 0")

	func calc_dispersion():
		num.dispersion = 0
		num.avg = float(num.total)/float(arr.content.size())
		
		for content in arr.content: 
			var deviation = num.avg - int(content.string.value)
			num.dispersion += pow(deviation,2)/arr.content.size()
		
#		var arr = []
#		for content in arr.content:
#			arr.append(content.string.value)
#		print(arr,num.dispersion)
		pass

class Goal:
	var num = {}
	var arr = {}
	var obj = {}
	var flag = {}

	func _init(input_):
		obj.administrator = input_.administrator
		num.grade = input_.grade
		num.cols = input_.grade
		num.rows = input_.grade
		arr.target = []
		flag.fill = false
		generate()

	func generate():
		var options = []
		var anchors = []
		var tournament = obj.administrator.obj.tournament
		
		for administrator in tournament.arr.administrator:
			var anchor = administrator.obj.result.get_value()
			anchors.append(anchor)
		
		print(anchors)
		
		for anchor in anchors:
			var scales = [1,-1]
			var values = []
			
			for scale in scales:
				var a = anchor + (Global.num.goal.shift.min + num.grade) * scale
				var b = a + (Global.num.goal.shift.d + num.grade) * scale
				var min_ = min(a,b)
				var max_ = max(a,b)
				
				for value in range(min_,max_):
					values.append(value)
			
			print(values)
		

	func filling_check():
		flag.fill = true
		
		for targets in arr.target:
			for target in targets:
				flag.fill = flag.fill && target.flag.realised
				

class Target:
	var num = {}
	var flag = {}
	var obj = {}

	func _init(input_):
		obj.goal = input_.goal
		num.value = input_.value
		flag.realised = false

	func check(value_):
		if !flag.realised:
			flag.realised = num.value == value_

class Sorter:
    static func sort_ascending(a, b):
        if a.value < b.value:
            return true
        return false

    static func sort_descending(a, b):
        if a.value > b.value:
            return true
        return false
