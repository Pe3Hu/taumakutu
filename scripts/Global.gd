extends Node


var rng = RandomNumberGenerator.new()
var list = {}
var array = {}
var obj = {}
var node = {}
var flag = {}
var number = {}

func init_number():
	init_primary_key()
	
	number.size = {}
	number.pack = {}
	number.pack.total = 135 
	number.pack.count = 9
	number.pack.size = 3
	number.pack.max = 9
	number.pack.pool = 3
	number.pack.avg = number.pack.total / number.pack.count

func init_primary_key():
	number.primary_key = {}
	number.primary_key.administrator = 0

func init_list():
	init_window_size()

func init_window_size():
	list.window_size = {}
	list.window_size.width = ProjectSettings.get_setting("display/window/size/width")
	list.window_size.height = ProjectSettings.get_setting("display/window/size/height")
	list.window_size.center = Vector2(list.window_size.width/2, list.window_size.height/2)

func init_array():
	array.sequence = {} 
	array.sequence["A000040"] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
	array.sequence["A000045"] = [89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1]
	array.sequence["A000124"] = [7, 11, 16] #, 22, 29, 37, 46, 56, 67, 79, 92, 106, 121, 137, 154, 172, 191, 211]
	array.sequence["A001358"] = [4, 6, 9, 10, 14, 15, 21, 22, 25, 26]
	
	array.administrator = []
	array.pack = {}
	array.pack.shift = [-5,-4,-3,-2,-1,0,1,2,3,4,5]
	array.pack.rarity = [1,2,3,4,5,6,5,4,3,2,1]

func init_node():
	node.TimeBar = get_node("/root/Game/TimeBar") 
	node.Game = get_node("/root/Game") 

func init_flag():
	flag.click = false

func _ready():
	init_number()
	init_list()
	init_array()
	init_node()
	init_flag()
