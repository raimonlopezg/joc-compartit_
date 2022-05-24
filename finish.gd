extends Control

func _on_Button_next_pressed():
	get_tree().change_scene("res://escenas/mapas/escena 2.tscn")
func _on_Button_restart_pressed():
	get_tree().change_scene("res://escenas/mapas/escena 1.tscn")
func _on_Button_menu_pressed():
	get_tree().change_scene("res://escenas/texto/interfaz .tscn")
