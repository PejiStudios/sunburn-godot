extends TileMap

var duplicated = false
var mazes_list
var rng = RandomNumberGenerator.new()


func _ready():
	duplicated = false
	mazes_list = $"/root/Level".mazes_list
	rng.randomize()
	print("Camera = " + str($"/root/Level/camera".position) + "\nMap = " + str(position) + "\nMap to Camera = " + str(map_to_camera()))
	$"/root/Level".connect("die", self, "reset")

func _process(delta):
	if map_to_camera().y <= 348 && duplicated == false:
		duplicated = true
		var rand_maze = random_entry(mazes_list)
		print(rand_maze)
		var load_maze = load(rand_maze)
		var new_maze = load_maze.instance()
		$"/root/Level/maze_generation".add_child(new_maze)
		new_maze.position.y = (position.y + 192)
	if map_to_camera().y <= -100:
		queue_free()

func get_random_entry(array):
	return array[randi() % array.size()]

func map_to_camera() -> Vector2:
	return -$"/root/Level/camera".position + position

func random_entry(origin: Array):
	return str(origin[0]) + str(origin[rng.randi_range(1,origin.size()-1)])

func reset():
	position.y = 540
	duplicated = false
