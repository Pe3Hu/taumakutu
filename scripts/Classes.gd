extends Node


class Administrator:
	var number = {}

	func _init():
		number.index = Global.number.primary_key.administrator
		Global.number.primary_key.administrator += 1

class Result:
	var number = {}
	var obj = {}

	func _init(input_):
		number.value = 0
		obj.parent = input_.parent

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
	var array = {}
	var obj = {}

	func _init(input_):
		obj.owner = input_.owner
		array.administrator = input_.administrator
	
	func start():
		pass

class Tournament:
	var array = {}
	var number = {}

	func _init():
		array.administrator = []
		array.lap = []
		number.lap = 1

	func add_administrator(administrator_):
		array.administrator.append(administrator_)

	func start_preparation():
		for administrator in array.administrator:
			var input = {}
			input.tournament = self
			input.administrator = administrator
			var preparation = Classes.Preparation.new(input)

	func start_laps():
		for _i in number.lap:
			var input = {}
			input.owner = self
			input.administrator = array.administrator.duplicate(true) 
			var lap = Classes.Lap.new(input)
			array.lap.append(lap)
			lap.start()

	func start():
		start_preparation()
		start_laps()

class Preparation:
	var array = {}
	var obj = {}
	var number = {}

	func _init(input_):
		obj.tournament = input_.tournament
		obj.administrator = input_.administrator
		number.total = Global.number.pack.total
		
		create_packs()

	func create_packs():
		while number.total > 0:
			var total = number.total
			
			if total > Global.number.pack.avg + Global.array.pack.shift.back():
				total = Global.number.pack.avg 
				var options = []
				
				for _i in Global.array.pack.shift.size():
					for _j in Global.array.pack.rarity[_i]:
						options.append(Global.array.pack.shift[_i])
						
				Global.rng.randomize()
				var index_r = Global.rng.randi_range(0, options.size()-1)
				total += options[index_r]
			
			var packs = []
			
			for _i in Global.number.pack.pool:
				var input = {}
				input.total = total
				input.type = "digit"
				var pack = Classes.Pack.new(input)
			
			number.total -= total
			print(number.total)

class Pack:
	var number = {}
	var array = {}
	var string = {}
	
	func _init(input_):
		number.total = input_.total
		number.current = input_.total
		string.type = input_.type
		array.content = []
		generate()
		calc_dispersion()
	
	func generate():
		match string.type:
			"digit":
				for _i in Global.number.pack.size:
					var input = {}
					input.value = 1
					input.type = string.type
					var content = Classes.Content.new(input)
					array.content.append(content)
					number.current -= input.value
				
				var step = 1
				
				while number.current > 0:
					var options = []
					for content in array.content:
						if int(content.string.value) < Global.number.pack.max:
							options.append(content)
					
					Global.rng.randomize()
					var index_r = Global.rng.randi_range(0, options.size()-1)
					options[index_r].add_to_value(step)
					number.current -= step
				
				if number.current != 0:
					print("pack error -> generate() -> current != 0")
				

	func calc_dispersion():
		number.dispersion = 0
		number.avg = float(number.total)/float(array.content.size())
		
		for content in array.content: 
			var deviation = number.avg - int(content.string.value)
			number.dispersion += pow(deviation,2)/array.content.size()
		
		var arr = []
		for content in array.content:
			arr.append(content.string.value)
		print(arr,number.dispersion)

class Sorter:
    static func sort_ascending(a, b):
        if a.value < b.value:
            return true
        return false

    static func sort_descending(a, b):
        if a.value > b.value:
            return true
        return false
