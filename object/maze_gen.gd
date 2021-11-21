extends TileMap

var duplicated = false
var new_maze


func _ready():
	duplicated = false
	print("Camera = " + str($"/root/Level/camera".position) + "\nMap = " + str(position) + "\nMap to Camera = " + str(map_to_camera()))
	$"/root/Level".connect("die", self, "reset")

func _process(delta):
#		print("Camera = " + str($"/root/Level/camera".position) + "\nMap = " + str(position) + "\nMap to Camera = " + str(map_to_camera()))
	if map_to_camera().y <= 348 && duplicated == false:
		duplicated = true
		new_maze = duplicate()
		$"/root/Level/maze_generation".add_child(new_maze)
		new_maze.position.y = (position.y + 192)
	if map_to_camera().y <= -100:
		queue_free()

func map_to_camera() -> Vector2:
	return -$"/root/Level/camera".position + position

func reset():
	position.y = 540
	duplicated = false
