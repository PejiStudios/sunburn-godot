extends AudioStreamPlayer

var songs_list = []
#[res://assets/mus/, calm.wav, speedx1.wav, speedx2.wav, speedx3.wav, start.wav, title.wav]

onready var worldspeed = $"/root/Level".worldspeed
onready var worldstate = $"/root/Level".worldstate

func _ready():
	l0nkLib.list_files("res://assets/mus/", songs_list, ".wav")
	print(songs_list)

func _process(delta):
	match $"/root/Level".worldstate:
		"menu":
			l0nkLib.playMus(self, songs_list, 6)
		"heating":
			if $"/root/Level".is_just_starting == true:
				l0nkLib.playMus(self, songs_list, 5)
				$"/root/Level".is_just_starting = false
		"calm":
			l0nkLib.musID = 0
			l0nkLib.playMus(self, songs_list, 1)

func _on_bckgndMus_finished():
	match l0nkLib.musID:
		6:
			l0nkLib.playMus(self, songs_list, 5)
		5:
			l0nkLib.playMus(self, songs_list, 2)
		2:
			l0nkLib.playMus(self, songs_list, 3)
		3:
			l0nkLib.playMus(self, songs_list, 4)
		4:
			l0nkLib.playMus(self, songs_list, 4)
		1:
			l0nkLib.playMus(self, songs_list, 2)
			$"/root/Level".worldstate = "heating"
			$"/root/Level/camera/background_texture/animation".play("heatup")
			$"/root/Level/camera/background_texture".modulate = Color(1,1,1,1)
