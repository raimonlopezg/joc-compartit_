extends CanvasLayer


func _on_coche_velocitat_canviada(velocitat):
	$"agulla".rotation_degrees = 1.82 * velocitat -224.6
