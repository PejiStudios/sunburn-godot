extends Node

var rng = RandomNumberGenerator.new()
var songs_list = []
var mazes_list = []
var sfx_list = []
var bootsound = true
var playing
var loadmus
var musID
var elpepe = false
var codes = ""



func _ready():
	l0nkLib.list_files("res://assets/mus/", songs_list, ".wav")
	l0nkLib.list_files("res://object/mazes/", mazes_list, ".tscn")
	l0nkLib.list_files("res://assets/sfx/", sfx_list, ".wav")
	$"/root/Level/elpepe".volume_db = -72.0
	playMus($"/root/Level/elpepe", 7, true)
	print(songs_list)
	print(mazes_list)
	print(sfx_list)

func _process(delta):
	print(musID)
	if "elpepe" in codes:
		elpepe = !elpepe
		codes = ""
		match elpepe:
			true:
				$"/root/Level/elpepe".volume_db = 0.0
				$"/root/Level/bckgndMus".volume_db = -72.0
			false:
				$"/root/Level/elpepe".volume_db = -72.0
				$"/root/Level/bckgndMus".volume_db = 0.0


func list_files(path: String, target: Array, filter: String):
	target.append(path)
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif filter == "none":
			target.append(file)
		elif file.ends_with(filter):
			target.append(file)
	dir.list_dir_end()

func get_file(origin: Array, index: int):
	return str(origin[0]) + str(origin[index])

func random_entry(origin: Array):
	return str(origin[0]) + str(origin[rng.randi_range(1,origin.size()-1)])

func playMus(player: AudioStreamPlayer,index: int, logging: bool):
	var list = sfx_list
	if logging:
		musID = index
		list = songs_list
	loadmus = load(get_file(list,index))
	if player.stream == loadmus && player.playing: pass
	else:
		player.stream = loadmus
		player.play()
	return index

func _unhandled_input(event):
	if Input.is_action_just_pressed("E"):
		codes += "e"
	if Input.is_action_just_pressed("L"):
		codes += "l"
	if Input.is_action_just_pressed("P"):
		codes += "p"
