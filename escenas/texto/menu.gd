extends Control

func _on_Button_pressed():
	#mapa1
	get_tree().change_scene("res://escenas/mapas/escena 1.tscn")

func _on_Button2_pressed():
	#mapa2
	get_tree().change_scene("res://escenas/mapas/escena 2.tscn")
	
func _on_Button3_pressed():
	#return
	get_tree().change_scene("res://escenas/texto/interfaz .tscn")
