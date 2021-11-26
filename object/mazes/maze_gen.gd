extends TileMap

var duplicated = false
var dmg
var trees
var mazes_list
var fires
var fire_frame = 1
var rng = RandomNumberGenerator.new()


func _ready():
	dmg = get_children()[1]
	trees = get_children()[0]
	fires = dmg.get_used_cells()
	duplicated = false
	rng.randomize()
	print("Camera = " + str($"/root/Level/camera".position) + "\nMap = " + str(position) + "\nMap to Camera = " + str(map_to_camera()))
	$"/root/Level".connect("die", self, "reset")

func _process(delta):
	for i in fires:
		dmg.set_cell(i.x, i.y, get_tileset().find_tile_by_name("fire" + str(fire_frame)))
	if map_to_camera().y <= 348 and duplicated == false:
		duplicated = true
		var rand_maze = random_entry(l0nkLib.mazes_list)
		print(rand_maze)
		var load_maze = load(rand_maze)
		var new_maze = load_maze.instance()
		$"/root/Level/maze_generation".add_child(new_maze)
		new_maze.position.y = (position.y + 192)
	
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

