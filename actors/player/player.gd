extends Actor

export var stomp_impulse = 500
var timer = Timer.new()
var playerstate = 0
var soundcount = 0
signal start_scroll
signal died
var x_speed
var y_speed
var sfx_list = []

func _ready() -> void:
	$"/root/Level".connect("die", self, "reset")
	timer.connect("timeout",self,"timeout")
	add_child(timer)

func _process(_delta):
	pass

func _physics_process(_delta: float) -> void:
	if is_on_floor():
		playerstate = 0
	else: playerstate = 1
	match playerstate:
		0:
			movement()
		1:
			movement()
		2:
			pass
		3:
			pass
		4:
			pass

func movement() -> void:
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	x_speed = _velocity.x
	y_speed = _velocity.y

func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		l0nkLib.playMus($jump_channel, 3, false)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var out = linear_velocity
	var is_jump_interrupted = false
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	is_jump_interrupted = true
	if out.y >= 180: out.y = 180
	return out


func reset():
	position.y = position.y - $"/root/Level/camera".pos_before_reset


func fire_death(body):
	l0nkLib.playMus($sfx_channel, 2, false)
	if soundcount == 0: soundcount = 1


func tree_reset(body):
	var cells = body.get_used_cells()
	var tree = body.get_tileset().find_tile_by_name("tree1")
	print(cells[0].x)
	print(tree)
	$"/root/Level/camera/background_texture/animation".stop()
	$"/root/Level/camera/background_texture".modulate = Color(1,1,1,1)
	$"/root/Level".worldspeed = 15
	$"/root/Level".worldstate = "calm"
	body.set_cell(cells[0].x, cells[0].y, tree)
	print(body.get_tileset().find_tile_by_name("tree1"))
	$"/root/Level/bckgndMus".stop()
	l0nkLib.playMus($"/root/Level/bckgndMus",1 ,true)
	timer.start(12.0)

func timeout():
	$"/root/Level".worldstate = "heating"
	$"/root/Level/camera/background_texture/animation".play("heatup")


func _on_sfx_channel_finished():
	match soundcount:
		1:
			l0nkLib.playMus($sfx_channel, 2, false)
			soundcount = 2
		2:
			l0nkLib.playMus($sfx_channel, 2, false)
			soundcount = 3
		3:
			$"/root/Level".touched_sun()
			position.y = 58.395
			l0nkLib.playMus($sfx_channel, 1, false)
			soundcount = 0


func touched_sun(area):
	$"/root/Level".touched_sun()
