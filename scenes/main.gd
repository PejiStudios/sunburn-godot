extends Node2D

var worldstate
var worldspeed
var is_just_starting = true
signal die

func _ready() -> void:
	l0nkLib.playMus($bckgndMus, 6, true)
	worldstate = "menu"
	gen_maze()


func _process(delta):
	match worldstate:
		"menu":
			waitfor_start()
		"heating":
			game_process(delta)
		"calm":
			grace_process(delta)

func waitfor_start():
	worldspeed = 0
	$camera/background_texture/animation.stop()
	$camera/background_texture.modulate = Color(1,1,1,1)
	if $Player.position.y >= 180:
		worldstate = "heating"
		$camera/background_texture/animation.play("heatup")
		l0nkLib.playMus($bckgndMus, 5, true)

func game_process(delta):
	if worldspeed >= 45:
		worldspeed = 45
	elif worldspeed < 15:
		worldspeed = 15
	else: worldspeed += 0.7840997124 * delta


func grace_process(delta):
	pass

func touched_sun():
	emit_signal("die")
	print("sun")
	is_just_starting = true
	if worldstate == "menu": return
	worldstate = "menu"
	for _i in $maze_generation.get_children():
		_i.queue_free()
	gen_maze()
	l0nkLib.playMus($bckgndMus, 6, true)

func gen_maze(index = l0nkLib.rng.randi_range(1,l0nkLib.mazes_list.size()-1)):
	var rand_maze = str(l0nkLib.mazes_list[0]) + str(l0nkLib.mazes_list[index])
	print(l0nkLib.mazes_list)
	print(rand_maze)
	var new_maze = load(rand_maze).instance()
	$"/root/Level/maze_generation".add_child(new_maze)
	new_maze.position = Vector2(0,540)
