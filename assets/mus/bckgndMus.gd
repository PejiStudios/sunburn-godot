extends AudioStreamPlayer

func finished_bgm():
	match l0nkLib.musID:
		6:
			l0nkLib.playMus(self, 6, true)
		5:
			l0nkLib.playMus(self, 2, true)
		2:
			l0nkLib.playMus(self, 3, true)
		3:
			l0nkLib.playMus(self, 4, true)
		4:
			l0nkLib.playMus(self, 4, true)
		1:
			l0nkLib.playMus(self, 2, true)


func _on_elpepe_finished():
	$"/root/Level/elpepe".play()
	
