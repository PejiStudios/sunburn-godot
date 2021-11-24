extends Node

var rng = RandomNumberGenerator.new()
var bootsound = true
var playing
var loadmus
var musID
var elpepe = false

func _ready():
	pass


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

func playMus(player: AudioStreamPlayer,origin: Array,index: int):
	loadmus = load(get_file(origin,index))
	musID = index
	if player.stream == loadmus && player.playing:
		pass
	else:
		player.stream = loadmus
		player.play()
	return index

