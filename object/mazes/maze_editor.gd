extends TileMap

var duplicated = false
var mazes_list
var fires
var fire_frame = 1
var rng = RandomNumberGenerator.new()


func _ready():
	fires = $dmg.get_used_cells()
	duplicated = false
	rng.randomize()
	print("Camera = " + str($"/root/Level/camera".position) + "\nMap = " + str(position) + "\nMap to Camera = " + str(map_to_camera()))
	$"/root/Level".connect("die", self, "reset")

func _process(delta):
	for i in fires:
		$dmg.set_cell(i.x, i.y, get_tileset().find_tile_by_name("fire" + str(fire_frame)))
	if map_to_camera().y <= 348 and duplicated == false and $"/root/Level".worldstate == "heating":
		duplicated = true
		var new_maze = duplicate()
		$"/root/Level/maze_generation".add_child(new_maze)
		new_maze.position.y = (position.y + 192)
	set_cellv(Vector2(15,-11),-1)
	set_cellv(Vector2(15,0),-1)
	if map_to_camera().y <= -100:
		queue_free()
	match fire_frame:
		1:
			fire_frame = 2
		2:
			fire_frame = 1

func get_random_entry(array):
	return array[randi() % array.size()]

func map_to_camera() -> Vector2:
	return -$"/root/Level/camera".position + position

func random_entry(origin: Array):
	return str(origin[0]) + str(origin[rng.randi_range(1,origin.size()-1)])

func reset():
	if $trees.get_used_cells().size() > 0:
		$trees.set_cell($trees.get_used_cells()[0].x,
		$trees.get_used_cells()[0].y, 
		get_tileset().find_tile_by_name("tree2"))
	position.y = 270
	duplicated = false

func _unhandled_input(event):
	var mousepos = get_viewport().get_mouse_position()
	var mouse = world_to_map(mousepos)
	var mouseoffset = Vector2(mouse.x, mouse.y-34.5)/2
	if Input.is_action_pressed("mouse1"):
		set_cellv(mouseoffset, get_tileset().find_tile_by_name("0sA"))
	if Input.is_action_pressed("mouse2"):
		set_cellv(mouseoffset, -1)
		$trees.set_cellv(mouseoffset, -1)
		$dmg.set_cellv(mouseoffset, -1)
	if Input.is_action_pressed("T"):
		$trees.set_cellv(mouseoffset, get_tileset().find_tile_by_name("tree2"))
	if Input.is_action_pressed("R"):
		$dmg.set_cellv(mouseoffset, get_tileset().find_tile_by_name("fire1"))
