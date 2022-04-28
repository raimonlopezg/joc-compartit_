extends KinematicBody2D

var velocitat := Vector2.ZERO
var acceleracio := Vector2.ZERO
var direccio := Vector2.RIGHT
var velocitat_max := 110
var velocitat_zero = 0
var num_voltes = -2
var velocitat_gir = 150

var angle = 0

func _physics_process(delta) :

	if Input.is_action_pressed("W") :
		acceleracio = direccio * 65
	else :
		velocitat = direccio * lerp(velocitat.length(), 0, 2/(velocitat.length()+1))
		
	if Input.is_action_pressed("S") :
		acceleracio = direccio * -30
	
	if Input.is_action_pressed("A"):
		velocitat = velocitat.rotated(-deg2rad(velocitat_gir) * delta)
	if Input.is_action_pressed("D"):
		velocitat = velocitat.rotated(deg2rad(velocitat_gir) * delta)
		
	
	velocitat += acceleracio * delta
	if velocitat.length() > velocitat_max :
		velocitat = velocitat.normalized() * velocitat_max
	
	velocitat =  move_and_slide(velocitat)
	rotation = velocitat.angle()
	
	if not velocitat.is_equal_approx(Vector2.ZERO) :
		direccio = velocitat.normalized()
	
func _on_meta_body_entered(body):
	num_voltes = num_voltes + 1 
	print ("portes ",num_voltes," voltes acabades")


func _on_boxes_body_exited(body):
	velocitat_max = 110
func _on_boxes_body_entered(body):
	velocitat_max = 60

