extends KinematicBody2D


var velocitat := Vector2.ZERO
var acceleracio := Vector2.ZERO
var direccio := Vector2.RIGHT
var velocitat_max := 150
var velocitat_zero = 0
func _physics_process(delta):
	if Input.is_action_pressed("W"):
		acceleracio = direccio * 75
	else:
		velocitat = lerp(velocitat, Vector2.ZERO, 2/(velocitat.length()+1))

	velocitat += acceleracio * delta
	if velocitat.length() > velocitat_max :
		velocitat = velocitat.normalized() * velocitat_max
	
	velocitat =  move_and_slide(velocitat)
	if not velocitat.is_equal_approx(Vector2.ZERO):
		direccio = velocitat.normalized()
