extends Node2D

var worldstate
var worldspeed
var is_just_starting = true
signal die

func _ready() -> void:
	l0nkLib.playMus($bckgndMus, 6, true)
	worldstate = "menu"


func _process(delta):
	checkforcode()
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
	print("sun")
	worldstate = "menu"
	is_just_starting = true
	emit_signal("die")
	var skip_first_child = false
	for _i in $maze_generation.get_children():
		if skip_first_child == false:
			skip_first_child = true
		else: _i.queue_free()
	l0nkLib.playMus($bckgndMus, 6, true)

func checkforcode():
	if "elpepe" in l0nkLib.codes:
		l0nkLib.elpepe = !l0nkLib.elpepe
		l0nkLib.codes =  ""

