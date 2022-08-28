extends Node


var rng = RandomNumberGenerator.new()
var num = {}
var list = {}
var arr = {}
var obj = {}
var node = {}
var flag = {}

func init_num():
	init_primary_key()
	
	num.size = {}
	
	num.pack = {}
	num.pack.total = 135 
	num.pack.count = 9
	num.pack.size = 3
	num.pack.max = 9
	num.pack.pool = 3
	num.pack.avg = num.pack.total / num.pack.count
	
	num.goal = {}
	num.goal.shift = {}
	num.goal.shift.min = 12
	num.goal.shift.d = 2
	num.goal.shift.step = 1

func init_primary_key():
	num.primary_key = {}
	num.primary_key.administrator = 0

func init_list():
	init_window_size()

func init_window_size():
	list.window_size = {}
	list.window_size.width = ProjectSettings.get_setting("display/window/size/width")
	list.window_size.height = ProjectSettings.get_setting("display/window/size/height")
	list.window_size.center = Vector2(list.window_size.width/2, list.window_size.height/2)

func init_arr():
	arr.sequence = {} 
	arr.sequence["A000040"] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
	arr.sequence["A000045"] = [89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1]
	arr.sequence["A000124"] = [7, 11, 16] #, 22, 29, 37, 46, 56, 67, 79, 92, 106, 121, 137, 154, 172, 191, 211]
	arr.sequence["A001358"] = [4, 6, 9, 10, 14, 15, 21, 22, 25, 26]
	
	arr.administrator = []
	arr.pack = {}
	arr.pack.shift = [-5,-4,-3,-2,-1,0,1,2,3,4,5]
	arr.pack.rarity = [1,2,3,4,5,6,5,4,3,2,1]

func init_node():
	node.TimeBar = get_node("/root/Game/TimeBar") 
	node.Game = get_node("/root/Game") 

func init_flag():
	flag.click = false

func _ready():
	init_num()
	init_list()
	init_arr()
	init_node()
	init_flag()
