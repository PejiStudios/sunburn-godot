extends Node2D

var worldstate
var worldspeed
var is_just_starting = true
signal die

func _ready() -> void:
	l0nkLib.playMus($bckgndMus, 6, true)
	worldstate = "menu"


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
	worldstate = "menu"
	is_just_starting = true
	var skip_first_child = false
	for _i in $maze_generation.get_children():
		if skip_first_child == false:
			skip_first_child = true
		else: _i.queue_free()
	l0nkLib.playMus($bckgndMus, 6, true)

func _unhandled_input(event):
	if Input.is_action_just_pressed("backspace"):
		$Player.position.y = 88.396
		touched_sun()
	if Input.is_action_just_pressed("enter") and worldstate == "menu":
		worldstate = "heating"
		$camera/background_texture/animation.play("heatup")
		l0nkLib.playMus($bckgndMus, 5, true)


func save():
	var gen_script = load("res://object/mazes/maze_gen.gd")
	var packed_scene = PackedScene.new()
	var map = $maze_generation/maze_editor.duplicate()
	var fire = $maze_generation/maze_editor/dmg.duplicate()
	var tree = $maze_generation/maze_editor/trees.duplicate()
	map.add_child(tree)
	map.add_child(fire)
	fire.owner = map
	tree.owner = map
	fire.name = "dmg"
	tree.name = "trees"
	map.set_script(gen_script)
	packed_scene.pack(map)
	print($LineEdit.text)
	ResourceSaver.save("res://object/mazes/" + $LineEdit.text + ".tscn", packed_scene)
