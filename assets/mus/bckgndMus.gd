extends AudioStreamPlayer

var songs_list = []
#[res://assets/mus/, calm.wav, speedx1.wav, speedx2.wav, speedx3.wav, start.wav, title.wav]

onready var worldspeed = $"/root/Level".worldspeed
onready var worldstate = $"/root/Level".worldstate

func _ready():
	l0nkLib.list_files("res://assets/mus/", songs_list, ".wav")
	print(songs_list)

func _process(delta):
	if l0nkLib.elpepe == true:
		l0nkLib.playMus(self, songs_list, 7, true)
		return
	match $"/root/Level".worldstate:
		"menu":
			l0nkLib.playMus(self, songs_list, 6, true)
		"heating":
			if $"/root/Level".is_just_starting == true:
				l0nkLib.playMus(self, songs_list, 5, true)
				$"/root/Level".is_just_starting = false
		"calm":
			pass

func _on_bckgndMus_finished():
	print("finished")
	print(l0nkLib.musID)
	match l0nkLib.musID:
		7:
			l0nkLib.playMus(self, songs_list, 7, true)
		6:
			l0nkLib.playMus(self, songs_list, 6, true)
		5:
			l0nkLib.playMus(self, songs_list, 2, true)
		2:
			l0nkLib.playMus(self, songs_list, 3, true)
		3:
			l0nkLib.playMus(self, songs_list, 4, true)
		4:
			l0nkLib.playMus(self, songs_list, 4, true)
		1:
			l0nkLib.playMus(self, songs_list, 2, true)

